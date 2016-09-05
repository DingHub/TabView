//
//  ViewController2.swift
//  TabView
//
//  Created by admin on 16/8/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData() {
        indicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            if let strong = self {
                strong.indicator.stopAnimating()
            }
        }
    }
}
