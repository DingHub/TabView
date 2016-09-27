//
//  TabView.swift
//  TabView
//
//  Created by admin on 16/8/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

public class TVItem {    
    public var title: String = ""
    public var view: UIView?
    public typealias TVAction = () -> ()
    public var tabSelectedAction: TVAction?
    public var bodyTappedAction: TVAction?
    // Another style of tab button
    public var normalImageName: String? //If is nil, there will be no image on the tap button.
    public var selectedImageName: String?
    
    public init(title: String,
                view: UIView,
                tabSelectedAction: TVAction? = nil,
                bodyTappedAction: TVAction? = nil,
                normalImageName: String? = nil,
                selectedImageName: String? = nil) {
    self.title = title
    self.view = view
    self.tabSelectedAction = tabSelectedAction
    self.bodyTappedAction = bodyTappedAction
    self.normalImageName = normalImageName
    self.selectedImageName = selectedImageName
    }
}

public class TabView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    public var tabHeight: CGFloat             = 44.0

    public var tabBackgroundColor: UIColor?
    public var tabBackGroundImageName: String?
    public var tabHorizontalMargin: CGFloat   = 0
    public var tabLineTopMargin: CGFloat      = 0
    public var bodyTopMargin: CGFloat         = 20.0
    public var bodyBottomMargin: CGFloat      = 20.0

    public var tabFontSize: CGFloat           = 14.0
    public var titleColor                     = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    public var selectedTitleColor             = UIColor(red: 33.0/255.0, green: 149.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    public var tabLineColor: UIColor?
    public var selectedTabLineColor: UIColor? = UIColor(red: 33.0/255.0, green: 149.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    
    public var items = [TVItem]() {
        didSet {
            if items.count > 0 {
                buidSubviews()
            }
        }
    }
    
    public var selectedIndex: Int {
        get {
            return currentIndex
        }
        set {
            tapped(index: newValue)
        }
    }
    
    // Mark: internal
    var currentIndex = 0
    var bodyView: UICollectionView?
    lazy var buttons = [UIButton]()
    lazy var tabView = UIView()
    lazy var tabLine = UIView()
    lazy var selectedTabLine = UIView()
}

// MARK: - collectionView datasource and delegate methods.
public extension TabView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVCell", for: indexPath) as! TVCell
        cell.mainView = items[indexPath.row].view
        return cell
    }
    
    @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        items[indexPath.row].bodyTappedAction?()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / width)
        tapped(index: index)
    }
}

