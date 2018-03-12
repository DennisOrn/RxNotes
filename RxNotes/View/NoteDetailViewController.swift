//
//  NoteDetailViewController.swift
//  RxNotes
//
//  Created by Dennis Örnberg on 2018-02-25.
//  Copyright © 2018 Dennis Örnberg. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

class NoteDetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    var index: Int?
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.barTintColor = UIColor(red: 112/255, green: 130/255, blue: 56/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        textView.becomeFirstResponder()

        // A binding from the model to the textview is unnecessary, just set the text once.
        if let index = index {
            textView.text = Model.shared.dataSource.value[index]
        }

        textView.rx.text.orEmpty
            .subscribe { event in
                if let index = self.index {
                    Model.shared.dataSource.value[index] = event.element ?? ""
                } else {
                    Model.shared.dataSource.value.append(event.element ?? "")
                    self.index = Model.shared.dataSource.value.count - 1
                }
            }
            .disposed(by: disposeBag)

        doneButton.rx.tap
            .subscribe { event in
                self.textView.resignFirstResponder()
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
