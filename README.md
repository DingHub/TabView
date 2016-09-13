# TabView
Handy Tab View. 
---
![TV1](https://github.com/DingHub/ScreenShots/blob/master/TVTabView/1.png)............
![TV2](https://github.com/DingHub/ScreenShots/blob/master/TVTabView/2.png)
Usage:
---
1. As a containner of views:
```
    CGFloat width = self.view.frame.size.width;
    CGRect frame = CGRectMake(0, 100, width, width);
    TVTabView *tabView = [[TVTabView alloc] initWithFrame:frame];
    tabView.tabHeight = 60;
    tabView.tabBackGroundImageName = @"tabButtonBackground";
    tabView.tabLineColor = [UIColor colorWithWhite:0.9 alpha:1];
    tabView.selectedTabLineColor = nil;
    
    TVItem *starItem = [TVItem new];
    starItem.title = @"Star";
    starItem.selectedImageName = @"star_selected";
    starItem.normalImageName = @"star_normal";
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"⭐️⭐️⭐️⭐️⭐️⭐️⭐️";
    starItem.view = label;
    
    TVItem *discoveryItem = [TVItem new];
    discoveryItem.title = @"Discovery";
    discoveryItem.normalImageName = @"discovery_normal";
    discoveryItem.selectedImageName = @"discovery_selected";
    UIImageView *imageView = [UIImageView new];
    imageView.backgroundColor = [UIColor orangeColor];
    discoveryItem.view = imageView;
    
    TVItem *supplierItem = [TVItem new];
    supplierItem.title = @"Supplier";
    supplierItem.selectedImageName = @"supplier_selected";
    supplierItem.normalImageName = @"supplier_normal";
    supplierItem.view = [UIView new];
    
    TVItem *myItem = [TVItem new];
    myItem.title = @"My";
    myItem.selectedImageName = @"my_selected";
    myItem.normalImageName = @"my_normal";
    myItem.view = [UIView new];
    
    tabView.items = @[starItem, discoveryItem, supplierItem, myItem];
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
