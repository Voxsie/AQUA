//
//  StartupViewController.swift
//  AQUA
//
//  Created by Илья Желтиков on 03.04.2022.
//

import UIKit

class StartupViewController: UIViewController {
    
    #warning("Ильяс, привет!!")
    #warning("PS: апи пока выключили, допиливаем")
    #warning("Тагир, не стирай это")
    
    
    #warning("Добавь DismissTransition, потом это сотри")
    
    //MARK: - Outlets and vars

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomButtonStyle()
        setGradientBackground()

        let seconds = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.loadLogo()
        }
    }
    
    //MARK: - Funcs
    
    @IBAction func didLoginButton(_ sender: Any) {
        pushLoginVC()
    }
    
    @IBAction func didRegisterButton(_ sender: Any) {
        pushRegisterVC()
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
    
    func pushLoginVC() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        vc!.modalPresentationStyle = .custom
        vc!.transitioningDelegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    func pushRegisterVC() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        vc!.modalPresentationStyle = .custom
        vc!.transitioningDelegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    //MARK: - Animations
    private func loadLogo() {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction],animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
    }
    
    #warning("Добавь ShakeLogo, потом это сотри")
    
}

extension StartupViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
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
