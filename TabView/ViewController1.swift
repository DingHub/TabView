//
//  ViewController1.swift
//  TabView
//
//  Created by admin on 16/8/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width
        let frame = CGRect(x: width * 0.25, y: 100, width: width * 0.5, height: width * 0.8)
        let tabView = TabView(frame: frame)
        
        let label = UILabel()
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
        
        view.addSubview(tabView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
