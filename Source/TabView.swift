//
//  TabView.swift
//  TabView
//
//  Created by admin on 16/8/19.
//  Copyright © 2016年 Ding. All rights reserved.
//

import UIKit


open class TVItem {
    open var title: String = ""
    open var view: UIView?
    public typealias TVAction = () -> ()
    open var tabSelectedAction: TVAction?
    open var bodyTappedAction: TVAction?
    // Image style of tab button
    open var normalImage: UIImage? //If is nil, there will be no image on the tap button.
    open var selectedImage: UIImage?
    
    public init(title: String,
                view: UIView,
                tabSelectedAction: TVAction? = nil,
                bodyTappedAction: TVAction? = nil,
                normalImage: UIImage? = nil,
                selectedImage: UIImage? = nil)
    {
        self.title = title
        self.view = view
        self.tabSelectedAction = tabSelectedAction
        self.bodyTappedAction = bodyTappedAction
        self.normalImage = normalImage
        self.selectedImage = selectedImage
    }
}

open class TabView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    open var tabHeight: CGFloat             = 44.0

    open var tabBackgroundColor: UIColor?
    open var tabBackGroundImage: UIImage?
    open var tabHorizontalMargin: CGFloat   = 0
    open var tabLineTopMargin: CGFloat      = 0
    open var bodyTopMargin: CGFloat         = 20.0
    open var bodyBottomMargin: CGFloat      = 20.0

    open var tabFontSize: CGFloat           = 14.0
    open var titleColor                     = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    open var selectedTitleColor             = UIColor(red: 33.0/255.0, green: 149.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    open var tabLineColor: UIColor?
    open var selectedTabLineColor: UIColor? = UIColor(red: 33.0/255.0, green: 149.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    open var bodyDragEnable: Bool = true {
        didSet {
            bodyView?.isScrollEnabled = bodyDragEnable
        }
    }
    open var items = [TVItem]() {
        didSet {
            p_buidSubviews()
        }
    }
    
    open var selectedIndex: Int {
        get {
            return currentIndex
        }
        set {
            tapped(newValue)
        }
    }
    
    // Mark: fileprivate
    fileprivate var currentIndex = 0
    fileprivate var bodyView: UICollectionView?
    fileprivate lazy var buttons = [UIButton]()
    fileprivate lazy var tabView = UIView()
    fileprivate lazy var tabLine = UIView()
    fileprivate lazy var selectedTabLine = UIView()
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
        tapped(index)
    }
}

// MARK: - private
fileprivate extension TabView {
    
    func p_buidSubviews() {
        currentIndex = 0
        for view in tabView.subviews {
            view.removeFromSuperview()
        }
        buttons.removeAll()
        if let collectionView = bodyView {
            collectionView.reloadData()
        }
        let count = items.count
        guard count > 0 else {
            return
        }
        tabView.backgroundColor = tabBackgroundColor
        tabLine.backgroundColor = tabLineColor
        selectedTabLine.backgroundColor = selectedTabLineColor
        
        let buttonWidth = (width - tabHorizontalMargin * CGFloat(count + 1)) / CGFloat(count)
        
        addSubview(tabView)
        tabView.frame = CGRect(x: 0, y: 0, width: width, height: tabHeight)
        addSubview(tabLine)
        tabLine.frame = CGRect(x: 0, y: tabHeight - 1, width: width, height: 1)
        tabLine.addSubview(selectedTabLine)
        selectedTabLine.frame = CGRect(x: tabHorizontalMargin, y: 0, width: buttonWidth, height: 1)
        
        for (i,item) in items.enumerated() {
            let button = UIButton(type: .custom)
            let floatI = CGFloat(i)
            button.frame = CGRect(x: buttonWidth * floatI, y: 0, width: buttonWidth, height: tabHeight)
            button.titleLabel?.baselineAdjustment = .alignCenters
            button.titleLabel?.font = UIFont.systemFont(ofSize: tabFontSize)
            button.setTitleColor(titleColor, for: .normal)
            button.setTitleColor(selectedTitleColor, for: .selected)
            button.tag = i;
            button.addTarget(self, action: #selector(tabTapped), for: .touchUpInside)
            
            button.setTitle(item.title, for: .normal)
            button.setTitle(item.title, for: .selected)
            
            if let normalImage = item.normalImage {
                
                button.setImage(normalImage, for: .normal)
                if let imageSize = button.imageView?.frame.size {
                    button.titleEdgeInsets = UIEdgeInsets(top: imageSize.height, left: -imageSize.width, bottom: 0, right: 0)
                }
                if let titleSize = button.titleLabel?.bounds.size {
                    button.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height, left: 0, bottom: 0, right: -titleSize.width)
                }
            }
            if let selectedImage = item.selectedImage {
                button.setImage(selectedImage, for: .selected)
            }
            if let tabBackGroundImage = tabBackGroundImage {
                button .setBackgroundImage(tabBackGroundImage, for: .selected)
                button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            }
            button.setBackgroundImage(nil, for: .normal)
            
            tabView.addSubview(button)
            buttons.append(button)
            if i == 0 {
                button.isSelected = true
            }
        }
        
        layoutIfNeeded()
        if bodyView == nil {
            bodyView = createBodyView()
        }
        bodyView?.reloadData()
        tapped(0)
    }
    
    @objc func tabTapped(_ button: UIButton) {
        tapped(button.tag)
    }
    
    func tapped(_ index: Int) {
        guard currentIndex != index else { return }
        
        let preButton = buttons[currentIndex]
        let currentButton = buttons[index]
        currentIndex = index
        
        UIView.animate(withDuration: 0.3, animations: {
            preButton.isSelected = false
            currentButton.isSelected = true
            let point = CGPoint(x: currentButton.center.x, y: self.selectedTabLine.center.y)
            self.selectedTabLine.center = point
        })
        scrollBody()
        self.items[index].tabSelectedAction?()
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
        collectionView.autoresizingMask = [.flexibleWidth,
                                           .flexibleHeight,
                                           .flexibleBottomMargin]
        addSubview(collectionView)
        
        return collectionView
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
    
    var width: CGFloat {
        return self.frame.size.width
    }
    
    var height: CGFloat {
        return self.frame.size.height
    }
    
    func scrollBody() {
        let point = CGPoint(x: width * CGFloat(currentIndex), y: 0)
        bodyView?.setContentOffset(point, animated: true)
    }
}
