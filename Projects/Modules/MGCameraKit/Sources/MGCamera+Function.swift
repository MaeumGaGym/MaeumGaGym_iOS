import Foundation
import UIKit
import AVFoundation
import Core

extension MGCamera {
    /**
     카메라의 배경색을 설정할 수 있습니다.
        - Parameters:
           - color: UIColor
    */
    public func setBackgroundColor(_ color: UIColor = .black) {
        backgroundColor = color
    }
    
    /**
     카메라를 시작합니다.
     - Note: 이 메서드는 AVCaptureDeviceInput 및 AVCaptureSession을 설정하고 시작합니다.
     - Warning: cameraInput이 nil이거나 captureSession이 이미 실행 중인 경우에는 아무 작업도 수행되지 않습니다.
     */
    public func startRunning() {
        if cameraInput != nil && !captureSession.isRunning {
            captureSession.beginConfiguration()
            captureSession.sessionPreset = .high
            if captureSession.canAddInput(cameraInput) {
                captureSession.addInput(cameraInput)
            }
            captureSession.commitConfiguration()
            captureSession.startRunning()
        }
    }
    
    /**
     카메라 세션을 정지시킵니다.
     - Note: 이 메서드는 현재 실행 중인 AVCaptureSession을 정지하여 카메라 입력을 중단합니다.
     - Warning: 이미 정지된 세션에 대해 호출하면 아무런 효과가 없습니다.
     */
    public func stopRunning() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }

    /**
     카메라 화면 비율 변경시킵니다
       - Parameters:
          - aspectRatio: MGCameraAspectRatio
   */
    public func setAspectRatio(_ aspectRatio: MGCameraAspectRatio) {
        self.aspectRatio = aspectRatio
        setNeedsLayout() // 뷰에 layout이 변경되었을 때 뷰에게 알려주는 함수
    }
    
    /**
     카메라 플래시를 켜고 끌 수 있습니다.
       - Parameters:
          - mode: .off or .on
   */
    public func setFlashMode(_ mode: AVCaptureDevice.FlashMode) {
        guard let device = cameraDevice else {
            return
        }
        guard device.hasFlash else {
            return
        }
        do {
            try device.lockForConfiguration()
            let photoSettings = AVCapturePhotoSettings()
            photoSettings.flashMode = mode
            device.unlockForConfiguration()
        } catch {
            print(
                "\(MGCameraKitError.MGCameraError(.noFlash)) ,reason: \(error.localizedDescription)"
            )
        }
    }
    
    /**
     카메라가 향하는 방향을 설정할 수 있습니다.
     카메라가 향하는 방향
       - Parameters:
       - setCameraPosition: CameraPosition
   */
    public func setCameraPosition(_ position: MGCameraPosition) {
        cameraPosition = position
    }
    
    /**
    카메라의 확대 축소를 제어할 수 있습니다.
     - Parameter pinchGesture: 확대/축소 제어를 위한 UIPinchGestureRecognizer.
     - Returns: 반올림된 이중 값으로 표시되는 새로운 확대/축소 수준입니다.
     */
    public func handleZoomGesture(pinchGesture: UIPinchGestureRecognizer) -> Double {
        func calculateZoomFactor(factor: CGFloat) -> CGFloat {
            let minZoomFactor = min(min(max(factor, minimumZoom), maximumZoom),
                                    cameraDevice?.activeFormat.videoMaxZoomFactor ?? 1.0)
            return minZoomFactor
        }
        
        func updateZoom(factor: CGFloat) {
            guard let device = cameraDevice else {
                return
            }
            
            do {
                try device.lockForConfiguration()
                defer {
                    device.unlockForConfiguration()
                }
                
                device.videoZoomFactor = factor
            } catch {
                print("\(MGCameraKitError.MGCameraError(.noZoom)), reason: \(error.localizedDescription)")
            }
        }
        
        let newScaleFactor = calculateZoomFactor(factor: pinchGesture.scale * lastZoomFactor)
        
        switch pinchGesture.state {
        case .began, .changed:
            updateZoom(factor: newScaleFactor)
            
        case .ended:
            lastZoomFactor = calculateZoomFactor(factor: newScaleFactor)
            updateZoom(factor: lastZoomFactor)
            
        default:
            break
        }
        
        return Double(newScaleFactor).rounded(places: 1)
    }
    
    /// 이미지가 저장되었는지 알려주는 코드 현재 카메라 설정을 사용하여 사진을 캡처합니다.
    /// - Parameter completion: 캡처된 이미지 또는 오류를 반환하는 완료 핸들러입니다.
    public func capturePhoto(completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let connection = stillImageOutput.connection(with: .video) else {
            completion(.failure(MGCameraError.captureStillImageOutput))
            return
        }
        
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = flashMode
        
        stillImageOutput.capturePhoto(with: photoSettings, delegate: self)
        
        // AVCapturePhotoCaptureDelegate
        self.captureCompletion = completion
    }
    
    private func savePhotoToLibrary(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    // 이미지가 성공적으로 저장되었는지 알려주는 함수
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("\(MGCameraKitError.MGAlbumError(.saveError)), reason:\(error)")
        } else {
            print("✌️ Image saved successfully ✌️")
        }
    }
}

// AVCapturePhotoCaptureDelegate
extension MGCamera: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            captureCompletion?(.failure(error))
            captureCompletion = nil
            return
        }
        
        guard let imageData = photo.fileDataRepresentation(), let capturedImage = UIImage(data: imageData) else {
            captureCompletion?(.failure(MGCameraError.imageData))
            captureCompletion = nil
            return
        }
        
        captureCompletion?(.success(capturedImage))
        captureCompletion = nil
    }
}
