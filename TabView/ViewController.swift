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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "ViewController1") as! ViewController1
        let vc2 = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        let vc3 = storyboard.instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        
        let screenBounds = UIScreen.main.bounds
        let tabView = TabView(frame: screenBounds)
        tabView.bodyBottomMargin = 0
        tabView.tabHorizontalMargin = 5
        
        let item1 = TVItem(title: "controller 1", view: vc1.view)
        
        var vc2loaded = false
        let item2 = TVItem(title: "controller 2",
                           view: vc2.view,
                           tabSelectedAction: {
                            if !vc2loaded {
                                vc2loaded = true
                                vc2.loadData()
                            }
        })
        
        let item3 = TVItem(title: "controller 3", view: vc3.view)
        
        tabView.items = [item1, item2, item3]

            view.addSubview(tabView)
        view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

