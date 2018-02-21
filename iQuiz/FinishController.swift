//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Yicheng Jiang on 2/18/18.
//  Copyright © 2018 Yicheng Jiang. All rights reserved.
//

import UIKit

class FinishController: UIViewController {
    var appdata = AppData.shared
    @IBOutlet weak var finalWord: UILabel!
    @IBOutlet weak var finalScore: UILabel!
    @IBOutlet weak var finalImage: UIImageView!
    
    func finished(){
        if correctPoints / questionData.count == 1 {
            finalWord.text = "Perfect!"
            finalScore.text = "You Score: \(correctPoints)/\(questionData.count)"
            finalImage.image = UIImage(named: "nice")
        } else if correctPoints != 0 {
            finalWord.text = "Ohh, not bad."
            finalScore.text = "You Score: \(correctPoints)/\(questionData.count)"
            finalImage.image = UIImage(named:"notbad")
        } else {
            finalWord.text = "Emmmm, you should try harder next time."
            finalScore.text = "You Score \(correctPoints)/\(questionData.count)"
            finalImage.image = UIImage(named:"emmm")
        }
        correctPoints = 0
    }
    
    
    @IBAction func backHome(_ sender: Any) {
        performSegue(withIdentifier: "backHome", sender: self)
        currentQuestion = 0 // reload new question
        correctPoints = 0 // reload correct points
        appdata.clear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.finished()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
