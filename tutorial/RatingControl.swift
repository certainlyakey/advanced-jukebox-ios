//
//  RatingControl.swift
//  tutorial
//
//  Created by AleksandrBeliaev on 16/03/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit

class RatingControl: UIView {
	
	// MARK: Properties
 
	var ratingButtons = [UIButton]()
	var stars = 5
	var spacing = 5
	var rating = 0 {
		didSet {
			setNeedsLayout()
		}
	}
	
	
	
	// MARK: Initialization
	override func layoutSubviews() {
		// Draw the stars
		let buttonSize = Int(frame.size.height)
		var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
		
		// Place the stars
		for (index, button) in ratingButtons.enumerate() {
			buttonFrame.origin.x = CGFloat(index * (buttonSize + stars))
			button.frame = buttonFrame
		}
		updateButtonSelectionStates()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	
		let filledStarImage = UIImage(named: "filledstar")
		let emptyStarImage = UIImage(named: "emptystar")
		
		for _ in 0..<5 {
			let button = UIButton()
			button.setImage(emptyStarImage, forState: .Normal)
			button.setImage(filledStarImage, forState: .Selected)
			button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
			button.adjustsImageWhenHighlighted = false
			button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
			ratingButtons += [button]
			addSubview(button)
		}
	}
	override func intrinsicContentSize() -> CGSize {
		let buttonSize = Int(frame.size.height)
		let width = (buttonSize + spacing) * stars
		
		return CGSize(width: width, height: buttonSize)
	}
	
	
	
	
	// MARK: Button Action
	func ratingButtonTapped(button: UIButton) {
		rating = ratingButtons.indexOf(button)! + 1
		updateButtonSelectionStates()
	}
	
	func updateButtonSelectionStates() {
		for (index, button) in ratingButtons.enumerate() {
			// If the index of a button is less than the rating, that button should be selected.
			button.selected = index < rating
		}
	}

}
