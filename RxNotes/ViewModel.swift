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

    let dataSource = Variable(["one", "two", "three"])

    @objc func addNote() {

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()

        context.perform {

            let note = Note(context: context)
            note.text = "asd"

            try? context.save()
            print("note added")




            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
            let count = try? fetchRequest.execute().count
            print(count)
        }
    }
}
