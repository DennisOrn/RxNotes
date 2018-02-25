//
//  ViewModel.swift
//  RxNotes
//
//  Created by Dennis Örnberg on 2018-02-25.
//  Copyright © 2018 Dennis Örnberg. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewModel {

    let dataSource = Variable(["one", "two", "three"])

    @objc func addNote() {
        print("addNote")
    }
}
