//
//  AppData.swift
//  iQuiz
//
//  Created by Yicheng Jiang on 2/12/18.
//  Copyright © 2018 Yicheng Jiang. All rights reserved.
//

import UIKit

class AppData: NSObject {
    static let shared = AppData()
    
    open var categories : [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    open var descriptions : [String] = ["Know your barrier!", "Our loved Marvel super heros!", "how much do you know about science?"]
    open var images : [String] = ["math", "superhero", "science"]
    
    // questions for three categories
//    open var mathQuestions = [
//        "1. What is the remainder when 3^283 is divded by 5 ?",
//        "2. What is 1 + 1?"
//    ]
    open var mathQuestions: [String] = []
    
//    open var mathAnswers = [
//        ["0", "1", "2", "3"],
//        ["2", "4", "6", "8"]
//    ]
    open var mathAnswers: [[String]] = []
    
//    open var correctMA = ["2", "2"]
    open var correctMA: [String] = []
    
//    open var shieldQuestions = [
//        "1. When was Iron Man released?",
//        "2. How many primary color(s) does the outfit of Captain America have?"
//    ]
    open var shieldQuestions: [String] = []
    
//    open var shieldAnswers = [
//        ["2005", "2007", "2008", "2010"],
//        ["3", "5", "4", "6"]
//    ]
    open var shieldAnswers: [[String]] = []
    
//    open var correctShieldA = ["2008", "4"]
    open var correctShieldA: [String] = []
    
//    open var scienceQuestions = [
//        "1. What is chemical formula for water?"
//    ]
    open var scienceQuestions: [String] = []
    
//    open var scienceAnswers = [
//        ["HO2", "H2O", "HO", "HHHHHHHHH"]
//    ]
    open var scienceAnswers: [[String]] = []
    
//    open var correctSA = ["H2O"]
    open var correctSA: [String] = []
    
    func getQuizzes() -> [String] {
        return categories
    }
}
