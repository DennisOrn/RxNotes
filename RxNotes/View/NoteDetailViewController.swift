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

    var index = 0
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        Model.shared.dataSource.asObservable()
            .map { $0[self.index] }
            .bind(to: textView.rx.text)
            .disposed(by: disposeBag)

        textView.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { text in
                Model.shared.dataSource.value[self.index] = text
            })
            .disposed(by: disposeBag)

//        textView.rx.text.orEmpty.asObservable()
//            .distinctUntilChanged()
//            .debounce(1, scheduler: MainScheduler.instance) // TODO: what are the differences between different schedulers?
//            .subscribe(onNext: { text in
//                //                self.viewModel.save(text: text, to: self.note)
//            })
//            .disposed(by: disposeBag)

        textView.becomeFirstResponder()
    }
}
