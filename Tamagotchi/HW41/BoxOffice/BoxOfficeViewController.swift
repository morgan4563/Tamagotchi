//
//  BoxOfficeViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/25/25.
//

import UIKit
import SnapKit
import Alamofire
import RxSwift
import RxCocoa

struct MovieRequest: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [Movie]
}

struct Movie: Decodable {
    let rank: String
    let movieNm: String
}

class BoxOfficeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let list: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        bind()

        navigationItem.titleView = searchBar
    }
    let searchBar = UISearchBar()

    let tableView: UITableView = {
		let tv = UITableView()
        tv.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        return tv
    }()

    func configureHierarchy() {
        view.addSubview(tableView)
    }

    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func bind() {
		list
            .bind(to: tableView.rx.items(cellIdentifier: BoxOfficeTableViewCell.identifier, cellType: BoxOfficeTableViewCell.self)) {row, element, cell in
                let text = "랭크: \(element.rank), 제목: \(element.movieNm)"
                cell.movieNameLabel.text = text
            }
            .disposed(by: disposeBag)

        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getMovie(query: text)
            }
            .debug("서치바")
            .subscribe(with: self) { owner, movie in
                let movieArray = movie.boxOfficeResult.dailyBoxOfficeList
                owner.list.accept(movieArray)
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
    }
}
