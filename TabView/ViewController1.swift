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
        
        view.addSubview(createTabView())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createTabView() -> TabView {
        let width = view.frame.size.width
        let frame = CGRect(x: 0, y: 100, width: width, height: width)
        let tabView = TabView(frame: frame)
        tabView.tabHeight = 60
        tabView.tabHorizontalMargin = 5
        tabView.tabLineTopMargin = 3
        tabView.tabBackGroundImageName = "tabButtonBackground"
        tabView.tabLineColor = UIColor(white: 0.9, alpha: 1)
        tabView.selectedTabLineColor = nil
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = "⭐️⭐️⭐️⭐️⭐️⭐️⭐️"
        let starItem = TVItem(title: "Star", view: label, normalImage: UIImage(named:"star_normal"), selectedImage: UIImage(named:"star_selected"))
        
        let discoverImageView = UIImageView()
        discoverImageView.backgroundColor = UIColor.orange
        let discoveryItem = TVItem(title: "Time", view: discoverImageView, normalImage: UIImage(named:"discovery_normal"), selectedImage: UIImage(named:"discovery_selected"))
        
        let supplierItem = TVItem(title: "Supplier", view: UIView(), normalImage: UIImage(named:"supplier_normal"), selectedImage: UIImage(named:"supplier_selected"))
        
        let myItem = TVItem(title: "My", view: UIView(), normalImage: UIImage(named:"my_normal"), selectedImage: UIImage(named:"my_selected"))
        
        tabView.items = [starItem, discoveryItem, supplierItem, myItem]
        return tabView
    }

}
