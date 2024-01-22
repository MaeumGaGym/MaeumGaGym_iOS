import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import MGCameraKit

public class DemoViewController: UIViewController {
    
    private var cameraView: MGCamera!
    private var gridView: MGridView!
    
    private var captureButton = UIButton().then {
        $0.backgroundColor = .red
        $0.setTitle("사진", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    private var photoButton = UIButton().then {
        $0.backgroundColor = .red
        $0.setTitle("앨범", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    private var chageButton = UIButton().then {
        $0.backgroundColor = .red
        $0.setTitle("뒤집기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    private  var buttomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 83.0
        $0.distribution = .fillEqually
    }
    
    private var isOn = true
    private var gridOn = false
    private var touchShootOn = false
    
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
        
        view.addSubview(buttomStackView)
        buttomStackView.addArrangedSubviews(photoButton, captureButton, chageButton)
        
        chageButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                owner.reversalDidTap()
            })
        
        captureButton.rx.tap
            .bind {
                self.buttonDidTap()
            }
        
        title = "사진 촬영"
        
        buttonDidTap()
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
        
        captureButton.snp.makeConstraints {
            $0.height.equalTo(buttomStackView.snp.height).dividedBy(3)
        }
        
        photoButton.snp.makeConstraints {
            $0.height.equalTo(buttomStackView.snp.height).dividedBy(3)
        }
        
        chageButton.snp.makeConstraints {
            $0.height.equalTo(buttomStackView.snp.height).dividedBy(3)
        }
        
        buttomStackView.snp.makeConstraints {
            $0.top.equalTo(cameraView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(40.0)
        }
    }
    
    func buttonDidTap() {
        print("capture")
        cameraView.capturePhoto { result in
            switch result {
            case .success(let image):
                print("사진 저장")
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            case .failure(let error):
                print("저장 실패: \(error)")
            }
        }
    }
    
    func lightButtonDidTap(_ sender: Any) {
        isOn.toggle()
        
        if isOn {
            cameraView.setFlashMode(.on)
            print("on")
        } else {
            cameraView.setFlashMode(.off)
            print("off")
        }
    }
    
    func reversalDidTap() {
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
