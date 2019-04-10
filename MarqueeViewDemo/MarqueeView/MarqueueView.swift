//
//  MarqueueView.swift
//  MarqueeViewDemo
//
//  Created by Zhihui Sun on 9/4/19.
//  Copyright © 2019 Sylvia Shen. All rights reserved.
//

import UIKit

enum Orientation {
    case horizontal
    case vertical
}

class MarqueueView: UIView {
    private var collectionView: UICollectionView?
    private var layout = UICollectionViewFlowLayout()
    private var swipeOrientation: Orientation = .horizontal
    private var timer: Timer?
    private var currentItemIndex = 0
    
    private var cellModels: [MarqueueViewCellModelProtocol]?
    private var cellNib: UINib?
    private var timeInterval: TimeInterval?

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView?.frame = bounds
        layout.itemSize = bounds.size
    }

    private func configureCollectionView() {
        layout.minimumLineSpacing = 0
        switch swipeOrientation {
        case .horizontal:
            layout.scrollDirection = .horizontal
        case .vertical:
            layout.scrollDirection = .vertical
        }
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(cellNib, forCellWithReuseIdentifier: "Cell")
        collectionView?.backgroundColor = UIColor.blue
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        addSubview(collectionView!)
        startScrollingTimer()
    }
    
    func configure(models: [MarqueueViewCellModelProtocol], customCellNib: UINib, orientation: Orientation = .vertical, interval: TimeInterval) {
        swipeOrientation = orientation
        cellModels = models
        cellNib = customCellNib
        timeInterval = interval
        configureCollectionView()
    }
    
    
    private func startScrollingTimer() {
        guard timer == nil, timeInterval != nil else { return }
        timer = Timer.scheduledTimer(timeInterval: timeInterval!, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    @objc private func scrollToNext() {
        guard timer != nil else { return }
        currentItemIndex = currentItemIndex + 1
        var animated: Bool
        var scrollPosition: UICollectionView.ScrollPosition
        if currentItemIndex >= cellModels?.count ?? 0 {
            currentItemIndex = 0
            animated = false
        } else {
            animated = true
        }
        switch swipeOrientation {
        case .horizontal:
            scrollPosition = .right
        case .vertical:
            scrollPosition = .bottom
        }
        let nextIndexPath = IndexPath(item: currentItemIndex, section: 0)
        collectionView?.scrollToItem(at: nextIndexPath, at: scrollPosition, animated: animated)
    }
    
    private func destroyScrollingTimer() {
        timer?.invalidate()
        timer = nil
    }
}


extension MarqueueView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        destroyScrollingTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        currentItemIndex = Int(scrollView.contentOffset.y / scrollView.bounds.height)
        startScrollingTimer()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if let marqueueCell = cell as? MarqueueViewCellProtocol,
            let model = cellModels?[indexPath.row] {
            marqueueCell.configure(with: model)
        }
        return cell
    }
}
