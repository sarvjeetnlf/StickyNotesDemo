//
//  CoreDataStack.swift
//  StickyNotes
//
//  Created by SARVJEETSINGH on 17/08/20.
//  Copyright © 2020 SARVJEETSINGH. All rights reserved.
//

import CoreData

final class CoreDataStack {
    
    // Creation of the sahred instance of the CoreDataStack {Singleton: altough not a good pattern to follow, instead we can go with dependency-injection by passingnthe coredata-stack as property or part of initialization of the ViewModels and Models}
    private init() {}
    static let shared = CoreDataStack()
    
    // MainContext of the CoreData with which we will save data changes into DB when we will going to exit the app
    lazy var mainContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    // Setting up the Persistance storage
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "StickyNotes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

// MARK:- Extension of CoreDataStack
extension CoreDataStack {
    
    /// Save changes of data into DB and it will be probably called when user is going to exit the app
    func saveContext () {
        // Check if there are changes available in the mainContext
        guard mainContext.hasChanges else {
            return
        }
        
        do {
            // Try to save the changes to DB
            try mainContext.save()
        } catch let nserror as NSError {
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

