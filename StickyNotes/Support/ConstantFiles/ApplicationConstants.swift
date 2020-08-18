//
//  ApplicationConstants.swift
//  StickyNotes
//
//  Created by SARVJEETSINGH on 16/08/20.
//  Copyright © 2020 SARVJEETSINGH. All rights reserved.
//

import UIKit


struct ApplicationConstants {
    
    /// This nested structure will contains all constants related to dimensions and sizes used in the application
    struct DimensionConstants {
        /// StickyNotes related dimensions
        // The maximum zoom allowed for the stickynotes
        static let STICKYNOTES_MAX_ZOOM: CGFloat = 1.5
        // The minimum zoom allowed for tghe stickynotes
        static let STICKYNOTES_MIN_ZOOM: CGFloat = 1.0
        // The compact size of the stickynotes
        static let STICKYNOTES_COMPACT_SIZE = CGSize(width: 200, height: 200)
        // The default center position of the stickynotes when app run for the first time
        static let STICKYNOTES_COMPACT_DEFAULT_CENTER = CGPoint(x: STICKYNOTES_COMPACT_SIZE.width/2.0, y: STICKYNOTES_COMPACT_SIZE.height/2.0)

        /// Main screen related dimensions
        static let SCREEN_CENTER = CGPoint(x: UIScreen.main.bounds.width/2.0, y: UIScreen.main.bounds.height/2.0)
    }
    
    
    /// This nested structure will contains all color constants used in the application
    struct ColorConstants {
        static let APP_BACKGROUND_COLOR_BLACK = UIColor.black
        // Different colors of the stickynotes {These are just random colors and we can add more on the basis of the requirement}
        static let STICKYNOTES_BACKGROUND_COLOR_GREEN = UIColor(displayP3Red: 0.2, green: 0.7, blue: 0.01, alpha: 1.0)
        static let STICKYNOTES_BACKGROUND_COLOR_RED = UIColor(displayP3Red: 0.92, green: 0.59, blue: 0.58, alpha: 1.0)
        static let STICKYNOTES_BACKGROUND_COLOR_YELLOW = UIColor(displayP3Red: 0.99, green: 0.80, blue: 0.0, alpha: 1.0)
    }
    
}
