# TabView
Handy Tab View. 
---
![TV1](https://github.com/DingHub/ScreenShots/blob/master/TVTabView/1.png)............
![TV2](https://github.com/DingHub/ScreenShots/blob/master/TVTabView/2.png)
Usage:
---
1. As a containner of views:
```
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
        label.textAlignment = .Center
        label.text = "⭐️⭐️⭐️⭐️⭐️⭐️⭐️"
        let starItem = TVItem(title: "Star", view: label, normalImageName: "star_normal", selectedImageName: "star_selected")
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.orangeColor()
        let discoveryItem = TVItem(title: "Discovery", view: imageView, normalImageName: "discovery_normal", selectedImageName: "discovery_selected")
        
        let supplierItem = TVItem(title: "Supplier", view: UIView(), normalImageName: "supplier_normal", selectedImageName: "supplier_selected")
        
        let myItem = TVItem(title: "My", view: UIView(), normalImageName: "my_normal", selectedImageName: "my_selected")
        
        tabView.items = [starItem, discoveryItem, supplierItem, myItem]
```
2. As a containner of viewControllers:
```
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewControllerWithIdentifier("ViewController1") as! ViewController1
        let vc2 = storyboard.instantiateViewControllerWithIdentifier("ViewController2") as! ViewController2
        let vc3 = storyboard.instantiateViewControllerWithIdentifier("ViewController3") as! ViewController3
        
        let screenBounds = UIScreen.mainScreen().bounds
        let tabView = TabView(frame: screenBounds)
        tabView.bodyBottomMargin = 0
        
        let item1 = TVItem(title: "controller 1", view: vc1.view, tabSelectedAction: nil, bodyTappedAction: nil)
        
        var vc2loaded = false
        let item2 = TVItem(title: "controller 2",
                           view: vc2.view,
                           tabSelectedAction: {
                                if !vc2loaded {
                                        vc2loaded = true
                                        vc2.loadData()
                                }
                           },
                           bodyTappedAction: nil)
        
        let item3 = TVItem(title: "controller 3", view: vc3.view, tabSelectedAction: nil, bodyTappedAction: nil)
        
        tabView.items = [item1, item2, item3]

        view.addSubview(tabView)
        view.backgroundColor = UIColor.whiteColor()
```

Swift3 branch is ready, I'll combine the branch to master when the final official version of Swift3 released.

You can find an Objective-C version here:[TVTabView](https://github.com/DingHub/TVTabView)
