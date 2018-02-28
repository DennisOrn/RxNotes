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

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    let text = Variable("")
    var note: Note!

    var viewModel: ViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        textView.rx.text.orEmpty
            .bind(to: text)
            .disposed(by: disposeBag)

        text.asObservable()
            .distinctUntilChanged()
            .debounce(1, scheduler: MainScheduler.instance) // TODO: what are the differences between different schedulers?
            .subscribe(onNext: { string in
                print("onNext")
                self.save(text: string)
            }, onError: { error in
                print("onError") // TODO: not needed
            }, onCompleted: {
                print("onCompleted")
            }, onDisposed: {
                print("onDisposed") // TODO: not needed
            })
            .disposed(by: disposeBag)
    }

    func save(text: String) {

        let context = appDelegate.persistentContainer.viewContext
        context.perform {

            // TODO: refactor this?
            if text.isEmpty {
                if self.note != nil {
                    context.delete(self.note)
                    self.note = nil
                    self.viewModel.refreshDataSource()
                }
                return
            }

            if self.note == nil {
                self.note = Note(context: context)
            }

            self.note?.text = text
            try? context.save()
            self.viewModel.refreshDataSource()
        }
    }
}
