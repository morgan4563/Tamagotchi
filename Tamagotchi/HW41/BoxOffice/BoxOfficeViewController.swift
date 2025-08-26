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
        //TODO: 0828 질문 2. debounce 이야기 해주셨는데. 지금처럼 버튼 클릭으로 진행 할 떄는 withLatestFrom 으로 텍스트를 받아와서 필요 없지 않을까 고민.
//        rootView.searchBar.rx.text.orEmpty
//            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()

        let input = BoxOfficeViewModel.Input(searchTap: rootView.searchBar.rx.searchButtonClicked, searchText: rootView.searchBar.rx.text.orEmpty)

        let output = viewModel.transform(input: input)

        output.list
            .bind(to: rootView.tableView.rx.items(cellIdentifier: BoxOfficeTableViewCell.identifier, cellType: BoxOfficeTableViewCell.self)) {row, element, cell in
                let text = "랭크: \(element.rank), 제목: \(element.movieNm)"
                cell.movieNameLabel.text = text
            }
            .disposed(by: disposeBag)

        output.showAlert
            .bind(with: self) { owner, _ in
                let alertController = UIAlertController(title: "에러발생", message: "올바른 값을 입력해주세요", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(action)
                owner.present(alertController, animated: true)
                owner.rootView.searchBar.text = ""
            }
            .disposed(by: disposeBag)
    }
}
