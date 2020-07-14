//
//  CardViewController.swift
//  Project37
//
//  Created by jc on 2020-07-12.
//  Copyright © 2020 J. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    weak var delegate: ViewController!
    
    var front: UIImageView!
    var back: UIImageView!
    
    var isCorrect = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bounds = CGRect(x: 0, y: 0, width: 100, height: 140)
        front = UIImageView(image: UIImage(named: "cardBack"))
        back = UIImageView(image: UIImage(named: "cardBack"))
        
        view.addSubview(front)
        view.addSubview(back)
        
        front.isHidden = true
        back.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            self.back.alpha = 1
        }
        
        wiggle()
    }
    
    @objc func wiggle() {
        if Int.random(in: 0...3) == 1 {
            UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: {
                self.back.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)
            }) { (_) in
                self.back.transform = CGAffineTransform.identity
            }
            
            perform(#selector(wiggle), with: nil, afterDelay: 8)
        } else {
            perform(#selector(wiggle), with: nil, afterDelay: 2)
        }
    }
    
}
