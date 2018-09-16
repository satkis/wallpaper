//
//  ViewController.swift
//  wallpaper
//
//  Created by satkis on 9/16/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var menuViewLabel: UIView!
    
    var wallpapers = [Wallpaper]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        
        DataService.ds.URL_WALLPAPERS.observe(.value) { (snapshot) in
            print(snapshot.value as Any)
            
            self.wallpapers = []
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshots {
                    if let wallpaperDict = snap.value as? Dictionary<String, AnyObject> {
                        //key is user/post ID
                        let key = snap.key
                        let wallpaperPost = Wallpaper(postKey: key, dictionary: wallpaperDict)
                        self.wallpapers.append(wallpaperPost)
                    }
                }
            }
            self.collection.reloadData()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WallpaperCell", for: indexPath) as? WallpaperCell {
            
            //            let wallpaper = Wallpaper(wallpaperName: "Test", wallpaperId: indexPath.row, wallpaperDetails: "testing testing", wallpaperStatus: "Live")
            
            let wall = Wallpaper(wallpaperName: "test", wallpaperId: indexPath.item, wallpaperDetails: "test test", wallpaperStatus: "Live")
            cell.configureCell(wallpaper: wall)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallpapers.count
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var wallpaperr: Wallpaper!

        wallpaperr = wallpapers[indexPath.row]

        
        performSegue(withIdentifier: "WallpaperDetailVC", sender: wallpaperr)
        
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "WallpaperDetailVC" {
//            if let detailVC = segue.destination as? WallpaperDetailVC {
//                if let wallppr = sender as? Wallpaper {
//                    detailVC.wallpaper = wallppr
//                }
//            }
//        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(1)
//    }

    //https://stackoverflow.com/questions/31928394/ios-swift-hide-show-uitabbarcontroller-when-scrolling-down-up
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            changeTabBar(hidden: true, animated: true)
        }else{
            changeTabBar(hidden: false, animated: true)
        }
        
    }
    
    func changeTabBar(hidden:Bool, animated: Bool){
        let tabBar = self.menuViewLabel
        if tabBar!.isHidden == hidden{ return }
        let frame = tabBar?.frame
        let offset = (hidden ? (frame?.size.height)! : -(frame?.size.height)!)
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar?.isHidden = false
        if frame != nil
        {
            UIView.animate(withDuration: duration,
                           animations: {tabBar!.frame = frame!.offsetBy(dx: 0, dy: offset)},
                           completion: {
                            print($0)
                            if $0 {tabBar?.isHidden = hidden}
            })
        }
    }
    
    

}