// MARK: - private
private extension TabView {
    func buidSubviews() {
        let count = items.count
        let buttonWidth = (width - tabHorizontalMargin * CGFloat(count + 1)) / CGFloat(count)
        addSubview(tabView)
        tabView.backgroundColor = tabBackgroundColor
        tabView.frame = CGRect(x: 0, y: 0, width: width, height: tabHeight)
        addSubview(tabLine)
        tabLine.backgroundColor = tabLineColor
        tabLine.frame = CGRect(x: 0, y: tabHeight - 1, width: width, height: 1)
        tabLine.addSubview(selectedTabLine)
        selectedTabLine.backgroundColor = selectedTabLineColor
        selectedTabLine.frame = CGRect(x: tabHorizontalMargin, y: 0, width: buttonWidth, height: 1)
        
        for (i,item) in items.enumerated() {
            let button = UIButton(type: .custom)
            let floatI = CGFloat(i)
<<<<<<< HEAD
            button.frame = CGRect(x: tabHorizontalMargin + (buttonWidth + tabHorizontalMargin) * floatI, y: 0, width: buttonWidth, height: tabHeight - tabLineTopMargin)
            button.titleLabel?.baselineAdjustment = .AlignCenters
            button.titleLabel?.font = UIFont.systemFontOfSize(tabFontSize)
            button.setTitleColor(titleColor, forState: .Normal)
            button.setTitleColor(selectedTitleColor, forState: .Selected)
=======
            button.frame = CGRect(x: buttonWidth * floatI, y: 0, width: buttonWidth, height: tabHeight)
            button.titleLabel?.baselineAdjustment = .alignCenters
            button.titleLabel?.font = UIFont.systemFont(ofSize: tabFontSize)
            button.setTitleColor(titleColor, for: .normal)
            button.setTitleColor(selectedTitleColor, for: .selected)
>>>>>>> origin/Swift3
            button.tag = i;
            button.addTarget(self, action: #selector(tabTapped), for: .touchUpInside)
            
<<<<<<< HEAD
            button.setTitle(item.title, forState: .Normal)
            button.setTitle(item.title, forState: .Selected)
            if let normalImageName = item.normalImageName {
                
                button.setImage(UIImage(named: normalImageName), forState: .Normal)
                if let imageSize = button.imageView?.bounds.size {
                    button.titleEdgeInsets = UIEdgeInsets(top: imageSize.height, left: -imageSize.width, bottom: 0, right: 0)
                }
                if let titleSize = button.titleLabel?.bounds.size {
                    button.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height, left: 0, bottom: 0, right: -titleSize.width)
                }
            }
            if let selectedImageName = item.selectedImageName {
                button.setImage(UIImage(named: selectedImageName), forState: .Selected)
            }
            if let tabBackGroundImageName = tabBackGroundImageName {
                button .setBackgroundImage(UIImage(named: tabBackGroundImageName), forState: .Selected)
            }
            button.setBackgroundImage(nil, forState: .Normal)
=======
            button.setTitle(item.title, for: .normal)
            button.setTitle(item.title, for: .selected)
>>>>>>> origin/Swift3
            
            tabView.addSubview(button)
            buttons.append(button)
            if i == 0 {
                button.selected = true
            }
        }
        
        layoutIfNeeded()
        if bodyView == nil {
            bodyView = createBodyView()
        }
        bodyView?.reloadData()
        tapped(index: -1)
    }
    
    @objc func tabTapped(button: UIButton) {
        tapped(index: button.tag)
    }
    
    func tapped(index: Int) {
        guard currentIndex != index && index >= 0 && index < items.count else { return }
        let i = index == -1 ? 0 : index
        let preButton = buttons[currentIndex]
<<<<<<< HEAD
        let currentButton = buttons[i]
        
        currentIndex = i
        
        UIView.animateWithDuration(0.3) {
            preButton.selected = false
            currentButton.selected = true
=======
        preButton.isSelected = false
        let currentButton = buttons[i]
        currentButton.isSelected = true
        
        currentIndex = i
        
        UIView.animate(withDuration: 0.3) {
>>>>>>> origin/Swift3
            let point = CGPoint(x: currentButton.center.x, y: self.selectedTabLine.center.y)
            self.selectedTabLine.center = point
        }
        
        scrollBody()
        
        items[i].tabSelectedAction?()
    }
    
    func scrollBody() {
        let point = CGPoint(x: width * CGFloat(currentIndex), y: 0)
        bodyView?.setContentOffset(point, animated: true)
    }
    
    class TVCell: UICollectionViewCell {
        var mainView: UIView? {
            willSet(newView) {
                for view in contentView.subviews {
                    view.removeFromSuperview()
                }
                newView?.frame = bounds
            }
            didSet {
                if let view = mainView {
                    contentView.addSubview(view)
                }
            }
        }
    }
    
    func createBodyView() -> UICollectionView {
        let bodyFrame = CGRect(x: 0,
                               y: tabHeight + bodyTopMargin,
                               width: width,
                               height: height - tabHeight - bodyTopMargin - bodyBottomMargin)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.000001
        layout.minimumInteritemSpacing = 0.000001
        layout.itemSize = bodyFrame.size
        
        let collectionView = UICollectionView(frame: bodyFrame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(TVCell.self, forCellWithReuseIdentifier: "TVCell")
        collectionView.delaysContentTouches = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.isUserInteractionEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
<<<<<<< HEAD
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight, .FlexibleBottomMargin]
=======
        collectionView.autoresizingMask = [.flexibleWidth,
                                           .flexibleHeight,
                                           .flexibleBottomMargin]
>>>>>>> origin/Swift3
        addSubview(collectionView)
        
        return collectionView
    }
    
    var width: CGFloat {
        return self.frame.size.width
    }
    
    var height: CGFloat {
        return self.frame.size.height
    }
}
