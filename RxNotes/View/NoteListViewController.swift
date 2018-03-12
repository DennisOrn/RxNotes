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

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: clicking on the notch makes the list scroll too far up
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(red: 112/255, green: 130/255, blue: 56/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        title = "Notes"

        addButton.rx.tap
            .subscribe { indexPath in self.performSegue(withIdentifier: "Note detail", sender: nil) }
            .disposed(by: disposeBag)

        Model.shared.dataSource.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = "\(element)"
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe { indexPath in
                self.performSegue(withIdentifier: "Note detail", sender: indexPath.element?.row)
            }
            .disposed(by: disposeBag)

        tableView.rx.itemDeleted
            .subscribe { event in
                Model.shared.dataSource.value.remove(at: event.element!.row)
            }
            .disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "Note detail" {

            guard
                let navigationController = segue.destination as? UINavigationController,
                let destinationVC = navigationController.topViewController as? NoteDetailViewController
                else { return }

            if let row = sender as? Int {
                destinationVC.index = row
            }
        }
    }
}
