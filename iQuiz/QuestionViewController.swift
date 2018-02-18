//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Yicheng Jiang on 2/17/18.
//  Copyright © 2018 Yicheng Jiang. All rights reserved.
//

import UIKit

//global variables
var points = 0
var questionData : [String] = []
var currentQuestion = 0

class QuestionViewController: UIViewController {
    var appdata = AppData.shared
//    var correctAns = 0
//    var rightAnswerPlacement:UInt32 = 0
    
    var rightAnswerPlacement:UInt32 = 0
    var beforeTag = -1
    var currentTag = -1
    var currentButton:UIButton = UIButton()
    var answers : [[String]] = []

    @IBOutlet weak var questionlb: UILabel!
    @IBOutlet weak var ans1: UIButton!
    @IBOutlet weak var ans2: UIButton!
    @IBOutlet weak var ans3: UIButton!
    @IBOutlet weak var ans4: UIButton!
    @IBOutlet weak var submit: UIButton!
    var answerButton: [UIButton] = [UIButton]()
    
    @IBAction func backHome(_ sender: Any) {
        let alertController = UIAlertController(title: "Hiii", message: "Are you sure that you want to quit?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let quitAction = UIAlertAction(title: "Quit", style: .destructive, handler: {(alert: UIAlertAction!) in self.goHome()
        })
        alertController.addAction(defaultAction)
        alertController.addAction(quitAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func answerPressed(_ sender: Any) {
        if beforeTag == -1 {
            beforeTag = 0
            currentButton = sender as! UIButton
            currentButton.isSelected = true
        } else {
            currentButton.isSelected = false
            currentButton = sender as! UIButton
            currentButton.isSelected = true
        }
        currentTag = (sender as AnyObject).tag
        print(currentTag)
        submit.isEnabled = true
    }
    
    
    @IBAction func submitAnswer(_ sender: Any) {
        performSegue(withIdentifier: "checkAnswer", sender: self)
    }
    
    func goHome(){
        performSegue(withIdentifier: "backHome", sender: self)
    }
    
    func newQuestion(){
        switch(myIndex) {
        case 0 :
            questionData = appdata.mathQuestions
            answers = appdata.mathAnswers
        case 1 :
            questionData = appdata.shieldQuestions
            answers = appdata.shieldAnswers
        default:
            questionData = appdata.scienceQuestions
            answers = appdata.scienceAnswers
        }
    
        questionlb.text = questionData[currentQuestion] //switch question --> change lable
        
        // set title for each button
        for i in 0...3{
            answerButton[i].setTitle(answers[currentQuestion][i], for: .normal)
        }
        currentQuestion += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerButton = [self.ans1, self.ans2, self.ans3, self.ans4]
        newQuestion()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
