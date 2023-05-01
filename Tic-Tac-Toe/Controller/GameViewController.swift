//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Andrea Bottino on 25/03/2023.
//

import UIKit
import AVFoundation


class GameViewController: UIViewController {
    

    @IBOutlet weak var winCounts1: UILabel!
    @IBOutlet weak var turnLabel1: UILabel!
    
    @IBOutlet weak var turnLabel2: UILabel!
    @IBOutlet weak var winCounts2: UILabel!
    
    @IBOutlet var allButtons: [UIButton]!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var resetScore: UIButton!
    
    var player: AVAudioPlayer!
    
    var game = Brain()
    
    var xColor: UIColor = .clear
    var oColor: UIColor = .clear
    let uiColor = UIColor(named: "Light-Dark Color")

    var imageX = UIImage(systemName: "xmark")
    var imageO = UIImage(systemName: "circle")
    
    var config = UIImage.SymbolConfiguration(pointSize: 50, weight: .semibold)
    
    var tapCount = 0
    
    var countX = 0
    var countO = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        winCounts1.text = "X  \(countX) - \(countO)  O"
        winCounts2.text = winCounts1.text
        turnLabel1.text = "X Turn"
        turnLabel1.textColor = xColor
        turnLabel2.text = turnLabel1.text
        for button in allButtons {
            button.setTitle("", for: .normal)
        }
        game.setButton(backButton)
        game.setButton(newGameButton)
        game.setButton(resetScore)
        game.disableButton(newGameButton)
        game.disableButton(resetScore)
        turnLabel2.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        winCounts2.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        backButton.tintColor = UIColor.init(named: "Light-Dark Color")
        newGameButton.tintColor = UIColor.init(named: "Light-Dark Color")
        resetScore.tintColor = UIColor.init(named: "Light-Dark Color")
        
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

    func winX() -> Bool {
        let xLessColor = xColor.withAlphaComponent(0.4)
        if game.checkCond(allButtons[0], allButtons[1], allButtons[2], imageX!, xLessColor) ||
            game.checkCond(allButtons[3], allButtons[4], allButtons[5], imageX!, xLessColor) ||
            game.checkCond(allButtons[6], allButtons[7], allButtons[8], imageX!, xLessColor) ||
            game.checkCond(allButtons[0], allButtons[3], allButtons[6], imageX!, xLessColor) ||
            game.checkCond(allButtons[1], allButtons[4], allButtons[7], imageX!, xLessColor) ||
            game.checkCond(allButtons[2], allButtons[5], allButtons[8], imageX!, xLessColor) ||
            game.checkCond(allButtons[0], allButtons[4], allButtons[8], imageX!, xLessColor) ||
            game.checkCond(allButtons[6], allButtons[4], allButtons[2], imageX!, xLessColor) {
            return true
        } else {
            return false
        }
    }

    func winO() -> Bool {
        let oLessColor = oColor.withAlphaComponent(0.4)
        if game.checkCond(allButtons[0], allButtons[1], allButtons[2], imageO!, oLessColor) ||
            game.checkCond(allButtons[3], allButtons[4], allButtons[5], imageO!, oLessColor) ||
            game.checkCond(allButtons[6], allButtons[7], allButtons[8], imageO!, oLessColor) ||
            game.checkCond(allButtons[0], allButtons[3], allButtons[6], imageO!, oLessColor) ||
            game.checkCond(allButtons[1], allButtons[4], allButtons[7], imageO!, oLessColor) ||
            game.checkCond(allButtons[2], allButtons[5], allButtons[8], imageO!, oLessColor) ||
            game.checkCond(allButtons[0], allButtons[4], allButtons[8], imageO!, oLessColor) ||
            game.checkCond(allButtons[6], allButtons[4], allButtons[2], imageO!, oLessColor) {
            return true
        } else {
            return false
        }
    }

    func Tie() {
        turnLabel1.text = "It's a tie!"
        turnLabel1.textColor = .black

        turnLabel2.text = "It's a tie!"
        turnLabel2.textColor = .black

        game.enableButton(newGameButton)
    }
    
