//
//  onboardingViewController.swift
//  Ping
//
//  Created by Gokul Nair on 26/11/20.
//

import UIKit

class onboardingViewController: UIViewController {

    @IBOutlet weak var contBtn: UIButton!
    @IBOutlet weak var appIconView: UIImageView!
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contBtn.layer.cornerRadius = 20
        appIconView.layer.cornerRadius = 8
        
        makeRounded(image: image1)
        makeRounded(image: image2)
        makeRounded(image: image3)
        makeRounded(image: image4)
    }
    
    @IBAction func continueBtn(_ sender: Any) {
        self.dismiss(animated:true)
        core.shared.setIsNotNewUser()
        haptic.hapticTouch.haptiFeedbackSucess()
    }
    
   // Function to make image view round in shape
    func makeRounded(image: UIImageView) {

        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.bounds.height/2
        image.clipsToBounds = true
       }
}
