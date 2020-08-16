//
//  ViewController.swift
//  StickyNotes
//
//  Created by SARVJEETSINGH on 15/08/20.
//  Copyright © 2020 SARVJEETSINGH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK:- Properties
    // Pan-Gestures: Used for Drag and Drop the view
    private lazy var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(self.detectPan(_:)))
    }()
    // Pinch-Gestures: Used for Zoom-in and Zoom-out the view
    private lazy var pinchGesture: UIPinchGestureRecognizer = {
        return UIPinchGestureRecognizer(target: self, action: #selector(self.viewZooming(_:)))
    }()
    // Origin of ContainerView which contains all the collective stickynotes
    private var collectiveStickyNotesContainerLastOrigin: CGPoint = {
        let centerX = ApplicationConstants.DimensionConstants.SCREEN_CENTER.x - ApplicationConstants.DimensionConstants.STICKYNOTES_COMPACT_DEFAULT_CENTER.x
        let centerY = ApplicationConstants.DimensionConstants.SCREEN_CENTER.y - ApplicationConstants.DimensionConstants.STICKYNOTES_COMPACT_DEFAULT_CENTER.y
        return CGPoint(x: centerX, y: centerY)
    }()
    
    private lazy var stickyNotesView: UIView = {
        let view = UIView(frame: CGRect(x: collectiveStickyNotesContainerLastOrigin.x, y: collectiveStickyNotesContainerLastOrigin.y, width: 200, height: 200))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ApplicationConstants.ColorConstants.STICKYNOTES_BACKGROUND_COLOR_GREEN
        return view
    }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupView()
    }
    
    /// This function will set the required initial UI elements
    private func setupView() {
        // Add the stickynotes view on the controller screen
        self.view.addSubview(stickyNotesView)
        // Add pan-gestures to the view for drag-drop
        stickyNotesView.addGestureRecognizer(panGesture)
        // Add pinch-gestures to the view for zoom-in and zoom-out
        stickyNotesView.addGestureRecognizer(pinchGesture)
    }

    @objc func detectPan(_ recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.translation(in: self.view)

        UIView.animate(withDuration: 0.1) {
            self.stickyNotesView.frame.origin = CGPoint(x: self.collectiveStickyNotesContainerLastOrigin.x + translation.x, y: self.collectiveStickyNotesContainerLastOrigin.y + translation.y)
        }

        collectiveStickyNotesContainerLastOrigin.x = stickyNotesView.frame.origin.x
        collectiveStickyNotesContainerLastOrigin.y = stickyNotesView.frame.origin.y
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @objc func viewZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > ApplicationConstants.DimensionConstants.STICKYNOTES_MIN_ZOOM, scale.d > ApplicationConstants.DimensionConstants.STICKYNOTES_MIN_ZOOM, scale.a < ApplicationConstants.DimensionConstants.STICKYNOTES_MAX_ZOOM, scale.d < ApplicationConstants.DimensionConstants.STICKYNOTES_MAX_ZOOM else { return }
        
        UIView.animate(withDuration: 0.1) {
            sender.view?.transform = scale
        }
        
        sender.scale = ApplicationConstants.DimensionConstants.STICKYNOTES_MIN_ZOOM
    }    
}

