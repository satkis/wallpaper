//
//  FeedLayout.swift
//  wallpaper
//
//  Created by satkis on 9/16/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit

struct FeedLayoutConstants {
    struct Cell {
        static let standardHeight: CGFloat = 130
        static let featureHeight: CGFloat = 280
    }
}

class FeedLayout: UICollectionViewLayout {
    
    let dragOffset: CGFloat = 180.0
    var cache = [UICollectionViewLayoutAttributes]()
    
    var featuredItemIndex: Int {
        get {
            return max(0, Int(collectionView!.contentOffset.y / dragOffset))
        }
    }
    
    var nextItemPercentageOffset: CGFloat {
        get {
            return (collectionView!.contentOffset.y / dragOffset) - CGFloat(featuredItemIndex)
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    
    var numberOfItems: Int {
        get {
//            return collectionView!.numberOfItems(inSection: 0)
            return 5
        }
    }
    
    override var collectionViewContentSize: CGSize {
        let collection = collectionView!
        let width = collection.bounds.size.width
        let height = collection.bounds.size.height
        let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepare() {
        cache.removeAll(keepingCapacity: false)
        
        let standardHeight = FeedLayoutConstants.Cell.standardHeight
        let featuredHeight = FeedLayoutConstants.Cell.featureHeight
        
        var frame = CGRect.zero
        var y: CGFloat = 0
        
        for item in 0..<numberOfItems {
            //      let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let indexPath = NSIndexPath(item: item, section: 0)
            //      let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath as IndexPath)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
            /* Important because each cell has to slide over the top of the previous one */
            attributes.zIndex = item
            /* Initially set the height of the cell to the standard height */
            var height = standardHeight
            if indexPath.item == featuredItemIndex {
                /* The featured cell */
                let yOffset = standardHeight * nextItemPercentageOffset
                y = collectionView!.contentOffset.y - yOffset
                height = featuredHeight
            } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                /* The cell directly below the featured cell, which grows as the user scrolls */
                let maxY = y + standardHeight
                height = standardHeight + max((featuredHeight - standardHeight) * nextItemPercentageOffset, 0)
                y = maxY - height
            }
            frame = CGRect(x: 0, y: y, width: (collectionView?.bounds.size.width)!, height: height)
            attributes.frame = frame
            cache.append(attributes)
            //      y = CGRectGetMaxY(frame)
            y = frame.maxY
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        let itemIndex = round(proposedContentOffset.y / dragOffset)
        let yOffset = itemIndex * dragOffset
        return CGPoint(x: 0, y: yOffset)
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
}
