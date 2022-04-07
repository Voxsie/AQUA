//
//  AlertAnimationViewController.swift
//  AQUA
//
//  Created by Tagir Kabirov on 07.04.2022.
//

import UIKit

class AlertAnimationViewController: UIViewController {

    
    let popUpView = UIView()
    let imageView = UIImageView(image: UIImage(named: "cross"))
    let label = UILabel()
    var popUpOriginCoordinate: CGFloat?
    var viewHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHeight = view.frame.size.height
        popUpView.backgroundColor = UIColor(red: 255/255, green: 41/255, blue: 66/255, alpha: 0.9)
        popUpView.frame = CGRect(x: 16, y: viewHeight + 30, width: self.view.frame.width - 32, height: 50)
        popUpView.layer.cornerRadius = 5
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.popUpView.addGestureRecognizer(gesture)
        
        imageView.frame = CGRect(x: 10, y: 12, width: 26, height: 26)
        label.frame = CGRect(x: 40, y: 10, width: self.view.frame.width - 60, height: 30)
        label.font = .boldSystemFont(ofSize: 15)
        label.text = "Соединение с сервером отсутсвует"
        label.textColor = .white
        
        popUpView.addSubview(imageView)
        popUpView.addSubview(label)
        
        self.view.addSubview(popUpView)
    }

    @IBAction func popButtonPressed(_ sender: Any) {
        if popUpView.frame.origin.y == viewHeight + 30 {
            popUpView.transform = CGAffineTransform(scaleX: 0.7, y: 1.2)
            UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
                self.popUpView.transform = .identity
                self.popUpView.frame.origin.y = self.view.frame.size.height - 100
            })
        }
        else {
            UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
                self.popUpView.transform = .identity
                self.popUpView.frame.origin.y = self.viewHeight + 30
            })
        }
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
            self.popUpView.transform = .identity
            self.popUpView.frame.origin.y = self.viewHeight + 30
        })
    }

}
