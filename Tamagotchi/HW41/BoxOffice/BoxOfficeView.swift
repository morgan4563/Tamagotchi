//
//  BoxOfficeView.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/26/25.
//

import UIKit
import SnapKit

final class BoxOfficeView: BaseView {

    let searchBar = UISearchBar()

    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
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

    override func configureView() { }
}
