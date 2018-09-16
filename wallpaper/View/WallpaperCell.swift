//
//  WallpaperCell.swift
//  wallpaper
//
//  Created by satkis on 9/16/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit
import Hero

class WallpaperCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var imageDetailsLabel: UILabel!
    @IBOutlet weak var imageStatusLabel: UILabel!
    @IBOutlet weak var imageCover: UIView!
    
    var wallpaper: Wallpaper!
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        
    }

    
    func configureCell(wallpaper: Wallpaper) {
        self.wallpaper = wallpaper
        
        imageView.image = UIImage(named: "\(self.wallpaper.wallpaperId)")
        imageTitleLabel.text = self.wallpaper.wallpaperName
        imageDetailsLabel.text = self.wallpaper.wallpaperDetails
        imageStatusLabel.text = self.wallpaper.wallpaperStatus
        imageView.hero.id = String(wallpaper.wallpaperId)
        
//        let mutable = NSMutableAttributedString(string: imageDetailsLabel.text!)
//        var startIndex = imageDetailsLabel.text?.startIndex
////        while let range = imageDetailsLabel.text?.range(of: "\\S+", options: NSRegularExpression, range:
//
//        while let range = imageDetailsLabel.text?.range(of: "\\S+", options: .regularExpression, range: startIndex..<imageDetailsLabel.text?.endIndex) {
//            mutable.addAttribute(.backgroundColor, value: UIColor.black, range: NSRange(range, in: imageDetailsLabel.text!))
//            startIndex = range.upperBound
//        }
//        imageDetailsLabel.attributedText = mutable
    }
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let featuredHeight = FeedLayoutConstants.Cell.featureHeight
        let standardHeight = FeedLayoutConstants.Cell.standardHeight
        let delta = 1 - (featuredHeight - self.frame.size.height) / (featuredHeight - standardHeight)
        
        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
        
        imageCover.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.8)
        imageTitleLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        imageStatusLabel.alpha = delta
        imageDetailsLabel.alpha = delta
    }
    
}
