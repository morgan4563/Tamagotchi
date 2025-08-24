//
//  SettingView.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit
import SnapKit

class SettingView: BaseView {
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = .tamagochiBackground
        return tv
    }()

    override func configureHierarchy() {
        addSubview(tableView)
    }

    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }

    override func configureView() {
        super.configureView()
    }

}
