//
//  AnnouncementDecorator.swift
//  AQUA
//
//  Created by Tagir Kabirov on 10.04.2022.
//

import Foundation
import UIKit

class AnnouncementDecorator: Announcement {
    var announcementView: UIView
    var superView: UIView
    
    init(announcement: Announcement){
        self.announcementView = announcement.announcementView
        self.superView = announcement.superView
    }
}
