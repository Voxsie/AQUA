//
//  RegisterViewController.swift
//  AQUA
//
//  Created by Илья Желтиков on 03.04.2022.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapSwipeRegonizer()
        setGradientBackground()
        customize()
        
    }
}

//MARK: - Customizing
extension RegisterViewController {
    
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
        registerButton.layer.cornerRadius = 10
        
        loginTextField.indent(size: 10)
        passwordTextField.indent(size: 10)
        
        
        registerButton.titleLabel!.font = UIFont(name: "Inter-Regular", size: 20)
        loginTextField.font = UIFont(name: "Inter-Regular", size: 18)
        passwordTextField.font = UIFont(name: "Inter-Regular", size: 18)
        
        registerButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        registerButton.layer.shadowOpacity = 1
        registerButton.layer.shadowRadius = 4
        registerButton.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}

//MARK: - Gestures
extension RegisterViewController {
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
        confirmPasswordTextField.resignFirstResponder()
        }

    @objc private func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        sender.direction = .right
        self.dismiss(animated: true, completion: nil)
    }
}

