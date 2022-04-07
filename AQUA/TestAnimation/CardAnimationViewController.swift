//
//  CardAnimationViewController.swift
//  AQUA
//
//  Created by Tagir Kabirov on 07.04.2022.
//

import UIKit

class CardAnimationViewController: UIViewController {

    private let imageView = UIImageView(image: UIImage(named: "cardImage"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        
        let card = UIView()
        imageView.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        card.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        card.heightAnchor.constraint(equalToConstant: imageView.frame.height).isActive = true
        card.widthAnchor.constraint(equalToConstant: imageView.frame.width).isActive = true
        card.backgroundColor = .green.withAlphaComponent(0.1)
        
        imageView.isUserInteractionEnabled = true
        card.isUserInteractionEnabled = false
        
        imageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.cardDrag)))
    }

    @objc func cardDrag(gesture: UIPanGestureRecognizer){
        
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: self.view)
            imageView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        case .ended:
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
                self.imageView.transform = .identity
            }
        default:
            return
        }
    }

}
