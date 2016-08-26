//
//  TabView.swift
//  TabView
//
//  Created by admin on 16/8/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit

public typealias TVAction = () -> ()

public struct TVItem {
    public var title: String
    public var view: UIView
    public var tabSelectedAction: TVAction?
    public var bodyTappedAction: TVAction?
}

public class TabView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    public var tabHeight: CGFloat        = 44.0
    public var bodyTopMargin: CGFloat    = 20.0
    public var bodyBottomMargin: CGFloat = 20.0
    public var tabBackgroundColor: UIColor?
    public var tabFontSize: CGFloat      = 14.0
    public var titleColor                = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    public var selectedTitleColor        = UIColor(red: 33.0/255.0, green: 149.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    public var tabLineColor: UIColor?
    public var selectedTabLineColor      = UIColor(red: 33.0/255.0, green: 149.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    public var items = [TVItem]() {
        didSet {
            if items.count > 0 {
                buidSubviews()
            }
        }
    }
    public func selectItemWithIndex(index: Int) {
        tappedTab(index)
    }
    
    
    // Mark: impletion
    
    private func buidSubviews() {
        let count = items.count
        let buttonWidth = width / CGFloat(count)
        addSubview(tabView)
        tabView.backgroundColor = tabBackgroundColor
        tabView.frame = CGRect(x: 0, y: 0, width: width, height: tabHeight)
        addSubview(tabLine)
        tabLine.backgroundColor = tabLineColor
        tabLine.frame = CGRect(x: 0, y: tabHeight - 1, width: width, height: 1)
        tabLine.addSubview(selectedTabLine)
        selectedTabLine.backgroundColor = selectedTabLineColor
        selectedTabLine.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: 1)
        
        for (i,item) in items.enumerate() {
            let button = UIButton(type: .Custom)
            let floatI = CGFloat(i)
            button.frame = CGRect(x: buttonWidth * floatI, y: 0, width: buttonWidth, height: tabHeight)
            button.titleLabel?.baselineAdjustment = .AlignCenters
            button.titleLabel?.font = UIFont.systemFontOfSize(tabFontSize)
            button.setTitleColor(titleColor, forState: .Normal)
            button.setTitleColor(selectedTitleColor, forState: .Selected)
            button.tag = i;
            button.addTarget(self, action: #selector(tabTapped), forControlEvents: .TouchUpInside)
            
            button.setTitle(item.title, forState: .Normal)
            button.setTitle(item.title, forState: .Selected)
            
            tabView.addSubview(button)
            buttons.append(button)
        }
        
        layoutIfNeeded()
        if bodyView == nil {
            bodyView = createBodyView()
        }
        bodyView?.reloadData()
        tappedTab(-1)
    }
    
    @objc private func tabTapped(button: UIButton) {
        tappedTab(button.tag)
    }
    
    private func tappedTab(index: Int) {
        guard currentSelectedIndex != index && index >= 0 && index < items.count else { return }
        let i = index == -1 ? 0 : index
        let preButton = buttons[currentSelectedIndex]
        preButton.selected = false
        let currentButton = buttons[i]
        currentButton.selected = true
        
        currentSelectedIndex = i
        
        UIView.animateWithDuration(0.3) { [weak self] in
            if let strong = self {
                let point = CGPoint(x: currentButton.center.x, y: self!.selectedTabLine.center.y)
                strong.selectedTabLine.center = point
            }
        }
        
        scrollBody()
        
        items[i].tabSelectedAction?()
    }
    
    private func scrollBody() {
        let point = CGPoint(x: width * CGFloat(currentSelectedIndex), y: 0)
        bodyView?.setContentOffset(point, animated: true)
    }
    
    private var currentSelectedIndex = 0

    private var bodyView: UICollectionView?
    
    private func createBodyView() -> UICollectionView {
        let bodyFrame = CGRect(x: 0,
                               y: tabHeight + bodyTopMargin,
                               width: width,
                               height: height - tabHeight - bodyTopMargin - bodyBottomMargin)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.minimumLineSpacing = 0.000001
        layout.minimumInteritemSpacing = 0.000001
        layout.itemSize = bodyFrame.size
        
        let collectionView = UICollectionView(frame: bodyFrame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerClass(TVCell.self, forCellWithReuseIdentifier: "TVCell")
        collectionView.delaysContentTouches = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.pagingEnabled = true
        collectionView.userInteractionEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoresizingMask = [.FlexibleWidth,
                                           .FlexibleHeight,
                                           .FlexibleBottomMargin]
        addSubview(collectionView)
        
        return collectionView
    }
    
    private class TVCell: UICollectionViewCell {
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
    
    private lazy var buttons = [UIButton]()
    
    private var width: CGFloat {
        return self.frame.size.width
    }
    private var height: CGFloat {
        return self.frame.size.height
    }
    
    private var tabView = UIView()
    private var tabLine = UIView()
    private var selectedTabLine = UIView()
    
    // Mark: collectionView datasource and delegate methods.
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TVCell", forIndexPath: indexPath) as! TVCell
        cell.mainView = items[indexPath.row].view
        return cell
    }
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        items[indexPath.row].bodyTappedAction?()
    }
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / width)
        tappedTab(index)
    }

}
