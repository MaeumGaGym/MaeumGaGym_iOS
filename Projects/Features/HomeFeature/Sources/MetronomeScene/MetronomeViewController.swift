import UIKit
import SnapKit
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

    private let tempoStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 10
        stepper.maximumValue = 300
        return stepper
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
        view.addSubview(tempoStepper)
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(vibrateButton)

        tempoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }

        tempoStepper.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tempoLabel.snp.bottom).offset(20)
        }

        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-50)
            $0.top.equalTo(tempoStepper.snp.bottom).offset(20)
        }

        stopButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(50)
            $0.top.equalTo(tempoStepper.snp.bottom).offset(20)
        }

        vibrateButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stopButton.snp.bottom).offset(20)
        }
    }

    private func setupActions() {
        tempoStepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        vibrateButton.addTarget(self, action: #selector(vibrateButtonTapped), for: .touchUpInside)
    }

    @objc private func stepperValueChanged() {
        viewModel.tempo = Int(tempoStepper.value)
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
