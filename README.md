# TabView
Handy Tab View. 
---
![TV1](https://github.com/DingHub/ScreenShots/blob/master/TVTabView/1.png)................... ![TV0](https://github.com/DingHub/ScreenShots/blob/master/TVTabView/0.png)
Usage:
---
1. As a containner of views:
```
        let width = view.frame.size.width
        let frame = CGRect(x: width * 0.25, y: 100, width: width * 0.5, height: width * 0.8)
        let tabView = TabView(frame: frame)
        tabView.tabLineColor = UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0);
        
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
