//
//  GameViewController.swift
//  SinkOrSwim
//
//  Created by Joseph DiLiello on 9/6/21.
//

import UIKit

class GameViewController: UIViewController {

    // let the user know if too high or too low
    @IBOutlet weak var gameFeedback: UILabel!
    // the value displayed on the screen
    @IBOutlet weak var gameDisplay: UILabel!
    // the value selected by user via the slider
    @IBOutlet weak var gameGuess: UISlider!
    @IBAction func sliderValueChanged(_ sender: Any) {
        gameDisplay.text = String(Int(gameGuess.value))
    }
    // set the users answer (kicks off DidSet for usersGuess)
    @IBAction func checkAnswer(_ sender: Any) {
        self.usersGuess = Int(gameGuess.value)
    }
    // toggle for providing feedback
    @IBOutlet weak var feedbackChoice: UISwitch!
    @IBAction func feedbackOnOff(_ sender: Any) {
        self.displayFeedback = feedbackChoice.isOn
    }
    // change the color of the user's number
    @IBOutlet weak var colorChoice: UISegmentedControl!
    @IBAction func changeColor(_ sender: Any) {
        let colorIdx = self.colorChoice.selectedSegmentIndex
        if let color = self.colorChoice.titleForSegment(at: colorIdx){
            self.usersColor = color
        }
    }
    // change the size of the user's number
    @IBOutlet weak var fontSize: UIStepper!
    @IBAction func changeSize(_ sender: Any) {
        self.userSize = fontSize.value
    }
    // display how much longer until the settings reset
    @IBOutlet weak var timerValue: UIProgressView!
    
    // set up variables
    let countdown = Progress(totalUnitCount:40) // quarter-second intervals for a 10 second reset
    var numberToGuess:Int = 0
    var userSize = 50.0 {
        didSet{
            DispatchQueue.main.async {
                self.gameDisplay.font = UIFont.systemFont(ofSize: CGFloat(self.userSize))
            }
        }
    }
    var usersColor = "Red" {
        didSet{
            DispatchQueue.main.async {
                switch self.usersColor{
                case "Blue":
                    self.gameDisplay.textColor = UIColor.blue
                case "Green":
                    self.gameDisplay.textColor = UIColor.green
                default:
                    self.gameDisplay.textColor = UIColor.red
                }
            }
        }
    }
    // if feedback is turned off, immediately hides
    // if turned back on, requires a new check
    var displayFeedback:Bool = true {
        didSet{
            DispatchQueue.main.async {
                if !self.displayFeedback{
                    self.gameFeedback.text = ""
                } else {
                    self.gameFeedback.text = "Check an answer."
                }
            }
        }
    }
    var usersGuess:Int = 0 {
        didSet{
            DispatchQueue.main.async {
                switch self.usersGuess{
                case self.numberToGuess:
                    // this should also yield an action
                    // that displays a popup/modal view
                    // that gives user option to play again
                    // or return to main screen
                    self.gameFeedback.text = "Correct!"
                case let x where x < self.numberToGuess:
                    if self.displayFeedback{
                        self.gameFeedback.text = "Too low!"
                    } else {
                        self.gameFeedback.text = ""
                    }
                case let x where x > self.numberToGuess:
                    if self.displayFeedback{
                        self.gameFeedback.text = "Too High!"
                    } else {
                        self.gameFeedback.text = ""
                    }
                default:
                    self.gameFeedback.text = ""
                }
            }
        }
    }
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getRandomNumber()
        
        self.gameFeedback.text = ""
        self.gameDisplay.textColor = UIColor.red
        self.gameDisplay.font = UIFont.systemFont(ofSize: CGFloat(self.userSize))
        self.fontSize.value = self.userSize
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target:self, selector: #selector(countdownTimer), userInfo: nil, repeats:true)

        // Do any additional setup after loading the view.
    }
    
    func getRandomNumber(){
        self.numberToGuess = Int.random(in:0...20)
    }
    
    func setDefaults(){
        self.usersColor = "Red"
        self.userSize = 40.0
    }
    
    var timeCount = 0.0
    @objc func countdownTimer(){
        self.timeCount += 0.25
        // update progress?
        self.countdown.completedUnitCount += 1 // 1 unit = 0.25 sec
        self.timerValue.setProgress(Float(self.countdown.fractionCompleted), animated: true)
        if self.timeCount >= 10.0 {
            self.setDefaults()
            self.timeCount = 0.0 // reset counter
            self.countdown.completedUnitCount = 0
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
