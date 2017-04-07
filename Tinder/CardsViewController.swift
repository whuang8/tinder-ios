//
//  CardsViewController.swift
//  Tinder
//
//  Created by William Huang on 4/6/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var cardImageView: UIImageView!
    var cardInitialCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        cardImageView.layer.cornerRadius = 5
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanImage(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            cardInitialCenter = cardImageView.center
        } else if sender.state == .changed {
            cardImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            if cardImageView.center.x > cardInitialCenter.x {
                UIView.animate(withDuration: 0.3, animations: {
                    self.cardImageView.transform = self.cardImageView.transform.rotated(by:  0.01)
                })
            }
            else if cardImageView.center.x < cardInitialCenter.x {
                UIView.animate(withDuration: 0.3, animations: {
                    self.cardImageView.transform = self.cardImageView.transform.rotated(by:  -0.01)
                })
            }
        
            cardImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
        } else if sender.state == .ended {
            if translation.x > 50 {
                UIView.animate(withDuration: 1, animations: {
                    self.cardImageView.center = CGPoint(x: 1000, y: self.cardImageView.center.y)
                }, completion: { (success: Bool) in
                    if success {
                        self.cardImageView.center = self.cardInitialCenter
                        self.cardImageView.transform = CGAffineTransform.identity

                    }
                })
            }
            else if translation.x < -50 {
                UIView.animate(withDuration: 1, animations: {
                    self.cardImageView.center = CGPoint(x: -1000, y: self.cardImageView.center.y)
                }, completion: { (success: Bool) in
                    if success {
                        self.cardImageView.center = self.cardInitialCenter
                        self.cardImageView.transform = CGAffineTransform.identity
                        
                    }
                })
            } else {
                cardImageView.center = cardInitialCenter
                cardImageView.transform = CGAffineTransform.identity
            }
        }
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let profileViewController = segue.destination as! ProfileViewController
        let image = self.cardImageView.image
        profileViewController.image = image
    }

}
