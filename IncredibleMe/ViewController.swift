//
//  ViewController.swift
//  IncredibleMe
//
//  Created by Emon on 22/2/20.
//  Copyright © 2020 Emon. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet weak var plateOne: UIButton!
    @IBOutlet weak var plateTwo: UIButton!
    @IBOutlet weak var plateThree: UIButton!
    @IBOutlet weak var plateFour: UIButton!
    @IBOutlet weak var plateFive: UIButton!
    @IBOutlet weak var plateSix: UIButton!
    @IBOutlet weak var plateSeven: UIButton!
    @IBOutlet weak var plateEight: UIButton!
    @IBOutlet weak var plateNine: UIButton!
    
    @IBOutlet weak var resultOne: UIButton!
    @IBOutlet weak var resultTwo: UIButton!
    @IBOutlet weak var resultThree: UIButton!
    @IBOutlet weak var resultFour: UIButton!
    @IBOutlet weak var resultFive: UIButton!
    
    @IBOutlet weak var resultButtonContainer: UIView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var player: AVAudioPlayer?

    
    let operatorArray = ["+","x"]
    var plateArray = [UIButton]()
    
    @IBOutlet weak var scoreLabel: UILabel!
    var currentScore = 0
    
    var totalResult : String = "0"
    var timer: Timer?
    var totalTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        plateArray = [plateOne,plateTwo,plateThree,plateFour,plateFive,plateSix,plateSeven,plateEight]
        resultButtonContainer.layer.cornerRadius = 5.0
        resultButtonContainer.layer.borderColor = UIColor.white.cgColor
        resultButtonContainer.layer.borderWidth = 1.0
        startOtpTimer()

        gameOn()
    }
    
    func gameOn() {
        resetView()
        
        let digit1 = Int.random(in: 1 ..< 12)
        let digit2 = Int.random(in: 1 ..< 12)

        
        let plate = Int.random(in: 0 ..< 2)
            
        let plateNumber = operatorArray[plate]
        print(digit1,digit2,plateNumber)
        
        plateArray = plateArray.shuffled()
        print(plateArray[0],plateArray[1],plateArray[2])
        
        let btn1 = plateArray[0]
        btn1.setTitle("\(digit1)", for: .normal)
        btn1.isHidden = false
        
//        let btn2 = plateArray[1]
        plateNine.setTitle("\(plateNumber)", for: .normal)
        plateNine.isHidden = false

        
        let btn3 = plateArray[2]
        btn3.setTitle("\(digit2)", for: .normal)
        btn3.isHidden = false
        
        
        //MARK: - Result Calculattion
        var resultArr = [Int]()
        
        if plateNumber == operatorArray[0] {
            let sum = digit1 + digit2
            totalResult = "\(sum)"
            resultArr = [sum,Int.random(in: 0 ..< 12),Int.random(in: 0 ..< 55),Int.random(in: 0 ..< 55),Int.random(in: 0 ..< 55)]
        }
        if plateNumber == operatorArray[1] {
            let multi = digit1 * digit2
            totalResult = "\(multi)"
            resultArr = [multi,Int.random(in: 0 ..< 12),Int.random(in: 0 ..< 80),Int.random(in: 0 ..< 55),Int.random(in: 0 ..< 55)]
        }

        resultArr = resultArr.shuffled()
        resultOne.setTitle("\(resultArr[0])", for: .normal)
        resultTwo.setTitle("\(resultArr[1])", for: .normal)
        resultThree.setTitle("\(resultArr[2])", for: .normal)
        resultFour.setTitle("\(resultArr[3])", for: .normal)
        resultFive.setTitle("\(resultArr[4])", for: .normal)


    }
    
    private func startOtpTimer() {
            self.totalTime = 60
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }

    @objc func updateTimer() {
            print(self.totalTime)
            self.timerLabel.text = self.timeFormatted(self.totalTime) // will show timer
            if totalTime != 0 {
                totalTime -= 1  // decrease counter timer
            } else {
                if let timer = self.timer {
                    timer.invalidate()
                    self.timer = nil
                }
            }
        }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func resetView() {
        plateOne.isHidden = true
        plateTwo.isHidden = true
        plateThree.isHidden = true
        plateFour.isHidden = true
        plateFive.isHidden = true
        plateSix.isHidden = true
        plateSeven.isHidden = true
        plateEight.isHidden = true
        plateNine.isHidden = true
    }

    @IBAction func resultBtnActions(_ sender: UIButton) {
        if self.timer != nil {
            if sender.tag == 0 {
                if totalResult == sender.titleLabel?.text {
                    print("Scored")
                    currentScore = currentScore + 10
                }
                else {
                    print("Wrong")
                    currentScore = currentScore - 5
                }
            }
            if sender.tag == 1 {
                if totalResult == sender.titleLabel?.text {
                    print("Scored")
                    currentScore = currentScore + 10
                }
                else {
                    print("Wrong")
                    currentScore = currentScore - 5
                }
            }
            if sender.tag == 2 {
                if totalResult == sender.titleLabel?.text {
                    print("Scored")
                    currentScore = currentScore + 10
                }
                else {
                    print("Wrong")
                    currentScore = currentScore - 5
                }
            }
            scoreLabel.text = "\(currentScore)"
            DispatchQueue.main.async {
                self.playSound()
                self.gameOn()
            }
        }
        else {
            
        }
    }
    
    func levelEndPopUp() {
        
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "result_music", withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    

}

