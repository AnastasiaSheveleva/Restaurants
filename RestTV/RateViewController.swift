//
//  RateViewController.swift
//  RestTV
//
//  Created by Анастасия on 28.09.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var rating: String?
    
    @IBOutlet weak var stack: UIStackView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var greatButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    
    @IBOutlet var rateButtons: [UIButton]?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scale = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let screenHeight = UIScreen.main.bounds.size.height as CGFloat
        let translation = CGAffineTransform(translationX: 0, y: (screenHeight * 0.6))
        //stack.transform = scale.concatenating(translation)
        label.transform = scale
        greatButton.transform = scale.concatenating(translation)
        goodButton.transform = scale.concatenating(translation)
        dislikeButton.transform = scale.concatenating(translation)
        
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.92
        backgroundImageView.addSubview(blurEffectView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            self.label.transform = CGAffineTransform.identity
            }, completion: nil)
        
        /*
        UIView.animate(withDuration: 0.8, delay: 0.0, options: [], animations: {
            self.stack.transform = CGAffineTransform.identity
            }, completion: nil)
        */
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [], animations: {
            self.dislikeButton.transform = CGAffineTransform.identity
            }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 0.4, options: [], animations: {
            self.goodButton.transform = CGAffineTransform.identity
            }, completion: nil)
        
        UIView.animate(withDuration: 0.9, delay: 0.6, options: [], animations: {
            self.greatButton.transform = CGAffineTransform.identity
            }, completion: nil)
        
    }
    
    @IBAction func rateSelect(sender: UIButton) {
        var translation: CGAffineTransform?
        switch sender.tag {
        case 1:
            rating = "dislike"
            translation = CGAffineTransform(translationX: 100, y: 0)
        case 2:
            rating = "good"
            translation = CGAffineTransform(translationX: 0, y: 0)
        case 3:
            rating = "great"
            translation = CGAffineTransform(translationX: -100, y: 0)
        default: break
        }
        let unselectedButtons = rateButtons?.filter{ $0 != sender}
        let scale1 = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let scale2 = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        //let translation = CGAffineTransform(translationX: 200, y: 0)
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: {
            sender.transform = scale2.concatenating(translation!)
//            sender.center = (sender.superview!.center)
            for element in unselectedButtons! {
                element.transform = scale1
            }
            
            }, completion: {(finished: Bool) in
                self.performSegue(withIdentifier: "unwindToDetail", sender: sender)
                
        })
        
    }
    
    
   /* @IBAction func rateSelect(sender: UIButton) {
        switch sender.tag {
        case 1:
            rating = "dislike"
            selectedButton = dislikeButton
            unselectedButton1 = goodButton
            unselectedButton2 = greatButton
        case 2:
            rating = "good"
            selectedButton = goodButton
            unselectedButton1 = dislikeButton
            unselectedButton2 = greatButton
        case 3:
            rating = "great"
            selectedButton = greatButton
            unselectedButton1 = goodButton
            unselectedButton2 = dislikeButton
        default: break
        }
        let scale1 = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let scale2 = CGAffineTransform(scaleX: 2.0, y: 2.0)
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            self.selectedButton?.transform = scale2
            self.unselectedButton1?.transform = scale1
            self.unselectedButton2?.transform = scale1
            }, completion: {(finished: Bool) in
                self.performSegue(withIdentifier: "unwindToDetail", sender: sender)
 
        })
        
    } */
    
    
   /* override func viewWillDisappear(_ animated: Bool) {
        let scale1 = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let scale2 = CGAffineTransform(scaleX: 2.0, y: 2.0)
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            self.selectedButton?.transform = scale2
            self.unselectedButton1?.transform = scale1
            self.unselectedButton2?.transform = scale1
            }, completion: nil)
     }*/
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
