import UIKit

import RxSwift

import SnapKit
import Then

import DSKit
import Core

import AVFoundation

import AudioToolbox

public class MetronomeViewController: UIViewController {
    private var viewModel: MetronomeViewModel

    private let tempoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let tempoIncrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        return button
    }()

    private let tempoDecrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        return button
    }()

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        return button
    }()

    private let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop", for: .normal)
        return button
    }()

    private let vibrateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Vibrate", for: .normal)
        return button
    }()

    public init(viewModel: MetronomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupActions()
        viewModel.tempo = 180
    }

    private func setupViews() {
        view.addSubview(tempoLabel)
        view.addSubview(tempoIncrementButton)
        view.addSubview(tempoDecrementButton)
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(vibrateButton)

        tempoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }

        tempoIncrementButton.snp.makeConstraints {
            $0.centerY.equalTo(tempoLabel)
            $0.leading.equalTo(tempoLabel.snp.trailing).offset(10)
        }

        tempoDecrementButton.snp.makeConstraints {
            $0.centerY.equalTo(tempoLabel)
            $0.trailing.equalTo(tempoLabel.snp.leading).offset(-10)
        }

        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-50)
            $0.top.equalTo(tempoLabel.snp.bottom).offset(20)
        }

        stopButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(50)
            $0.top.equalTo(tempoLabel.snp.bottom).offset(20)
        }

        vibrateButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stopButton.snp.bottom).offset(20)
        }
    }

    private func setupActions() {
        tempoIncrementButton.addTarget(self, action: #selector(incrementButtonTapped), for: .touchUpInside)
        tempoDecrementButton.addTarget(self, action: #selector(decrementButtonTapped), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        vibrateButton.addTarget(self, action: #selector(vibrateButtonTapped), for: .touchUpInside)
    }

    @objc private func incrementButtonTapped() {
        viewModel.tempo += 1
        tempoLabel.text = "Tempo: \(viewModel.tempo)"
    }

    @objc private func decrementButtonTapped() {
        viewModel.tempo -= 1
        tempoLabel.text = "Tempo: \(viewModel.tempo)"
    }

    @objc private func startButtonTapped() {
        viewModel.start()
    }

    @objc private func stopButtonTapped() {
        viewModel.stop()
    }

    @objc private func vibrateButtonTapped() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

extension MetronomeViewController: MetronomeViewModelDelegate {
    public func didUpdateTempo(tempo: Int) {
        tempoLabel.text = "Tempo: \(tempo)"
    }
}
