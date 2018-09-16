//
//  WallpaperDetailVC.swift
//  wallpaper
//
//  Created by satkis on 9/16/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit

class WallpaperDetailVC: UIViewController {
    
    var wallpaper: Wallpaper!

    @IBOutlet weak var nameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

       // nameLbl.text = wallpaper.wallpaperName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
