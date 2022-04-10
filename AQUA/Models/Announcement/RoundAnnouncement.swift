//
//  RoundAnnouncement.swift
//  AQUA
//
//  Created by Tagir Kabirov on 10.04.2022.
//

import Foundation
import UIKit

class RoundAnnouncement: Announcement {
    enum announcementImage{
        case error
        case success
        case warning
    }
    
    internal let announcementView:UIView
    internal let superView:UIView
    private var imageView = UIImageView()
    
    init(withImage image: announcementImage,on superView: UIView) {
        self.superView = superView
        self.announcementView = UIView()
        
        self.imageView = setImage(image)
        self.setupAnnouncement()
    }
    
    private func setupAnnouncement() {
        let superViewHeight = self.superView.frame.size.height
        let superViewWidth = self.superView.frame.size.width
        
        //set characteristic parameters to announcement view
        announcementView.backgroundColor = UIColor(red: 255/255, green: 41/255, blue: 66/255, alpha: 0.9)
        announcementView.frame = CGRect(x: superViewWidth/2 - 50, y: superViewHeight - 110, width: 100, height: 100)
        announcementView.layer.cornerRadius = 50
        
        //add image
        imageView.frame = CGRect(x: 10, y: 12, width: 26, height: 26)
        
        announcementView.addSubview(imageView)
    }
    
    private func setImage(_ imageType: announcementImage) -> UIImageView {
        var imageName = ""
        switch imageType {
        case .error:
            imageName = "cross"
        case .success:
            imageName = "exclamation"
        case .warning:
            imageName = "warning"
        }
        
        return UIImageView(image: UIImage(named: imageName))
    }
}
