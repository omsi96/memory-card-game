//
//  ViewController.swift
//  MemoryCardApp
//
//  Created by Omar Alibrahim on 6/29/20.
//  Copyright © 2020 KuwaitCodes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
    @IBOutlet weak var b10: UIButton!
    @IBOutlet weak var b11: UIButton!
    @IBOutlet weak var b12: UIButton!
    @IBOutlet weak var b13: UIButton!
    @IBOutlet weak var b14: UIButton!
    @IBOutlet weak var b15: UIButton!
    @IBOutlet weak var b16: UIButton!
    
    
    var buttons: [UIButton] = []
    var cards: [Card] = []
    var comparedRight: Bool = false
    var numberOfTaps = 0
    var firstSelectedCard: Card?
    var correctAnswers = 0
    var firstImageIndex = -1 // Will always store first image index
    
    var timer: Timer?
    var seconds = 0
    let secondsToLoseGame = 100
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [b1,b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16]
        tagButtons()
        
        startTimer()
        prepAndShuffleCards()
    }
    
    
    
    @IBAction func tap(_ sender: UIButton) {
        let index = sender.tag
        if numberOfTaps % 2 == 0 {
            firstImageIndex = index
            firstSelectedCard = cards[index]
            sender.setImage(UIImage(named: firstSelectedCard!.imageName()), for: .normal)
            numberOfTaps += 1
        }
        else{
            let secondSelectedCard = cards[index]
            sender.setImage(UIImage(named: secondSelectedCard.imageName()), for: .normal)
            self.numberOfTaps += 1
            
            let secondButton = self.buttons[self.firstImageIndex]
            
            // Incorrect Answer
            if secondSelectedCard != firstSelectedCard!{
                enabledAllButtons(enable: false)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.flipCardBack(sender)
                    self.flipCardBack(secondButton)
                    self.enabledAllButtons(enable: true)
                }
            }
            // Correct Answer
            else{
                sender.isUserInteractionEnabled = false
                secondButton.isUserInteractionEnabled = true
                correctAnswers += 1
                
                checkWinning()
            }
        }
        
    }
    
    func checkWinning(){
        if correctAnswers >= 8{
            statusLabel.text = "You won!!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.statusLabel.text = ""
                self.restart()
            }
            
        }
        else{
            statusLabel.text = "BRAVOO"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.statusLabel.text = ""
            }
        }
    }
    
    func restart()
    {
        correctAnswers = 0
        prepAndShuffleCards()
        numberOfTaps = 0
        
        buttons.forEach { button in
            button.setImage(#imageLiteral(resourceName: "cardBack"), for: .normal)
            button.isUserInteractionEnabled = true
        }
    }
    
    
    func enabledAllButtons(enable: Bool){
        buttons.forEach { b in
            b.isUserInteractionEnabled = enable
        }
    }
    
    func prepAndShuffleCards(){
        cards = []
        cards += Card.allCards
        cards += Card.allCards
        
        cards.shuffle()
    }
    
    func tagButtons()
    {
        var i = 0
        buttons.forEach { button in
            button.tag = i
            i += 1
        }
    }
    
    func flipCardBack(_ button: UIButton){
        button.setImage(#imageLiteral(resourceName: "cardBack"), for: .normal)
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countUp), userInfo: nil, repeats: true)
    }

    @objc func countUp() {
        seconds += 1
        if seconds == secondsToLoseGame{
            timer?.invalidate()
            
            statusLabel.text = "You lose"
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.statusLabel.text = ""
            }
            restart()
            
        }else{
            statusLabel.text = String(format: "%02d", seconds)
        }
    }
    
}

