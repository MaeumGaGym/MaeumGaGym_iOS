import UIKit
import SnapKit
import Then
import MGCameraKit
import MGLogger

public class DemoViewController: UIViewController {
    
    var cameraView: MGCamera!
    var captureButton: UIButton!
    var gridView: MGridView!
    
    var isOn = false
    var gridOn = false
    var touchShootOn = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        cameraView = MGCamera(frame: CGRect(x: 0, y: 0, width: 430, height: 573))
        view.addSubview(cameraView)
        cameraView.setAspectRatio(.full)
        cameraView.setBackgroundColor(.white)
        cameraView.setFlashMode(.off)
        cameraView.setCameraPosition(.back)
        cameraView.startRunning()
        
        title = "사진 촬영"
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    func layout() {
        cameraView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(573.0)
        }
    }
    
    func buttonDidTap(_ sender: Any) {
        print("capture")
        cameraView.capturePhoto { result in
            switch result {
            case .success(let image):
                MGLogger.debug("사진 저장")
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            case .failure(let error):
                MGLogger.error("저장 실패: \(error)")
            }
        }
    }
    
    func lightButtonDidTap(_ sender: Any) {
        isOn.toggle()
        
        if isOn {
            cameraView.setFlashMode(.on)
            MGLogger.debug("on")
        } else {
            cameraView.setFlashMode(.off)
            MGLogger.debug("off")
        }
    }
    
    func reversalDidTap(_ sender: Any) {
        isOn.toggle()
        
        if isOn {
            cameraView.setCameraPosition(.back)
            MGLogger.debug("back")
        } else {
            cameraView.setCameraPosition(.front)
            MGLogger.debug("front")
        }
    }
    
    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        let zoomFactor = cameraView.handleZoomGesture(pinchGesture: gesture)
        print("Zoom factor: \(zoomFactor)")
    }
    
}
