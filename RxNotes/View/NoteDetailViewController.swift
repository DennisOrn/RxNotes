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

    let text = Variable("")

    var viewModel: ViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        textView.rx.text.orEmpty
            .bind(to: text)
            .disposed(by: disposeBag)

        text.asObservable()
            .debounce(1, scheduler: MainScheduler.instance) // TODO: what are the differences between different schedulers?
            .subscribe(onNext: { string in
                print("onNext")
            }, onError: { error in
                print("onError") // TODO: not needed
            }, onCompleted: {
                print("onCompleted")
            }, onDisposed: {
                print("onDisposed") // TODO: not needed
            })
            .disposed(by: disposeBag)


        // TODO: save the text every 5 seconds after changes and when going back? debounce?
    }
}
