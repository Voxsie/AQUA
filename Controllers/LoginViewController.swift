//
//  LoginViewController.swift
//  AQUA
//
//  Created by Илья Желтиков on 03.04.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = try? URLBuilder()
                    .with(host: "api.aqua.com")
                    .with(port: 80)
                    .with(path: "/auth")
                    .build()

        tapSwipeRegonizer()
        setGradientBackground()
        customize()
        // Do any additional setup after loading the view.
    }
}

//MARK: - Customizing
extension LoginViewController {
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 77/255, green: 63/255, blue: 239/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 53/255, green: 217/255, blue: 233/255, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func customize() {
        
        loginTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 10
        
        loginTextField.indent(size: 10)
        passwordTextField.indent(size: 10)
        
        
        loginButton.titleLabel!.font = UIFont(name: "Inter-Regular", size: 20)
        loginTextField.font = UIFont(name: "Inter-Regular", size: 18)
        passwordTextField.font = UIFont(name: "Inter-Regular", size: 18)
        
        loginButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        loginButton.layer.shadowOpacity = 1
        loginButton.layer.shadowRadius = 4
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}

#warning("Желтиков - UITapGestureRecognizer, UISwipeGestureRecognizer")
//MARK: - Gestures
extension LoginViewController {
    func tapSwipeRegonizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture))
        view.addGestureRecognizer(tapRecognizer)
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGesture))
        swipeRecognizer.direction = .right
        view.addGestureRecognizer(swipeRecognizer)
    }
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        }

    @objc private func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        sender.direction = .right
        self.dismiss(animated: true, completion: nil)
    }
}