    @IBAction func buttonIsPressed(_ sender: UIButton) {
        imageX = UIImage(systemName: "xmark", withConfiguration: config)
        imageO = UIImage(systemName: "circle", withConfiguration: config)
        tapCount += 1
        sender.isEnabled = false
        
        if tapCount % 2 != 0 {
            sender.setImage(imageX, for: .disabled)
            sender.tintColor = xColor
            playSound(soundName: "X-sound")
        } else if tapCount % 2 == 0 {
            sender.setImage(imageO, for: .disabled)
            sender.tintColor = oColor
            playSound(soundName: "O-sound")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            
            if tapCount % 2 != 0 {
                turnLabel1.text = "O Turn"
                turnLabel1.textColor = oColor
                
                turnLabel2.text = "O Turn"
                turnLabel2.textColor = oColor
                
            } else if tapCount % 2 == 0 {
                turnLabel1.text = "X Turn"
                turnLabel1.textColor = xColor
                
                turnLabel2.text = "X Turn"
                turnLabel2.textColor = xColor
                
            }
            if winX() {

                let lightDarkCgColor = uiColor!.cgColor

                for button in allButtons {
                    button.isEnabled = false
                }
                countX += 1
                winCounts1.text = "X  \(countX) - \(countO)  O"
                turnLabel1.text = "X WINS!"
                turnLabel1.layer.borderWidth = 3
                turnLabel1.layer.borderColor = lightDarkCgColor
                turnLabel1.textColor = xColor
                
                winCounts2.text = "X  \(countX) - \(countO)  O"
                turnLabel2.text = "X WINS!"
                turnLabel2.layer.borderWidth = 3
                turnLabel2.layer.borderColor = lightDarkCgColor
                turnLabel2.textColor = xColor
                
                game.enableButton(newGameButton)
                game.enableButton(resetScore)
                
            } else if winO() {

                let lightDarkCgColor = uiColor!.cgColor
                
                for button in allButtons {
                    button.isEnabled = false
                }
                countO += 1
                winCounts1.text = "X  \(countX) - \(countO)  O"
                turnLabel1.text = "O WINS!"
                turnLabel1.layer.borderWidth = 3
                turnLabel1.layer.borderColor = lightDarkCgColor
                turnLabel1.textColor = oColor
                
                winCounts2.text = "X  \(countX) - \(countO)  O"
                turnLabel2.text = "O WINS!"
                turnLabel2.layer.borderWidth = 3
                turnLabel2.layer.borderColor = lightDarkCgColor
                turnLabel2.textColor = oColor
                
                game.enableButton(newGameButton)
                game.enableButton(resetScore)
                
            } else if allButtons.allSatisfy({ $0.isEnabled == false }) {
                
                Tie()
            }
        }
    }
        
    @IBAction func newGame(_ sender: UIButton) {
            
            setNewGame()
        }
        
    @IBAction func resetScore(_ sender: UIButton) {
            countX = 0
            countO = 0
            winCounts1.text = "X  \(countX) - \(countO)  O"
            winCounts2.text = "X  \(countX) - \(countO)  O"
            game.disableButton(resetScore)
            setNewGame()
        }
        
        func setNewGame() {
            for button in allButtons {
                button.setImage(nil, for: .disabled)
                button.isEnabled = true
                button.backgroundColor = .clear
            }
            turnLabel1.layer.borderWidth = 0
            turnLabel2.layer.borderWidth = 0
            if tapCount % 2 == 0 {
                turnLabel1.text = "X TURN"
                turnLabel2.text = "X TURN"
                turnLabel1.textColor = xColor
                turnLabel2.textColor = xColor
            } else {
                turnLabel1.text = "O TURN"
                turnLabel2.text = "O TURN"
                turnLabel1.textColor = oColor
                turnLabel2.textColor = oColor
            }
            game.disableButton(newGameButton)
        }

    @IBAction func backIsPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
    


