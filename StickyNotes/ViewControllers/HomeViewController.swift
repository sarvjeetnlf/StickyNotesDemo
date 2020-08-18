//
//  ViewController.swift
//  StickyNotes
//
//  Created by SARVJEETSINGH on 15/08/20.
//  Copyright © 2020 SARVJEETSINGH. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK:- Properties
    // Pan-Gestures: Used for Drag and Drop the view
    private lazy var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(self.detectPan(_:)))
    }()
    // Pinch-Gestures: Used for Zoom-in and Zoom-out the view
    private lazy var pinchGesture: UIPinchGestureRecognizer = {
        return UIPinchGestureRecognizer(target: self, action: #selector(self.viewZooming(_:)))
    }()
    // viewModel refernce in order to handle the origin of the piledStickyNotesContainerView
    var viewModel = HomeViewModel()
    // Creating the containerView along with 3 stickyNotes view
    private lazy var stickyNotesContainerView: UIView = {
         let containerView = createView(withOrigin: CGPoint(x: CGFloat(viewModel.getOriginOfPiledStickyNotesContainerView().x),
                                                            y: CGFloat(viewModel.getOriginOfPiledStickyNotesContainerView().y)),
                                       withSize: ApplicationConstants.DimensionConstants.STICKYNOTES_COMPACT_SIZE,
                                       withBackgroundColor: UIColor.clear, withRotatedAngle: nil)
                
        // Created the collective notes UI for replica of demo
         // In real-world we will implement the piling/unpiling of the different number of sticky notes
         // Here for dummy: I created 3 different sticky-notes UIViews and then add them all in an containerView on which all gestures are implemented
         let stickyNotesFirst = createView(withOrigin: CGPoint(x:0, y:0),
                                           withSize: ApplicationConstants.DimensionConstants.STICKYNOTES_COMPACT_SIZE,
                                           withBackgroundColor: ApplicationConstants.ColorConstants.STICKYNOTES_BACKGROUND_COLOR_RED,
                                           withRotatedAngle: -8)
         let stickyNotesSecond = createView(withOrigin: CGPoint(x:0, y:0),
                                            withSize: ApplicationConstants.DimensionConstants.STICKYNOTES_COMPACT_SIZE,
                                            withBackgroundColor: ApplicationConstants.ColorConstants.STICKYNOTES_BACKGROUND_COLOR_YELLOW,
                                            withRotatedAngle: -3)
         let stickyNotesThird = createView(withOrigin: CGPoint(x:0, y:0),
                                           withSize: ApplicationConstants.DimensionConstants.STICKYNOTES_COMPACT_SIZE,
                                           withBackgroundColor: ApplicationConstants.ColorConstants.STICKYNOTES_BACKGROUND_COLOR_GREEN,
                                           withRotatedAngle: nil)
        
        // Adding 3 different sticky notes to create piling of notes
        containerView.addSubview(stickyNotesFirst)
        containerView.addSubview(stickyNotesSecond)
        containerView.addSubview(stickyNotesThird)

        return containerView
    }()
     
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the initial views of the screen
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK:- Private Functions
    /// This function will set the required initial UI elements
    private func setupView() {
        self.view.backgroundColor = ApplicationConstants.ColorConstants.APP_BACKGROUND_COLOR_BLACK
        // Add the stickynotes view on the controller screen
        self.view.addSubview(stickyNotesContainerView)
        // Add constraints to the stickyNotesContainerView
        addStickyNotesContainerViewConstraints()
        
        // Add pan-gestures to the view for drag-drop
        stickyNotesContainerView.addGestureRecognizer(panGesture)
        // Add pinch-gestures to the view for zoom-in and zoom-out
        stickyNotesContainerView.addGestureRecognizer(pinchGesture)
                
        // Add dummy notesLabel on containerView to show the zoom-in/zoom-out and translation effect
        addDummyLabel(onView: stickyNotesContainerView)
    }

    /// Adding the constraints for containerView
    private func addStickyNotesContainerViewConstraints() {
        stickyNotesContainerView.widthAnchor.constraint(equalToConstant: ApplicationConstants.DimensionConstants.STICKYNOTES_COMPACT_SIZE.width).isActive = true
        stickyNotesContainerView.heightAnchor.constraint(equalToConstant: ApplicationConstants.DimensionConstants.STICKYNOTES_COMPACT_SIZE.height).isActive = true
        stickyNotesContainerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: CGFloat(viewModel.getOriginOfPiledStickyNotesContainerView().y)).isActive = true
        stickyNotesContainerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: CGFloat(viewModel.getOriginOfPiledStickyNotesContainerView().x)).isActive = true
    }
    

    ///Adding the dummy-label on the top of the containerView in order to show the more-less text as per space availability {For demo purposes, otherwise we can create a spearate view class for all sticky notes and handle it}
    ///
    ///- Parameter onView: The view on which we want to add dummy label
    private func addDummyLabel(onView: UIView) {
        let dummyNotesLabel = UILabel()
        onView.addSubview(dummyNotesLabel)
        dummyNotesLabel.numberOfLines = 0
        dummyNotesLabel.backgroundColor = UIColor.clear
        dummyNotesLabel.textColor = UIColor.white
        dummyNotesLabel.translatesAutoresizingMaskIntoConstraints = false
        dummyNotesLabel.text = "*Hi, \n\n*I am dummy note \n\n*You can float me around \n\n*You can pin to zoom to see more dummy text \n\n*Dummy text continue and you can see as much as possible by max zoom-in"

        // Add the constraints to the dummyNotesLabel w.r.t. stickyNotesContainerView
        dummyNotesLabel.topAnchor.constraint(equalTo: onView.topAnchor, constant: 10).isActive = true
        dummyNotesLabel.leftAnchor.constraint(equalTo: onView.leftAnchor, constant: 10).isActive = true
        dummyNotesLabel.bottomAnchor.constraint(equalTo: onView.bottomAnchor, constant: -10).isActive = true
        dummyNotesLabel.rightAnchor.constraint(equalTo: onView.rightAnchor, constant: -10).isActive = true
    }
    
    ///Creating the views for dummy container and stickyNotes {we can implement it by making a separate class for UIView}
    ///
    ///- Parameter withOrigin: The CGPoint of the required origin of the view
    ///- Parameter withSize: The CGSize of the view we want to create
    ///- Parameter withBackgroundColor: The UIColor we want to add in the background of the view
    ///- Parameter withRotatedAngle: The rotation angle we wnat to give to the view to make them a little tilted as per view
    private func createView(withOrigin: CGPoint, withSize: CGSize, withBackgroundColor: UIColor, withRotatedAngle: CGFloat?) -> UIView {
        // Setting of the required parameters of the view's UI
        let view = UIView()
        view.frame.size = withSize
        view.frame.origin = withOrigin
        if let rotationAngle = withRotatedAngle {
            view.rotate(angle: rotationAngle)
        }
        view.backgroundColor = withBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    // MARK:- Gesture Functions
    ///The detection of the PanGesture in order to trace the orientation in which view is dragged
    ///
    ///- Parameter recognizer: The UIPanGestureRecognizer received from gesture API
    @objc private func detectPan(_ recognizer:UIPanGestureRecognizer) {
        // Setting the view in which translationis recorded
        let translation  = recognizer.translation(in: self.view)
        
        // Get the last origin's point (x,y) in order to drag the view from previous location
        let pileContainerViewX = CGFloat(self.viewModel.getOriginOfPiledStickyNotesContainerView().x)
        let pileContainerViewY = CGFloat(self.viewModel.getOriginOfPiledStickyNotesContainerView().y)

        // Setting the new origin of containerView after adding the linear translation
        self.stickyNotesContainerView.frame.origin = CGPoint(x: (pileContainerViewX + translation.x), y: (pileContainerViewY + translation.y))
         
        // Accessing the dummy-label which is the subview of the containerView
         if let viewR = recognizer.view, let label = viewR.subviews.filter({$0 is UILabel})[0] as? UILabel {
            // Restrict the translation of the subview (Dummy label) in order to implement the change in frame of label instead
             label.transform = viewR.transform.inverted()
            // Updating the frames of the dummy label as per the translation of the superview (containerView)
             label.frame = CGRect(x: 10, y: 10, width: (viewR.bounds.width - 20), height: (viewR.bounds.height - 20))
          }

        // Updating the change in the linear translation of the view to the database
        viewModel.setOriginOfPiledStickyNotesContainerView(x: Float(stickyNotesContainerView.frame.origin.x), y: Float(stickyNotesContainerView.frame.origin.y))
        recognizer.setTranslation(CGPoint.zero, in: self.view)
     }
    
    ///The detection of the PinchGesture in order to trace the size-change of the view
    ///
    ///- Parameter sender: The UIPinchGestureRecognizer received from gesture API
    @objc private func viewZooming(_ sender: UIPinchGestureRecognizer) {
        // Get the scale by which the size of the view is going to transform
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        
        // Add the condition of the Max and Min transform of the view as per constants (Max scale can be = 1.5, Min scale = 1.0)
        guard let scale = scaleResult, scale.a > ApplicationConstants.DimensionConstants.STICKYNOTES_MIN_ZOOM, scale.d > ApplicationConstants.DimensionConstants.STICKYNOTES_MIN_ZOOM, scale.a < ApplicationConstants.DimensionConstants.STICKYNOTES_MAX_ZOOM, scale.d < ApplicationConstants.DimensionConstants.STICKYNOTES_MAX_ZOOM else { return }
        
        // Implement the transform change on the view
        sender.view?.transform = scale
         
        // Accessing the dummy-label which is the subview of the containerView
         if let viewR = sender.view, let label = viewR.subviews.filter({$0 is UILabel})[0] as? UILabel {
            // Restrict the transform of the subview (Dummy label) in order to implement the change in frame of label instead
             label.transform = viewR.transform.inverted()
            // Updating the frames of the dummy label as per the translation of the superview (containerView)
             label.frame = CGRect(x: 10, y: 10, width: (viewR.bounds.width - 20), height: (viewR.bounds.height - 20))
         }

        sender.scale = ApplicationConstants.DimensionConstants.STICKYNOTES_MIN_ZOOM
    }
    
}

