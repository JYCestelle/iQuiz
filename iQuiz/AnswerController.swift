//
//  AnswerController.swift
//  iQuiz
//
//  Created by Yicheng Jiang on 2/17/18.
//  Copyright © 2018 Yicheng Jiang. All rights reserved.
//

import UIKit

class AnswerController: UIViewController {
    @IBOutlet weak var questionContent: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var congr: UILabel!
    
    @IBAction func nextPressed(_ sender: Any) {
        if (currentQuestion != questionData.count) {
            //newQuestion()
            performSegue(withIdentifier: "nextQuestion", sender: self)
        } else {
            currentQuestion = 0
            performSegue(withIdentifier: "finishQuiz", sender: self)
        }
    }
    
    func showAnswer(){
        questionContent.text = questionData[currentQuestion]
        if selected == correctA[currentQuestion] {
            congr.text = "You're Correct!                      ^ _ ^ Keep Going!"
            correctPoints += 1
        }else {
            congr.text = "Got it wrong.. :("
        }
        correctAnswer.text = correctA[currentQuestion]
        currentQuestion += 1
    }
    
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
        appdata.clear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        // Do any additional setup after loading the view.
        showAnswer()
    }
    
    @objc func swipedLeft(_ gesture: UIGestureRecognizer) {
        if(currentQuestion != questionData.count){
            performSegue(withIdentifier: "nextQuestion", sender: self)
        }else {
            performSegue(withIdentifier: "finishQuiz", sender: self)
        }
    }
    
    @objc func swipedRight(_ gesture: UIGestureRecognizer) {
        backHome((Any).self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
