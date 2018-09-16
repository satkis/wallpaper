//
//  Wallpaper.swift
//  wallpaper
//
//  Created by satkis on 9/16/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import Foundation

class Wallpaper {
    private var _wallpaperName: String!
    private var _wallpaperId: Int!
    private var _wallpaperDetails: String!
    private var _wallpaperStatus: String!
    
    var wallpaperName: String {
        return _wallpaperName
    }
    
    var wallpaperId: Int {
        return _wallpaperId
    }
    
    var wallpaperDetails: String {
        return _wallpaperDetails
    }
    
    var wallpaperStatus: String {
        return _wallpaperStatus
    }
    
    init(wallpaperName: String, wallpaperId: Int, wallpaperDetails: String, wallpaperStatus: String) {
        self._wallpaperName = wallpaperName
        self._wallpaperId = wallpaperId
        self._wallpaperDetails = wallpaperDetails
        self._wallpaperStatus = wallpaperStatus
    }
}
