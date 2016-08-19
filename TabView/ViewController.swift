//
//  ViewController.swift
//  TabView
//
//  Created by admin on 16/8/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width
        let frame = CGRect(x: width * 0.25, y: 100, width: width * 0.5, height: width * 0.8)
        let tabView = TabView(frame: frame)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        label.textAlignment = .Center
        label.text = "First view"
        let item1 = TVItem(title: "First", view: label, tabSelectedAction: nil, bodyTappedAction: nil)
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.orangeColor()
        let item2 = TVItem(title: "Last", view: imageView, tabSelectedAction: {
            print("Second tab selected")
        }) {
            print("Second view tapped")
        }
        tabView.items = [item1, item2]
        tabView.backgroundColor = UIColor.blueColor()
        view.addSubview(tabView)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc1 = storyboard.instantiateViewControllerWithIdentifier("ViewController1") as! ViewController1
//        let vc2 = storyboard.instantiateViewControllerWithIdentifier("ViewController2") as! ViewController2
//        let vc3 = storyboard.instantiateViewControllerWithIdentifier("ViewController3") as! ViewController3
//        
//        let screenBounds = UIScreen.mainScreen().bounds
//        let tabView = TabView(frame: screenBounds)
//        tabView.bodyBottomMargin = 0
//        
//        let item1 = TVItem(title: "controller 1", view: vc1.view, tabSelectedAction: nil, bodyTappedAction: nil)
//        
//        var vc2loaded = false
//        let item2 = TVItem(title: "controller 2",
//                           view: vc2.view,
//                           tabSelectedAction: {
//                            if !vc2loaded {
//                                vc2loaded = true
//                                vc2.loadData()
//                            }
//            },
//                           bodyTappedAction: nil)
//        
//        let item3 = TVItem(title: "controller 3", view: vc3.view, tabSelectedAction: nil, bodyTappedAction: nil)
//        
//        tabView.items = [item1, item2, item3]
//
        //        view.addSubview(tabView)
        view.backgroundColor = UIColor.whiteColor()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

