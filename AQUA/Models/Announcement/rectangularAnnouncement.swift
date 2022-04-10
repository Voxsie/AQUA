//
//  rectangularAnnouncement.swift
//  AQUA
//
//  Created by Tagir Kabirov on 10.04.2022.
//

import Foundation
import UIKit

class RectangularAnnouncementWithText: Announcement {
    enum announcementImage{
        case error
        case success
        case warning
    }
    
    internal let announcementView:UIView
    internal let superView:UIView
    private var imageView = UIImageView()
    private let label = UILabel()
    
    //MARK: -init
    init(_ text: String, withImage image: announcementImage,on superView: UIView) {
        self.label.text = text
        self.superView = superView
        self.announcementView = UIView()
        
        self.imageView = setImage(image)
        self.setupAnnouncement()
    }
    
    //MARK: -private functions
    private func setupAnnouncement() {
        let superViewHeight = self.superView.frame.size.height
        let superViewWidth = self.superView.frame.size.width
        
        //set characteristic parameters to announcement view
        announcementView.backgroundColor = UIColor(red: 255/255, green: 41/255, blue: 66/255, alpha: 0.9)
        announcementView.frame = CGRect(x: 16, y: superViewHeight + 30, width: superViewWidth - 32, height: 50)
        announcementView.layer.cornerRadius = 5
        
        //add image and label to announcement view
        imageView.frame = CGRect(x: 10, y: 12, width: 26, height: 26)
        label.frame = CGRect(x: 40, y: 10, width: self.superView.frame.width - 60, height: 30)
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        
        announcementView.addSubview(imageView)
        announcementView.addSubview(label)
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
