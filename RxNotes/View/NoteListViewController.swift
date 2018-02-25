//
//  NoteListViewController.swift
//  RxNotes
//
//  Created by Dennis Örnberg on 2018-02-25.
//  Copyright © 2018 Dennis Örnberg. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

class NoteListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let viewModel = ViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: clicking on the notch makes the list scroll too far up
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
                self.performSegue(withIdentifier: "View note", sender: nil)
            }
            .disposed(by: disposeBag)
    }
}
