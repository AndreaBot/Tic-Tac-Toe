//
//  AppBrain.swift
//  Tic-Tac-Toe
//
//  Created by Andrea Bottino on 25/03/2023.
//

import UIKit


struct Brain {
    
    func setButton (_ selectButton: UIButton) {
        selectButton.layer.borderWidth = 4
        selectButton.layer.borderColor = CGColor(gray: 0, alpha: 1)
        selectButton.layer.cornerRadius = 25
    
    }
    func disableButton (_ selectButton: UIButton) {
        selectButton.isEnabled = false
        selectButton.alpha = 0.3
    }
    
    func enableButton (_ selectButton: UIButton) {
        selectButton.isEnabled = true
        selectButton.alpha = 1
    }
    
    func checkCond (_ b1: UIButton,_ b2: UIButton,_ b3: UIButton, _ image: UIImage) -> Bool {
        if b1.currentImage == image && (b1.currentImage == b2.currentImage && b1.currentImage == b3.currentImage) {
            b1.backgroundColor = UIColor(red: 0.3, green: 0.8, blue: 1, alpha: 0.8)
            b2.backgroundColor = UIColor(red: 0.3, green: 0.8, blue: 1, alpha: 0.8)
            b3.backgroundColor = UIColor(red: 0.3, green: 0.8, blue: 1, alpha: 0.8)
            return true
        } else {
            return false
        }
    }
}

