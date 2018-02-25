//
//  ViewController.swift
//  RxNotes
//
//  Created by Dennis Örnberg on 2018-02-25.
//  Copyright © 2018 Dennis Örnberg. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let viewModel = ViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add,
                                                         target: viewModel,
                                                         action: #selector(viewModel.addNote)), animated: false)
        title = "Notes"

        viewModel.dataSource.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) {
                row, element, cell in
                cell.textLabel?.text = "\(element)"
            }
            .disposed(by: disposeBag)

        tableView.rx
            .itemSelected
            .subscribe { indexPath in
                print(indexPath)
            }
            .disposed(by: disposeBag)
    }
}
