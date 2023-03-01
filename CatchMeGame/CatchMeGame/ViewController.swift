//
//  ViewController.swift
//  CatchMeGame
//
//  Created by Ecem Öztürk on 1.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var viewArray = [UIImageView]()
    var hideTimer = Timer()
    var highscore = 0

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var view1: UIImageView!
    @IBOutlet weak var view2: UIImageView!
    @IBOutlet weak var view3: UIImageView!
    @IBOutlet weak var view4: UIImageView!
    @IBOutlet weak var view5: UIImageView!
    @IBOutlet weak var view6: UIImageView!
    @IBOutlet weak var view7: UIImageView!
    @IBOutlet weak var view8: UIImageView!
    @IBOutlet weak var view9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        //High score check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highscore = 0
            highscoreLabel.text = "High Score : \(highscore)"
        }
        if let newScore = storedHighScore as? Int {
            highscore = newScore
            highscoreLabel.text = "High Score : \(highscore)"
        }
        
        // Images
        view1.isUserInteractionEnabled = true
        view2.isUserInteractionEnabled = true
        view3.isUserInteractionEnabled = true
        view4.isUserInteractionEnabled = true
        view5.isUserInteractionEnabled = true
        view6.isUserInteractionEnabled = true
        view7.isUserInteractionEnabled = true
        view8.isUserInteractionEnabled = true
        view9.isUserInteractionEnabled = true

        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        
        view1.addGestureRecognizer(recognizer1)
        view2.addGestureRecognizer(recognizer2)
        view3.addGestureRecognizer(recognizer3)
        view4.addGestureRecognizer(recognizer4)
        view5.addGestureRecognizer(recognizer5)
        view6.addGestureRecognizer(recognizer6)
        view7.addGestureRecognizer(recognizer7)
        view8.addGestureRecognizer(recognizer8)
        view9.addGestureRecognizer(recognizer9)
        
        viewArray = [view1,view2,view3,view4,view5,view6,view7,view8,view9]
        
        
        // MARK: Timers
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideView), userInfo: nil, repeats: true)
        
        hideView()

    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            // Süre bitince bütün view'leri görünmez hale getir
            for view in viewArray {
                view.isHidden = true
            }
            
            // High Score
            if self.score > self.highscore {
                self.highscore = self.score
                highscoreLabel.text = "High Score : \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
            }
            
            
            //Alert
            let alert = UIAlertController(title: "Time is up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideView), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
        }
    }
    
    @objc func hideView() {
        for view in viewArray {
            view.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(viewArray.count - 1))) // 0-9 arası random sayı
        viewArray[random].isHidden = false
        
    }


}

