//
//  HomeViewModel.swift
//  StickyNotes
//
//  Created by SARVJEETSINGH on 16/08/20.
//  Copyright © 2020 SARVJEETSINGH. All rights reserved.
//

import CoreData
import Foundation

struct HomeViewModel {
        
    // MARK:- Properties
    // ChildContext whose parent context will be the main-context of the Coredata
    private lazy var childContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = CoreDataStack.shared.mainContext
        return context
    }()
    // The local property for saving the origin value
    private var piledContainerOrigin: (x: Float, y: Float) = (0.1, 0.1)
    
    
    // MARK:- Internal Functions
    ///Get the origin of the piledStickyNotesContainerView. This is fetched from Database for the first time and later will stored in local property
    ///
    ///- Returns Tuple of (x,y) of the origin or CGPoint
    mutating func getOriginOfPiledStickyNotesContainerView() -> (x: Float, y: Float) {
        // If the values are default set to the property, tghen fetched from DataBase
        if piledContainerOrigin.x == 0.1 && piledContainerOrigin.y == 0.1 {
            // Fetching vale from DB
            return fetchOriginFromDatabase()
        }
        else {
            // Returning the local property's stored value
            return piledContainerOrigin
        }
    }
    
    ///Set the origin of the piledStickyNotesContainerView to the local stored property and Database. If origin is already present in DB then update it with new values
    ///
    ///- Parameter x: The X-component of the origin
    ///- Parameter y: The Y-component of the origin
    mutating func setOriginOfPiledStickyNotesContainerView(x: Float, y: Float) {
        // Saving the origin components to the local stored property
        piledContainerOrigin.x = x
        piledContainerOrigin.y = y
        
        // Get the Child context in order to avoid the saving of context to actual DB everytime when user is changing the orientation of the view
        let context = childContext
        
        do {
            guard let result = try context.fetch(PiledStickyNotesView.fetchRequest()) as? [PiledStickyNotesView] else {return}
            // If Origin is already saved in DB then update it. {For dummy purpose, haven't set the ID of entity and we are saving single origin in DB}
            if result.count > 0 {
                result[0].originX = x
                result[0].originY = y
            }
            else {
                // If no origin is saved yet, create a new managedObject and add the origin componenets to it
                let containerView = PiledStickyNotesView(context: context)
                containerView.originX = x
                containerView.originY = y
            }
        } catch {
            print("Error while fetching Origin...")
        }
        
        // Perform the saving of the ChildContext and it will not affect the MainContext of the CoreData, we will save the final changes when we are going to exit the app
        context.perform {
          do {
            try context.save()
          } catch let error as NSError {
            fatalError("Error: \(error.localizedDescription)")
          }
        }
    }
    
    // MARK:- Private Functions
    ///Fetch the origin value from the DataBase
    ///
    ///- Returns Tuple of (x,y) of the origin or CGPoint
    private mutating func fetchOriginFromDatabase() -> (x: Float, y: Float) {
        
        do {
            // Fetch the origin saved in DB with ChildContext
            guard let result = try CoreDataStack.shared.mainContext.fetch(PiledStickyNotesView.fetchRequest()) as? [PiledStickyNotesView] else {
                return defaultOrigin()
            }
            // If we able to receive the origin from DB, then return the origin's components values
            if result.count > 0 {
                return (result[0].originX, result[0].originY)
            }
            else {
                // If origin is not yet saved in DB for once, then set the default values in the DB
                setOriginOfPiledStickyNotesContainerView(x: defaultOrigin().x, y: defaultOrigin().y)
            }
        } catch {
            print("Error while fetching Origin...")
        }
        // If we won't receive the origin's point from DB then will return the default values
        return defaultOrigin()
    }

    
    ///Get the default Origin of the containerView which is the center of the screen
    ///
    ///- Returns Tuple of (x,y) of the origin or CGPoint
    private func defaultOrigin() -> (x: Float, y: Float) {
        let x = Float(ApplicationConstants.DimensionConstants.SCREEN_CENTER.x - ApplicationConstants.DimensionConstants.STICKYNOTES_COMPACT_DEFAULT_CENTER.x)
         let y = Float(ApplicationConstants.DimensionConstants.SCREEN_CENTER.y - ApplicationConstants.DimensionConstants.STICKYNOTES_COMPACT_DEFAULT_CENTER.y)
         return (x, y)
    }
    
    
}
