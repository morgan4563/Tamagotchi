//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit
import RxSwift
import RxCocoa

struct CellData {
    let imageName: String
    let title: String
    let subtitle: String?
}

class SettingViewController: UIViewController {
    private let rootView = SettingView()
    private let disposeBag = DisposeBag()

    private let cellData = BehaviorRelay<[CellData]>(value: [
        CellData(imageName: "pencil", title: "내 이름 설정하기", subtitle: "대장"),
        CellData(imageName: "moon.fill", title: "다마고치 변경하기", subtitle: nil),
        CellData(imageName: "arrow.clockwise", title: "데이터 초기화", subtitle: nil),
    ])

    override func loadView() {
        view = rootView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = UserDefaults.standard.loadTamagochi() {
            var newData = cellData.value
            newData[0] = CellData(imageName: "pencil", title: "내 이름 설정하기", subtitle: UserDefaults.standard.loadTamagochi()?.owner ?? "대장")
            cellData.accept(newData)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        navigationItem.title = "설정"
        navigationController?.navigationBar.tintColor = .tamagochiLine
    }

    private func bind() {
        cellData
            .bind(to: rootView.tableView.rx.items) { tableView, row, element in
                let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                cell.textLabel?.text = element.title
                cell.tintColor = .tamagochiLine
                cell.detailTextLabel?.text = element.subtitle
                cell.imageView?.image = UIImage(systemName: element.imageName)
                cell.accessoryType = .disclosureIndicator
                cell.backgroundColor = .tamagochiBackground
                return cell
            }
            .disposed(by: disposeBag)

        rootView.tableView.rx.modelSelected(CellData.self)
            .bind(with: self) { owner, item in
                switch item.title {
                case "내 이름 설정하기":
                    let vc = NameSettingViewController()
                    owner.navigationController?.pushViewController(vc, animated: true)
                case "다마고치 변경하기":
                    let vc = CreateCharacterViewController()
                    owner.navigationController?.pushViewController(vc, animated: true)
                case "데이터 초기화":
                    let alert = UIAlertController(title: "데이터 초기화", message: "정말 초기화하시겠어요?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "취소", style: .cancel))
                    alert.addAction(UIAlertAction(title: "초기화", style: .destructive, handler: { _ in
                        UserDefaults.standard.removeTamagochi()

                        let scenes = UIApplication.shared.connectedScenes
                        let windowScene = scenes.first as? UIWindowScene
                        if let window = windowScene?.windows.first {
                            let newNaviVC = UINavigationController(rootViewController: CreateCharacterViewController())
                            window.rootViewController = newNaviVC
                            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
                        }
                    }))
                    owner.present(alert, animated: true)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}
