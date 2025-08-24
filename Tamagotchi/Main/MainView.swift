//
//  MainView.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit
import SnapKit

class MainView: BaseView {
    let bubbleContainerView: UIImageView = {
		let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "bubble")
        return iv
    }()

    let bubbleMessage: UILabel = {
		let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .tamagochiLine
        label.textAlignment = .center
        label.numberOfLines = 4
        label.text = "복습 아직 안 하셨다구용? 지금 잠이 오세요? ㄷㄷ" // 나중에 제거 임시
        return label
    }()

    let characterImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "noImage")
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .tamagochiLine
        label.text = "방실방실 다마고치" // 나중에 저거 임시
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 3
        label.layer.borderColor = UIColor.tamagochiLine.cgColor
        label.clipsToBounds = true
        return label
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .tamagochiLine
        label.text = "LV1 밥알 0개 물방울 0개" // 나중에 저거 임시
    	return label
    }()

    let riceTextField: UITextField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 15)
        tf.textColor = .tamagochiLine
        tf.placeholder = "밥주세용"
        tf.textAlignment = .center
        return tf
    }()

    let riceUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .tamagochiLine
        return view
    }()

    let riceButton: UIButton = {
		let button = UIButton()
        button.setTitle("밥먹기", for: .normal)
        button.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        button.tintColor = .tamagochiLine
        button.setTitleColor(.tamagochiLine, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tamagochiLine.cgColor

        return button
    }()

    let waterTextField: UITextField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 15)
        tf.textColor = .tamagochiLine
        tf.placeholder = "물주세용"
        tf.textAlignment = .center
        return tf
    }()

    let waterUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .tamagochiLine
        return view
    }()

    let waterButton: UIButton = {
        let button = UIButton()
        button.setTitle("물먹기", for: .normal)
        button.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        button.tintColor = .tamagochiLine
        button.setTitleColor(.tamagochiLine, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tamagochiLine.cgColor

        return button
    }()

    override func configureHierarchy() {
        addSubview(bubbleContainerView)
        bubbleContainerView.addSubview(bubbleMessage)

        addSubview(characterImage)
        addSubview(nameLabel)
        addSubview(statusLabel)

        addSubview(riceTextField)
        addSubview(riceUnderLine)
        addSubview(riceButton)

        addSubview(waterTextField)
        addSubview(waterUnderLine)
        addSubview(waterButton)
    }

    override func configureLayout() {
        bubbleContainerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(48)
            make.height.equalTo(160)
        }
        bubbleMessage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }

        characterImage.snp.makeConstraints { make in
            make.top.equalTo(bubbleContainerView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
            make.height.equalTo(32)
        }

        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        riceTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(32)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }

        riceUnderLine.snp.makeConstraints { make in
            make.top.equalTo(riceTextField.snp.bottom)
            make.horizontalEdges.equalTo(riceTextField)
            make.height.equalTo(1)
        }

        riceButton.snp.makeConstraints { make in
            make.centerY.equalTo(riceTextField)
            make.leading.equalTo(riceTextField.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(32)
            make.height.equalTo(44)
        }

        waterTextField.snp.makeConstraints { make in
            make.top.equalTo(riceUnderLine.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(riceTextField)
            make.height.equalTo(44)
        }

        waterUnderLine.snp.makeConstraints { make in
            make.top.equalTo(waterTextField.snp.bottom)
            make.horizontalEdges.equalTo(waterTextField)
            make.height.equalTo(1)
        }

        waterButton.snp.makeConstraints { make in
            make.centerY.equalTo(waterTextField)
            make.leading.equalTo(waterTextField.snp.trailing).offset(12)
            make.trailing.equalTo(riceButton)
            make.height.equalTo(44)
        }
    }

    override func configureView() {
		super.configureView()
    }
}
