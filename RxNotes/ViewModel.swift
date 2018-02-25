//
//  ViewModel.swift
//  RxNotes
//
//  Created by Dennis Örnberg on 2018-02-25.
//  Copyright © 2018 Dennis Örnberg. All rights reserved.
//

import CoreData
import RxSwift
import RxCocoa

class ViewModel {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let dataSource = Variable<[String]>([])

    init() {
        refreshDataSource()
    }

    func refreshDataSource() {

        let context = appDelegate.persistentContainer.viewContext
        context.perform {

            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
            if let notes = try? fetchRequest.execute() {
                self.dataSource.value = notes.map { $0.text! }
            }
        }
    }

    @objc func addNote() {

        let context = appDelegate.persistentContainer.newBackgroundContext()
        context.perform {

            let note = Note(context: context)
            note.text = "Test"
            try? context.save()
            self.refreshDataSource()
        }
    }
}
