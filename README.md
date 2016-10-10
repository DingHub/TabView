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
tabView.tabBackGroundImage = UIImage(named:"tabButtonBackground")
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
```
2. As a containner of viewControllers:
```
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
```

You can find an Objective-C version here:[TVTabView](https://github.com/DingHub/TVTabView)
