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
}
