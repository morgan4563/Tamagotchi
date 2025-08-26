//
//  BoxOfficeViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/25/25.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class BoxOfficeViewController: UIViewController {
    private let rootView = BoxOfficeView()
    private let viewModel = BoxOfficeViewModel()
    private let disposeBag = DisposeBag()


    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        navigationItem.titleView = rootView.searchBar
    }

    func bind() {
        let input = BoxOfficeViewModel.Input(searchTap: rootView.searchBar.rx.searchButtonClicked, searchText: rootView.searchBar.rx.text.orEmpty)

        let output = viewModel.transform(input: input)

        output.list
            .bind(to: rootView.tableView.rx.items(cellIdentifier: BoxOfficeTableViewCell.identifier, cellType: BoxOfficeTableViewCell.self)) {row, element, cell in
                let text = "랭크: \(element.rank), 제목: \(element.movieNm)"
                cell.movieNameLabel.text = text
            }
            .disposed(by: disposeBag)
    }
}
