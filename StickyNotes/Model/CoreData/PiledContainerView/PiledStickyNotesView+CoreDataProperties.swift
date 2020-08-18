//
//  PiledStickyNotesView+CoreDataProperties.swift
//  StickyNotes
//
//  Created by SARVJEETSINGH on 18/08/20.
//  Copyright © 2020 SARVJEETSINGH. All rights reserved.
//
//

import Foundation
import CoreData


extension PiledStickyNotesView {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PiledStickyNotesView> {
        return NSFetchRequest<PiledStickyNotesView>(entityName: "PiledStickyNotesView")
    }

    @NSManaged public var originX: Float
    @NSManaged public var originY: Float

}
