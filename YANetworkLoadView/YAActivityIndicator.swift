//
//  YAActivityIndicator.swift
//  TestDemoPark
//
//  Created by ss on 15/10/15.
//  Copyright © 2015年 Yasin. All rights reserved.
//

import UIKit

class YAActivityIndicator: UIView {
    var hidesWhenStopped = true
    var color = UIColor(red:241/255.0, green:196/255.0, blue:15/255.0, alpha:1.0) {
        willSet{
            setupDotColor(newValue)
        }
    }
    private let timeInterval = 0.3
    private var dotRadius:CGFloat = 0.0
    private var stepNumber = 0
    private var isAnimating = false
    private var firstPoint = CGRectZero, secondPoint = CGRectZero, thirdPoint = CGRectZero, fourthPoint = CGRectZero
    private var firstDot = CALayer(), secondDot = CALayer(), thirdDot = CALayer()
    private var timer:NSTimer?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.

    deinit {
        print("YAActivityIndicator释放了")
    }
    override func awakeFromNib() {
        setupViewLayout(frame)
    }
    func setupViewLayout(frame:CGRect) {
        dotRadius = frame.size.height <= frame.size.width ? frame.size.width/12 : frame.size.height/12
        firstPoint = CGRectMake(frame.size.width/4-dotRadius, frame.size.height/2-dotRadius, 2*dotRadius, 2*dotRadius);
        secondPoint = CGRectMake(frame.size.width/2-dotRadius, frame.size.height/4-dotRadius, 2*dotRadius, 2*dotRadius);
        thirdPoint = CGRectMake(3*frame.size.width/4-dotRadius, frame.size.height/2-dotRadius, 2*dotRadius, 2*dotRadius);
        fourthPoint = CGRectMake(frame.size.width/2-dotRadius, 3*frame.size.height/4-dotRadius, 2*dotRadius, 2*dotRadius);
        //First dot is the one that moves straight up and down
        firstDot.masksToBounds = true
        firstDot.backgroundColor = color.CGColor
        firstDot.cornerRadius = dotRadius
        firstDot.bounds = CGRectMake(0.0, 0.0, dotRadius*2, dotRadius*2)
        firstDot.frame = fourthPoint
        
        //Second dot is the one that moves straight left and right
        secondDot.masksToBounds = true
        secondDot.backgroundColor = color.CGColor
        secondDot.cornerRadius = dotRadius
        secondDot.bounds = CGRectMake(0.0, 0.0, dotRadius*2, dotRadius*2)
        secondDot.frame = firstPoint
        
        //Third dot is the one that moves around all four positions clockwise
        thirdDot.masksToBounds = true
        thirdDot.backgroundColor = color.CGColor
        thirdDot.cornerRadius = dotRadius
        thirdDot.bounds = CGRectMake(0.0, 0.0, dotRadius*2, dotRadius*2)
        thirdDot.frame = thirdPoint
        
        layer.addSublayer(firstDot)
        layer.addSublayer(secondDot)
        layer.addSublayer(thirdDot)
        
        layer.hidden = true
        
    }
    func setupDotColor(color:UIColor) {
        firstDot.backgroundColor = color.CGColor
        secondDot.backgroundColor = color.CGColor
        thirdDot.backgroundColor = color.CGColor
    }
    func startAnimating() {
        if !isAnimating {
            isAnimating = true
            layer.hidden = false
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "animateNextStep", userInfo: nil, repeats: true)
        }
    }
    func stopAnimating() {
        isAnimating = false
        if hidesWhenStopped {
            layer.hidden = true
        }
        timer?.invalidate()
        stepNumber = 0
        firstDot.frame = fourthPoint;
        secondDot.frame = firstPoint;
        thirdDot.frame = thirdPoint;
        
    }
    func animateNextStep() {
        switch (stepNumber)
        {
        case 0:
            CATransaction.begin()
            CATransaction.setAnimationDuration(timeInterval)
            firstDot.frame = secondPoint
            thirdDot.frame = fourthPoint
            CATransaction.commit()
            break;
        case 1:
            CATransaction.begin()
            CATransaction.setAnimationDuration(timeInterval)
            secondDot.frame = thirdPoint
            thirdDot.frame = firstPoint
            CATransaction.commit()
            break;
        case 2:
            CATransaction.begin()
            CATransaction.setAnimationDuration(timeInterval)
            firstDot.frame = fourthPoint
            thirdDot.frame = secondPoint
            CATransaction.commit()
            break;
        case 3:
            CATransaction.begin()
            CATransaction.setAnimationDuration(timeInterval)
            secondDot.frame = firstPoint;
            thirdDot.frame = thirdPoint;
            CATransaction.commit()
            break;
        case 4:
            CATransaction.begin()
            CATransaction.setAnimationDuration(timeInterval)
            firstDot.frame = secondPoint;
            thirdDot.frame = fourthPoint;
            CATransaction.commit()
            stepNumber = 0;
        default:
            stepNumber = 0;
            break;
        }
        
        stepNumber++;
    }
    func isAnimatRun() -> Bool {
        return isAnimating
    }
}
