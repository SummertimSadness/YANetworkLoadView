//
//  YANetworkLoadView.swift
//  TestDemoPark
//
//  Created by ss on 15/10/15.
//  Copyright © 2015年 Yasin. All rights reserved.
//

import UIKit
protocol YANetworkLoadViewDelegate: NSObjectProtocol{
    func retryRequest()
}
@IBDesignable class YANetworkLoadView: UIView {
    @IBOutlet private var contView: UIView!
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var activityIndicatorView: YAActivityIndicator!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!
    
    weak var delegate:YANetworkLoadViewDelegate?
    @IBInspectable var errorStr:String?{
        get{
            return errorLabel.text
        }
        set(errorStr){
            errorLabel.text = errorStr
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    func setup() {
        contView = initFromXIB()
        contView.frame = bounds
        contView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth,UIViewAutoresizing.FlexibleHeight]
        self.addSubview(contView)
    }
    func initFromXIB() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "YANetworkLoadView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    
    //    override func awakeFromNib() {
    //        NSBundle.mainBundle().loadNibNamed("YANetworkLoadView", owner: self, options: nil)
    //        self.addSubview(contView)
    //    }
    override func drawRect(rect: CGRect) {
        contView.frame = rect
        contView.layoutIfNeeded()
    }
    func show(superView:UIView) {
        superView.addSubview(self)
        superView.bringSubviewToFront(self)
    }
    func removeHidenFromSuperview() {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.removeFromSuperview()
            }, completion: nil)
        
    }
    func setupErrorLabelText() {
        errorLabel.text = errorStr
    }
    func showLoadingView() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.loadingView.hidden = false
            self.errorView.hidden = true
            self.activityIndicatorView?.color = UIColor(red: 232.0/255.0, green: 35.0/255.0, blue: 111.0/255.0, alpha: 1.0)
            self.activityIndicatorView?.startAnimating()
        }
        
    }
    func showErrorView() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.errorView.hidden = false
            self.loadingView.hidden = true
        }
    }
    @IBAction func retryRequest(sender: AnyObject) {
        delegate?.retryRequest()
    }
}
