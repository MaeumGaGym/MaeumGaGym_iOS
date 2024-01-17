import Foundation
import UIKit
import RxSwift
import RxCocoa
import Then
import AVFoundation

open class MGCameraKit: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    let captureSession = AVCaptureSession()
    var cameraDevice: AVCaptureDevice!
    var cameraInput: AVCaptureDeviceInput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var stillImageOutput: AVCapturePhotoOutput!
    var captureCompletion: ((Result<UIImage, Error>) -> Void)? // 카메라 캡처 핸들러
    
    private let minimumZoom: CGFloat = 1.0 // 최소 줌
    private let maximumZoom: CGFloat = 5.0 // 초대 줌
    private var lastZoomFactor: CGFloat = 1.0
    
    // 카메라 비율
    var aspectRatio: MGCameraAspectRatio = .full
    
    // 카메라 후레시 코드 (어두우면 발동?)
    var flashMode: AVCaptureDevice.FlashMode = .off
    
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
        
        let previewLayerFrame = CGRect(origin: .zero, size: size)
        previewLayer.frame = previewLayerFrame
        
        //Center code
        previewLayer.position = CGPoint(x: bounds.width / 2, y: bounds.maxY / 2)
    }
    
    private func commonInit() {
        
        /// AVCaptureDevice
        let cameraDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)
        
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
        
        // Initialize AVCapturePhotoOutput for photo capture
        stillImageOutput = AVCapturePhotoOutput()
        if captureSession.canAddOutput(stillImageOutput) {
            captureSession.addOutput(stillImageOutput)
        }
    }
}
