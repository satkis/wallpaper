
//
//  DataService.swift
//  wallpaper
//
//  Created by satkis on 9/17/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import Foundation
import Firebase

let URL_GENERAL = Database.database().reference(fromURL: "https://wallpaper-6d603.firebaseio.com/")

class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = URL_GENERAL
    private var _REF_WALLPAPERS = URL_GENERAL.child("wallpapers")
    
    
    // make publicly available
    var URL_BASE: DatabaseReference! {
        return _REF_BASE
    }
    
    var URL_WALLPAPERS: DatabaseReference! {
        return _REF_WALLPAPERS
    }

}
