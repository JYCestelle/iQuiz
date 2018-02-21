//
//  ViewController.swift
//  iQuiz
//
//  Created by Yicheng Jiang on 2/12/18.
//  Copyright © 2018 Yicheng Jiang. All rights reserved.
//

import UIKit

var myIndex = 0
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var appdata = AppData.shared
    var defaultUrl: String = "https://tednewardsandbox.site44.com/questions.json"
    var refreshControl = UIRefreshControl()
    
    var timer: Timer!
    var interval = 30 // in sec

    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func settingBtn(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appdata.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        
        let topic = appdata.categories[indexPath.row]
        let descrption = appdata.descriptions[indexPath.row]
        cell.title.text = topic
        cell.desc.text = descrption
        cell.images.image = UIImage(named: appdata.images[indexPath.row])
        NSLog(appdata.categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "question", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        self.refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
//        self.categoryTableView.addSubview(refreshControl)
//
//        fetchData(defaultUrl)
//        categoryTableView.dataSource = self
//        categoryTableView.delegate = self
//        if timer != nil {
//            timer.invalidate()
//        }
//        startTimer()
    // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getQuizData(_ url: String ) {
        let url = URL(string: url)
        if url != nil {
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    let alertController = UIAlertController(title: "Error", message: "Fetching quiz data error. Using locally stored quiz data.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                } else { // fetch online data if possible
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 { // request error
                        let alertController = UIAlertController(title: "Error", message: "Fail to fetching quiz data. Request error.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Dictionary<String, AnyObject>]
                        UserDefaults.standard.setValue(json, forKey: "jsonData")
                        //UIApplication.shared.quizQuestionRepository.deserializaData()
                    }
                }
                // update UI
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
                }.resume()
        }
    }
    
    func parseQuizData(){
        if let jsonData = UserDefaults.standard.array(forKey: "jsonData") {
            let json = jsonData as! [Dictionary<String, AnyObject>]
            //var idx = 0
            for item in json {
                self.appdata.categories.append(item["titles"]as! String);
                self.appdata.descriptions.append(item["desc"]as! String);
                
                let questionsData = (item["questions"] as! NSArray) as Array
                for questionData in questionsData {
                    var question = questionData as! Dictionary<String, Any>
                    let integer = Int(question["answer"] as! String)!
                    var answerArray = question["answers"]as! [String]
                    let string = answerArray[integer]
                    if item["titles"]as! String == "Science" {
                        self.appdata.mathQuestions.append(question["text"] as! String)
                        self.appdata.mathAnswers.append(question["answers"]as! [String])

                        self.appdata.correctMA.append(string)
                    }else if item["titles"]as! String == "Marvel Super Heroes"{
                        self.appdata.shieldQuestions.append(question["text"] as! String)
                        self.appdata.shieldAnswers.append(question["answers"]as! [String])
                        self.appdata.correctShieldA.append(string)
                    }else{
                        self.appdata.shieldQuestions.append(question["text"] as! String)
                        self.appdata.shieldAnswers.append(question["answers"]as! [String])
                        self.appdata.correctShieldA.append(string)
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

