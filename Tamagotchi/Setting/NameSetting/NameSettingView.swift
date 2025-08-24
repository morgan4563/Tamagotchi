//
//  NameSettingView.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/25/25.
//

import UIKit
import SnapKit

class NameSettingView: BaseView {

    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "이름을 입력해주세요"
        tf.font = .systemFont(ofSize: 15)
        tf.textColor = .tamagochiLine

        return tf
    }()

    let underLine: UIView = {
		let iv = UIView()
        iv.backgroundColor = .tamagochiLine
        return iv
    }()

    override func configureHierarchy() {
		addSubview(nameTextField)
        addSubview(underLine)
    }

    override func configureLayout() {
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }

        underLine.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(nameTextField)
            make.height.equalTo(1)
        }
    }

    override func configureView() {
        super.configureView()
    }
}
