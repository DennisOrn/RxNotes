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

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    let viewModel = ViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: clicking on the notch makes the list scroll too far up
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Notes"

        addButton.rx.tap
            .subscribe { indexPath in
                self.performSegue(withIdentifier: "Note detail", sender: nil)
            }
            .disposed(by: disposeBag)

        viewModel.dataSource.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = "\(element)"
            }
            .disposed(by: disposeBag)

//        tableView.rx.itemSelected
//            .subscribe { indexPath in
//                self.performSegue(withIdentifier: "Note detail", sender: indexPath)
//            }
//            .disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Note detail" {
            guard let destinationVC = segue.destination as? NoteDetailViewController else { return }
            destinationVC.viewModel = viewModel
//            if let indexPath = sender as? IndexPath {
//                destinationVC.text.value = tableView.cellForRow(at: indexPath)?.textLabel?.text ?? ""
//            }
        }
    }
}
