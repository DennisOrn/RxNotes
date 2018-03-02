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

    // It's probably cheap to modify NSManagedObject's, as long as the context isn't saved all the time
    var dataSource = Variable(["one", "two"])

    static let shared = Model()
    private init() {}
}
