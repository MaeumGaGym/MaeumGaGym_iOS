import Foundation
import UIKit
import RxSwift
import RxCocoa
import Then
import AVFoundation

open class MGCamera: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    let captureSession = AVCaptureSession()
    var cameraDevice: AVCaptureDevice!
    var cameraInput: AVCaptureDeviceInput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var stillImageOutput: AVCapturePhotoOutput!
    var captureCompletion: ((Result<UIImage, Error>) -> Void)? // 카메라 캡처 핸들러
    
    public let minimumZoom: CGFloat = 1.0 // 최소 줌
    public let maximumZoom: CGFloat = 5.0 // 초대 줌
    public var lastZoomFactor: CGFloat = 1.0
    
    // 카메라 비율
    var aspectRatio: MGCameraAspectRatio = .full
    
    // 카메라 후레시 코드 (어두우면 발동?)
    var flashMode: AVCaptureDevice.FlashMode = .off
    
    /// 기본 카메라의 방향은 후방입니다.
    var cameraPosition: MGCameraPosition = .back {
        didSet {
            guard let currentInput = cameraInput else {
                return
            }
            captureSession.beginConfiguration()
            captureSession.removeInput(currentInput)
            
            let newPosition: AVCaptureDevice.Position = (cameraPosition == .back) ? .back : .front
            let newCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: newPosition)
            do {
                let newInput = try AVCaptureDeviceInput(device: newCameraDevice!)
                if captureSession.canAddInput(newInput) {
                    captureSession.addInput(newInput)
                    cameraInput = newInput
                    cameraDevice = newCameraDevice
                } else {
                    captureSession.addInput(currentInput)
                }
            } catch {
                captureSession.addInput(currentInput)
                print("Error creating AVCaptureDeviceInput: \(error.localizedDescription)")
            }
            
            captureSession.commitConfiguration()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // AVCaptureVideoPreviewLayer frame == MGCamera UIview bounds
        previewLayer.frame = bounds
        
        let size: CGSize
        switch aspectRatio {
        case .square: // 1 : 1
            size = CGSize(width: min(bounds.width, bounds.height), height: min(bounds.width, bounds.height))
        case .full: // UIView 전체
            size = bounds.size
        case .portrait: // length 16 : 9
            size = CGSize(width: bounds.height * 9 / 16, height: bounds.height)
        case .landscape: // width 16 : 9
            size = CGSize(width: bounds.width, height: bounds.width * 3 / 4)
        case .custom(let width, let height):
            size = CGSize(width: width, height: height)
        }
        
        // AVCaptureVideoPreviewLayer는 객체를 받아서 해야합니다.
        // 말 그대로 layer라서 UIView를 만들어야합니다.
        let previewLayerFrame = CGRect(origin: .zero, size: size)
        previewLayer.frame = previewLayerFrame
        
        // 센터에 박는 코드 추가
        previewLayer.position = CGPoint(x: bounds.width / 2, y: bounds.maxY / 2)
    }
    
    private func commonInit() {
        
        /// AVCaptureDevice
        let cameraDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .back
        )
        
        cameraDevice = cameraDeviceDiscoverySession.devices.first
        
        // make AVCaptureDeviceInput
        do {
            cameraInput = try AVCaptureDeviceInput(device: cameraDevice)
        } catch let error {
            print("\(MGCameraKitError.MGCameraError(.noCapturing)) , reason: \(error.localizedDescription)")
            return
        }
        
        // make AVCaptureVideoPreviewLayer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(previewLayer)
        
        // AVCapturePhotoOutput 초기화
        // AVCapturePhotoOutput는 화면을 캡쳐하는 코드인데
        // captureSession 안에 넣는다는 의미는 카메라의 정적이미지를 캡처하고 그 결과를 처리할 수 있도록 해줍니다
        stillImageOutput = AVCapturePhotoOutput()
        if captureSession.canAddOutput(stillImageOutput) {
            captureSession.addOutput(stillImageOutput)
        }
    }
}
