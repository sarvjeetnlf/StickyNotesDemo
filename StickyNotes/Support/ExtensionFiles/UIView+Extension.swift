//
//  UIView+Extension.swift
//  StickyNotes
//
//  Created by SARVJEETSINGH on 16/08/20.
//  Copyright © 2020 SARVJEETSINGH. All rights reserved.
//

import UIKit

extension UIView {
    
    ///To rotate the UIView with a specific radian value
    ///
    ///- Parameter angle: The angle in radians by which we want to rotate the view
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
}
