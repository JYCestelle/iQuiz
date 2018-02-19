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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        showAnswer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
