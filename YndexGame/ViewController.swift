//
//  ViewController.swift
//  YndexGame
//
//  Created by Сергей Прокопьев on 14/07/2019.
//  Copyright © 2019 PelmondoProduct. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var gameControl: GameControlViewClass!
    
    private var gameTimer: Timer?
    private var timer: Timer?
    private var displayDuration: TimeInterval = 1.5
    private var score = 0
    
    
    private func startGame() {
        score = 0
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimerTick), userInfo: nil, repeats: true)
        repositionImageWithTimer()
        gameControl.gameTimeLeft = gameControl.gameDuration
        gameControl.isGameActive = true
        updateUI()
    }

    @objc private func gameTimerTick() {
        gameControl.gameTimeLeft -= 1
        if gameControl.gameTimeLeft <= 0 {
            stopGame()
        } else {
        updateUI()
        }
    }
    
    
    private func stopGame() {
        gameControl.isGameActive = false
        updateUI()
        gameTimer?.invalidate()
        timer?.invalidate()
        scoreLine.text = "Последний счёт: \(score)"
    }
    
    
   func actionButtonTap() {
        switch gameControl.isGameActive {
        case true: stopGame()
        case false: startGame()
        }
    }
    
   func objectTapped() {
        guard gameControl.isGameActive else {return}
        repositionImageWithTimer()
        score += 1

    }
    
    
    
    @IBOutlet weak var gameFieldsView: GameFieldView!
    @IBOutlet weak var scoreLine: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameFieldsView.layer.borderWidth = 1
        gameFieldsView.layer.borderColor = UIColor.gray.cgColor
        gameFieldsView.layer.cornerRadius = 5
        updateUI()
        gameFieldsView.shapeHitHandler = { [weak self] in
            self?.objectTapped()
        }
        gameControl.startStopHandler = { [weak self] in
            self?.actionButtonTap()
        }
        gameControl.gameDuration = 20
    }

   
    

    func updateUI() {
        gameFieldsView.isShapeHidden = !gameControl.isGameActive
        
    }
    
    @objc private func moveImage() {
      gameFieldsView.randomizeShapes()
    }
    
    
    private func repositionImageWithTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: displayDuration, target: self, selector: #selector(moveImage), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    
}



