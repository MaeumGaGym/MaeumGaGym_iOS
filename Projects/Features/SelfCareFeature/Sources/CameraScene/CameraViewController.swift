import UIKit
import MGNetworks
import Photos

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

    private var captureButton = MGButton(
        titleText: "",
        image: SelfCareResourcesService.Assets.camera,
        textColor: .black
    )

    private var photoButton = MGButton(
        titleText: "",
        image: SelfCareResourcesService.Assets.photo,
        textColor: .black,
        backColor: DSKitAsset.Colors.gray800.color
    ).then {
        $0.setCornerRadius(radius: 26.0)
    }

    private var chageButton = MGButton(
        titleText: "",
        image: SelfCareResourcesService.Assets.ture,
        textColor: .black,
        backColor: DSKitAsset.Colors.gray800.color
    ).then {
        $0.setCornerRadius(radius: 26.0)
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
            .subscribe(with: self, onNext: { owner, _ in
                owner.reversal()
            })
            .disposed(by: disposeBag)

        captureButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.capture()
            })
            .disposed(by: disposeBag)

        photoButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.requestAlbum()
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

    private func requestAlbum() {
        self.requestAlbumAuthorization { isAuthorized in
            if isAuthorized {
                PhotoService.shared.getAlbums(mediaType: .image, completion: { [weak self] albums in
                    DispatchQueue.main.async {
                        let photoViewController = AlbumViewController(albums: albums)
                        photoViewController.modalPresentationStyle = .fullScreen
                        self?.present(photoViewController, animated: true)
                    }
                })
            } else {
                self.showAlertGoToSetting(
                    title: "현재 앨범 사용에 대한 접근 권한이 없습니다.",
                    message: "설정 > {앱 이름} 탭에서 접근을 활성화 할 수 있습니다."
                )
            }
        }
    }

    func requestAlbumAuthorization(completion: @escaping (Bool) -> Void) {
        if #available(iOS 14.0, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                completion([.authorized, .limited].contains(where: { $0 == status }))
            }
        } else {
            PHPhotoLibrary.requestAuthorization { status in
                completion(status == .authorized)
            }
        }
    }

    func showAlertGoToSetting(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let cancelAlert = UIAlertAction(
            title: "취소",
            style: .cancel
        ) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        let goToSettingAlert = UIAlertAction(
            title: "설정으로 이동하기",
            style: .default) { _ in
                guard
                    let settingURL = URL(string: UIApplication.openSettingsURLString),
                    UIApplication.shared.canOpenURL(settingURL)
                else { return }
                UIApplication.shared.open(settingURL, options: [:])
            }
        [cancelAlert, goToSettingAlert]
            .forEach(alertController.addAction(_:))
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }

    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        let zoomFactor = cameraView.handleZoomGesture(pinchGesture: gesture)
        print("Zoom factor: \(zoomFactor)")
    }
}
