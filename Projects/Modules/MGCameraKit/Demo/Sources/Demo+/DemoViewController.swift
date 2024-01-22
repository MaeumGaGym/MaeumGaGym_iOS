import UIKit
import SnapKit
import Then
import MGCameraKit

public class DemoViewController: UIViewController {
    
    var cameraView: MGCamera!
    var captureButton: UIButton!
    var gridView: MGridView!
    
    var isOn = false
    var gridOn = false
    var touchShootOn = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        cameraView = MGCamera(frame: CGRect(x: 0, y: 0, width: 350, height: 480))
        view.addSubview(cameraView)
        cameraView.setAspectRatio(.full)
        cameraView.setBackgroundColor(.white)
        cameraView.setFlashMode(.off)
        cameraView.setCameraPosition(.back)
        
//        gridView = MGridView(frame: cameraView.frame)
//        gridView.isUserInteractionEnabled = false
//        view.addSubview(gridView)
        
//        captureButton.layer.cornerRadius = 50.0
        
        cameraView.startRunning()
//        updateGridViewSize()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        updateGridViewSize()
        layout()
    }
    
    func layout() {
        
        cameraView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(90.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(430.0)
        }
    }
    
//    func updateGridViewSize() {
//        let cameraViewSize = cameraView.frame.size
//        let gridSize = CGSize(width: cameraViewSize.width, height: cameraViewSize.width)
//        let gridOrigin = CGPoint(x: cameraView.frame.origin.x,
//                                 y: cameraView.frame.origin.y + (cameraViewSize.height - gridSize.height) / 2)
//        gridView.frame = CGRect(origin: gridOrigin, size: gridSize)
//    }
    
    func GridButtonDidTap(_ sender: Any) {
        gridOn.toggle()
        gridView.isHidden = !gridOn
    }
    
    func ButtonDidTap(_ sender: Any) {
        print("capture")
        cameraView.capturePhoto { result in
            switch result {
            case .success(let image):
                print("사진 저장")
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            case .failure(let error):
                print("저장 실패 \(error)")
            }
        }
    }
    
    func LightButtonDidTap(_ sender: Any) {
        isOn.toggle()
        
        if isOn {
            cameraView.setFlashMode(.on)
            print("on")
        } else {
            cameraView.setFlashMode(.off)
            print("off")
        }
    }
    
    func ReversalDidTap(_ sender: Any) {
        isOn.toggle()
        
        if isOn {
            cameraView.setCameraPosition(.back)
            print("back")
        } else {
            cameraView.setCameraPosition(.front)
            print("front")
        }
    }
    
    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        let zoomFactor = cameraView.handleZoomGesture(pinchGesture: gesture)
        print("Zoom factor: \(zoomFactor)")
    }
    
}
