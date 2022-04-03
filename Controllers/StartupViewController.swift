//
//  StartupViewController.swift
//  AQUA
//
//  Created by Илья Желтиков on 03.04.2022.
//

import UIKit

class StartupViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomButtonStyle()
        setGradientBackground()

        // Do any additional setup after loading the view.
    }
    
    func setCustomButtonStyle() {
        loginButton.customizeStartUp()
        registerButton.customizeStartUp()
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 77/255, green: 63/255, blue: 239/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 53/255, green: 217/255, blue: 233/255, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
}

extension UIButton {
    func customizeStartUp() {
        self.layer.cornerRadius = 10
        self.titleLabel!.font = UIFont(name: "Inter-Regular", size: 20)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}
