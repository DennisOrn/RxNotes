//
//  Model.swift
//  RxNotes
//
//  Created by Dennis Örnberg on 2018-02-25.
//  Copyright © 2018 Dennis Örnberg. All rights reserved.
//

import CoreData
import RxSwift
import RxCocoa

class Model {

    static let shared = Model()
    private init() {}

    let dataSource = Variable(["one", "two", "three"])


//    let appDelegate = UIApplication.shared.delegate as! AppDelegate

//    let dataSource = Variable<[Note]>([])

//    init() {
//        refreshDataSource()
//    }
//
//    func refreshDataSource() {
//
//        let context = appDelegate.persistentContainer.viewContext
//        context.perform {
//
//            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
//            if let notes = try? fetchRequest.execute() {
//                self.dataSource.value = notes
//            }
//            print("REFRESHED DATA SOURCE")
//        }
//    }

//    func save(text: String, to note: Note?) {
//
//        let context = appDelegate.persistentContainer.viewContext
//        context.perform {
//
//            // TODO: refactor this?
//            if text.isEmpty {
//                if let note = note {
//                    context.delete(note)
//                    note = nil
//                    self.refreshDataSource()
//                }
//                return
//            }
//
//            if note == nil {
//                note = Note(context: context)
//            }
//
//            note?.text = text
//            try? context.save()
//            self.refreshDataSource()
//        }
//    }
}
