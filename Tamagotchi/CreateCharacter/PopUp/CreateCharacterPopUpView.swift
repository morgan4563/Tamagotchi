//
//  CreateCharacterPopUpView.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit
import SnapKit

final class CreateCharacterPopUpView: BaseView {
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        return view
    }()

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tamagochiBackground
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .tamagochiLine

        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.tamagochiLine.cgColor
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()

    let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = .tamagochiLine
        return view
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 5
        label.textColor = .tamagochiLine
        return label
    }()

    let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually

        return stack
    }()

    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(UIColor.tamagochiLine, for: .normal)
        return button
    }()

    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(UIColor.tamagochiLine, for: .normal)
        return button
    }()

    override func configureHierarchy() {
		addSubview(backgroundView)

        backgroundView.addSubview(containerView)

        containerView.addSubview(buttonStack)
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(underLine)
        containerView.addSubview(descriptionLabel)

        buttonStack.addArrangedSubview(cancelButton)
        buttonStack.addArrangedSubview(startButton)
    }

    override func configureLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(containerView).inset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }

        underLine.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(underLine.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }

        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
    }

    override func configureView() {
    }
}
