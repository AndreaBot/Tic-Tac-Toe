//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Andrea Bottino on 25/03/2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    var game = Brain()
    
    @IBOutlet weak var winCounts: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var resetScore: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winCounts.text = "X  \(countX) - \(countO)  O"
        turnLabel.text = "X Turn"
        for button in allButtons {
            button.setTitle("", for: .normal)
        }
        game.setButton(newGameButton)
        game.setButton(resetScore)
        game.disableButton(newGameButton)
        game.disableButton(resetScore)
    }
    
    var imageX = UIImage(named: "X-small")
    var imageO = UIImage(named: "O-small")
    
    var tapCount = 0
    
    var countX = 0
    var countO = 0
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

    func winX() -> Bool {
        if game.checkCond(allButtons[0], allButtons[1], allButtons[2], imageX!) ||
            game.checkCond(allButtons[3], allButtons[4], allButtons[5], imageX!) ||
            game.checkCond(allButtons[6], allButtons[7], allButtons[8], imageX!) ||
            game.checkCond(allButtons[0], allButtons[3], allButtons[6], imageX!) ||
            game.checkCond(allButtons[1], allButtons[4], allButtons[7], imageX!) ||
            game.checkCond(allButtons[2], allButtons[5], allButtons[8], imageX!) ||
            game.checkCond(allButtons[0], allButtons[4], allButtons[8], imageX!) ||
            game.checkCond(allButtons[6], allButtons[4], allButtons[2], imageX!) {
            return true
        } else {
            return false
        }
    }
    
    func winO() -> Bool {
        if game.checkCond(allButtons[0], allButtons[1], allButtons[2], imageO!) ||
            game.checkCond(allButtons[3], allButtons[4], allButtons[5], imageO!) ||
            game.checkCond(allButtons[6], allButtons[7], allButtons[8], imageO!) ||
            game.checkCond(allButtons[0], allButtons[3], allButtons[6], imageO!) ||
            game.checkCond(allButtons[1], allButtons[4], allButtons[7], imageO!) ||
            game.checkCond(allButtons[2], allButtons[5], allButtons[8], imageO!) ||
            game.checkCond(allButtons[0], allButtons[4], allButtons[8], imageO!) ||
            game.checkCond(allButtons[6], allButtons[4], allButtons[2], imageO!) {
            return true
        } else {
            return false
        }
    }
    
    func Tie() {
        turnLabel.text = "It's a tie!"
        turnLabel.textColor = .black
        game.enableButton(newGameButton)
    }
    
    @IBAction func buttonIsPressed(_ sender: UIButton) {
        tapCount += 1
        sender.isEnabled = false
        
        if tapCount % 2 != 0 {
            sender.setImage(imageX, for: .disabled)
            playSound(soundName: "X-sound")
        } else if tapCount % 2 == 0 {
            sender.setImage(imageO, for: .disabled)
            playSound(soundName: "O-sound")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            
            if tapCount % 2 != 0 {
                turnLabel.text = "O Turn"
                turnLabel.textColor = UIColor(red: 1, green: 0.3, blue: 0, alpha: 1)
            } else if tapCount % 2 == 0 {
                turnLabel.text = "X Turn"
                turnLabel.textColor = .black
            }
            if winX() {
                
                for button in allButtons {
                    button.isEnabled = false
                }
                countX += 1
                winCounts.text = "X  \(countX) - \(countO)  O"
                turnLabel.text = "X WINS!"
                turnLabel.layer.borderWidth = 3
                turnLabel.layer.borderColor = CGColor(gray: 0, alpha: 1)
                turnLabel.textColor = .black
                game.enableButton(newGameButton)
                game.enableButton(resetScore)
                
            } else if winO() {
                
                for button in allButtons {
                    button.isEnabled = false
                }
                countO += 1
                winCounts.text = "X  \(countX) - \(countO)  O"
                turnLabel.text = "O WINS!"
                turnLabel.layer.borderWidth = 3
                turnLabel.layer.borderColor = CGColor(red: 1, green: 0.3, blue: 0, alpha: 1)
                turnLabel.textColor = UIColor(red: 1, green: 0.3, blue: 0, alpha: 1)
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
            winCounts.text = "X  \(countX) - \(countO)  O"
            game.disableButton(resetScore)
            setNewGame()
        }
        
        func setNewGame() {
            for button in allButtons {
                button.setImage(nil, for: .disabled)
                button.isEnabled = true
                button.backgroundColor = .clear
            }
            turnLabel.layer.borderWidth = 0
            game.disableButton(newGameButton)
        }
}
    

