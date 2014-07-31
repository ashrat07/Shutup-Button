//
//  ViewController.swift
//  Shutup Button
//
//  Created by Mohamad on 7/31/14.
//  Copyright (c) 2014 Mohamad Ibrahim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var button: ShutupButton! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 37/255, green: 122/255, blue: 24/255, alpha: 1)
        
        button = ShutupButton (frame: CGRectMake(135, 135, 50, 50))
        button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        self.view.addSubview(button)
    
    }

    override  func preferredStatusBarStyle() -> UIStatusBarStyle
    {
      return .LightContent
    }
    
    func toggle(sender: AnyObject!) {
        button.mute = !button.mute
        
    }


}

