import UIKit

import RxSwift
import RxCocoa

import Core
import DSKit
import MGCameraKit

public class CameraViewController: BaseViewController<CameraViewModel> {
    private lazy var navBar = CameraNavigationBar()

    private var isOn = true

    private var cameraView = MGCamera(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: 430,
                                                    height: 573)).then {
        $0.setAspectRatio(.full)
        $0.setBackgroundColor(.white)
        $0.setFlashMode(.off)
        $0.setCameraPosition(.back)
    }

    private var captureButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.cameraButton.image, for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }

    private var photoButton = UIButton().then {
        $0.backgroundColor = DSKitAsset.Colors.gray800.color
        $0.setImage(DSKitAsset.Assets.image.image, for: .normal)
        $0.layer.cornerRadius = 26.0
        $0.setTitleColor(.black, for: .normal)
    }
    private var chageButton = UIButton().then {
        $0.backgroundColor = DSKitAsset.Colors.gray800.color
        $0.setImage(DSKitAsset.Assets.turn.image, for: .normal)
        $0.layer.cornerRadius = 26.0
        $0.setTitleColor(.black, for: .normal)
    }

    public override func configureNavigationBar() {
        super.configureNavigationBar()

        navigationController?.isNavigationBarHidden = true
    }

    public override func layout() {
        super.layout()

        view.addSubviews([navBar, cameraView])
        view.addSubviews([captureButton, photoButton, chageButton])

        navBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        cameraView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(573.0)
        }

        captureButton.snp.makeConstraints {
            $0.top.equalTo(cameraView.snp.bottom).offset(72.0)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(80.0)
        }

        photoButton.snp.makeConstraints {
            $0.centerY.equalTo(captureButton)
            $0.trailing.equalTo(captureButton.snp.leading).offset(-83)
            $0.height.width.equalTo(52.0)
        }

        chageButton.snp.makeConstraints {
            $0.centerY.equalTo(captureButton)
            $0.leading.equalTo(captureButton.snp.trailing).offset(83)
            $0.height.width.equalTo(52.0)
        }
    }

    public override func attribute() {
        super.attribute()
        view.backgroundColor = .black
        cameraView.startRunning()
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        cameraView.addGestureRecognizer(pinchGesture)
    }

    public override func bindViewModel() {
        super.bindViewModel()

        chageButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                owner.reversal()
            })
            .disposed(by: disposeBag)

        captureButton.rx.tap
            .subscribe(with: self, onNext: { owner, _  in
                owner.capture()
            })
            .disposed(by: disposeBag)
    }

    public func capture() {
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

    public func reversal() {
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
