//
//  AddHidingOnClick.swift
//  AQUA
//
//  Created by Tagir Kabirov on 10.04.2022.
//

import Foundation
import UIKit

class AddHidingOnClick: AnnouncementDecorator {
    init(announcement: Announcement, controller: UIViewController) {
        super.init(announcement: announcement)
    }
    
    func addTapRecognizer(controller: UIViewController){
        let gesture = UITapGestureRecognizer(target: controller, action:  #selector (self.close (_:)))
        self.announcementView.addGestureRecognizer(gesture)
    }
    
    @objc func close(_ sender:UITapGestureRecognizer){
        super.closeAnnouncement()
    }
}
