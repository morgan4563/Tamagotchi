//
//  LottoView.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/26/25.
//

import UIKit

final class LottoView: BaseView {
    let numberTextField: UITextField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 15, weight: .semibold)
        tf.borderStyle = .roundedRect
        tf.placeholder = "회차를 입력해주세요."

        return tf
    }()

    let fetchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .red

        return button
    }()

    let resultLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "여기에 로또 결과가 표시됩니다."
        label.numberOfLines = 2

        return label
    }()

    override func configureHierarchy() {
        addSubview(numberTextField)
        addSubview(fetchButton)
        addSubview(resultLable)
    }

    override func configureLayout() {
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
        }

        fetchButton.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(32)
            make.centerX.equalTo(numberTextField)
        }

        resultLable.snp.makeConstraints { make in
            make.top.equalTo(fetchButton.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
    }
}
