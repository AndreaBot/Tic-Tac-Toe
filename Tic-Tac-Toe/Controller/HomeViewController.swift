//
//  HomeViewController.swift
//  Tic-Tac-Toe
//
//  Created by Andrea Bottino on 07/04/2023.
//

import UIKit

class HomeViewController: UIViewController {

    var home = Brain()
    
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var oButton: UIButton!
    
    @IBOutlet weak var colorWellX: UIColorWell!
    @IBOutlet weak var colorWellO: UIColorWell!
 
    @IBOutlet weak var startButton: UIButton!
    
    var xTap = 0
    var oTap = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        xButton.tintColor = .black
        oButton.tintColor = .black
        
        startButton.layer.borderWidth = 3
        startButton.layer.cornerRadius = 50
        home.disableButton(startButton)
        
        colorWellX.title = "Color Well"
        colorWellO.title = "Color Well"
        
        colorWellX.addTarget(self, action: #selector(colorChangedX), for: .valueChanged)
        colorWellO.addTarget(self, action: #selector(colorChangedO), for: .valueChanged)
    }

    @objc private func colorChangedX() -> UIColor {

        let xColor = colorWellX.selectedColor
        xButton.tintColor = xColor
        xTap = 1
        
        if xTap == 1 && oTap == 1{
            home.enableButton(startButton)
        }
        return xColor!
    }
    
    @objc private func colorChangedO() -> UIColor {

        let oColor = colorWellO.selectedColor
        oButton.tintColor = oColor
        oTap = 1
        
        if xTap == 1 && oTap == 1{
            home.enableButton(startButton)
        }
        return oColor!
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let destinationVC = segue.destination as? GameViewController
            destinationVC?.xColor = colorChangedX()
            destinationVC?.oColor = colorChangedO()
        }
    }
}
