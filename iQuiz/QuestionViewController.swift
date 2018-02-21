//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Yicheng Jiang on 2/17/18.
//  Copyright © 2018 Yicheng Jiang. All rights reserved.
//

import UIKit

//global variables
var questionData : [String] = []
var currentQuestion = 0
var correctPoints = 0

// prepare for answer screen
var selected = ""
var correctA : [String] = []
var appdata = AppData.shared
class QuestionViewController: UIViewController {

    var answers : [[String]] = []
   
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var questionlb: UILabel!
    @IBOutlet weak var ans1: UIButton!
    @IBOutlet weak var ans2: UIButton!
    @IBOutlet weak var ans3: UIButton!
    @IBOutlet weak var ans4: UIButton!
    @IBOutlet weak var submit: UIButton!
    var answerButton: [UIButton] = [UIButton]()
    //let answerButton = [ans1, ans2, ans3, ans4]
    
    @IBAction func backHome(_ sender: Any) {
        let alertController = UIAlertController(title: "Hiii", message: "Are you sure that you want to quit?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let quitAction = UIAlertAction(title: "Quit", style: .destructive, handler: {(alert: UIAlertAction!) in self.goHome()
        })
        alertController.addAction(defaultAction)
        alertController.addAction(quitAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func goHome(){
        performSegue(withIdentifier: "backHome", sender: self)
        currentQuestion = 0 // reload new question
        correctPoints = 0 // reload correct points
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        answerButton.forEach{
            btn in btn.setTitleColor(.black, for: .normal)}
        sender.setTitleColor(UIColor(red: 44/255, green: 132/255, blue: 175/255, alpha: 1), for: .normal)
        // store selected answer to the golabl variable
        selected = (sender.titleLabel?.text)!
    }
    
    
    @IBAction func submitAnswer(_ sender: Any) {
        if selected != ""{
            performSegue(withIdentifier: "checkAnswer", sender: self)
        }else {
            let alertController = UIAlertController(title: "Sorry...", message: "But you must select an answer to continue.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)

            present(alertController, animated: true, completion: nil)
        }
    }
    
    func newQuestion(){
        switch(myIndex) {
        case 0 :
            questionData = appdata.mathQuestions
            answers = appdata.mathAnswers
            correctA = appdata.correctMA
            questionTitle.text = appdata.categories[0]
        case 1 :
            questionData = appdata.shieldQuestions
            answers = appdata.shieldAnswers
            correctA = appdata.correctShieldA
            questionTitle.text = appdata.categories[1]
        default:
            questionData = appdata.scienceQuestions
            answers = appdata.scienceAnswers
            correctA = appdata.correctSA
            questionTitle.text = appdata.categories[2]
        }

        questionlb.text = questionData[currentQuestion] //switch question --> change lable
        
        // set title for each button
        for i in 0...3{
            answerButton[i].setTitle(answers[currentQuestion][i], for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerButton = [self.ans1, self.ans2, self.ans3, self.ans4]
        newQuestion()
        
        // add new gestures
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func swipedLeft(_ gesture: UIGestureRecognizer) {
        performSegue(withIdentifier: "checkAnswer", sender: self)
    }
    
    @objc func swipedRight(_ gesture: UIGestureRecognizer) {
        backHome((Any).self)
    }
    
}
