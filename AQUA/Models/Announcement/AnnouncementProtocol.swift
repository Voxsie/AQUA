//
//  InformationField.swift
//  AQUA
//
//  Created by Tagir Kabirov on 10.04.2022.
//

import Foundation
import UIKit

protocol Announcement{
    var announcementView: UIView { get }
    var superView:UIView { get }
    func showAnnouncement()
    func closeAnnouncement()
}
extension Announcement{
    func showAnnouncement(){
        superView.addSubview(announcementView)
        announcementView.transform = CGAffineTransform(scaleX: 0.7, y: 1.2)
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
            announcementView.transform = .identity
            announcementView.frame.origin.y = superView.frame.size.height - 150
        })
    }
    func closeAnnouncement(){
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
            self.announcementView.transform = .identity
            self.announcementView.frame.origin.y = self.superView.frame.height + 30
        })
    }
}
