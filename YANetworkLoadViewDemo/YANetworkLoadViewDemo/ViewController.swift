//
//  ViewController.swift
//  YANetworkLoadViewDemo
//
//  Created by ss on 15/10/20.
//  Copyright © 2015年 Yasin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,YANetworkLoadViewDelegate {
    @IBOutlet weak var networkLoadView: YANetworkLoadView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        networkLoadView.delegate = self
//        networkLoadView.show(view)
        networkLoadView.showLoadingView()
    }
    override func viewDidAppear(animated: Bool) {
        hwcDelay(2.0) { () -> () in
            self.networkLoadView.showErrorView()
        }
    }
    func retryRequest() {
        networkLoadView.showLoadingView()
        hwcDelay(2.0) { () -> () in
            self.networkLoadView.hidenFromSuperview()
        }
    }
    
    
    
    
    
    func hwcDelay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

