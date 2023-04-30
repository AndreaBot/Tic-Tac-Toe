//
//  AppBrain.swift
//  Tic-Tac-Toe
//
//  Created by Andrea Bottino on 25/03/2023.
//

import UIKit


struct Brain {

    
    func setButton (_ selectButton: UIButton) {
        selectButton.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    
    }
    func disableButton (_ selectButton: UIButton) {
        selectButton.isEnabled = false
        selectButton.alpha = 0.3
    }
    
    func enableButton (_ selectButton: UIButton) {
        selectButton.isEnabled = true
        selectButton.alpha = 1
    }
    
    func checkCond (_ b1: UIButton,_ b2: UIButton,_ b3: UIButton, _ image: UIImage, _ color: UIColor) -> Bool {
        if b1.currentImage == image && (b1.currentImage == b2.currentImage && b1.currentImage == b3.currentImage) {
            b1.backgroundColor = color
            b2.backgroundColor = color
            b3.backgroundColor = color
            return true
        } else {
            return false
        }
    }
}

