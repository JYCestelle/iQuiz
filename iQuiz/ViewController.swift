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
    var dataUrl: String = "https://tednewardsandbox.site44.com/questions.json"
    var refreshControl = UIRefreshControl()
    
    var timer: Timer!
    var interval = 20 // in sec

    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func settingBtn(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Settings", message: "Enter an url to fetch other quizzes", preferredStyle: .alert)

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Url for fetching data"
            textField.text = UserDefaults.standard.string(forKey: "dataUrl")
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Check it", style: .default, handler: {
            alert -> Void in
            let input = alertController.textFields![0].text!
            UserDefaults.standard.set(input, forKey: "data_url")
            self.getQuizData(input)
        }))
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
        print(indexPath.row)
        let topic = appdata.categories[indexPath.row]
        let descrption = appdata.descriptions[indexPath.row]
        print(indexPath.row)
        let image = appdata.images[indexPath.row]
        cell.title.text = topic
        cell.desc.text = descrption
        cell.images.image = UIImage(named: image)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "question", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(ViewController.refreshHandler(_:)), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)
        
        getQuizData(dataUrl)
        tableView.dataSource = self
        tableView.delegate = self
//        if timer != nil {
//            timer.invalidate()
//        }
    // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func refreshHandler(_ refreshControl: UIRefreshControl) {
        appdata.clear()
        getQuizData(dataUrl)
    }
    
    func getQuizData(_ url: String ) {
        let url = URL(string: url)
        if url != nil {
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    let alertController = UIAlertController(title: "Error", message: "There is an error for fetching data. Using locally stored quiz data.", preferredStyle: .alert)
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
                        self.parseQuizData()
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
                self.appdata.categories.append(item["title"]as! String);
                self.appdata.descriptions.append(item["desc"]as! String);
                let questionsData = (item["questions"] as! NSArray) as Array
                for questionData in questionsData {
                    var question = questionData as! Dictionary<String, Any>
                    let integer = Int(question["answer"] as! String)! - 1
                    var answerArray = question["answers"]as! [String]
                    let string = answerArray[integer]
                    if item["title"]as! String == "Science!" {
                        self.appdata.mathQuestions.append(question["text"] as! String)
                        self.appdata.mathAnswers.append(question["answers"]as! [String])

                        self.appdata.correctMA.append(string)
                    }else if item["title"]as! String == "Marvel Super Heroes"{
                        self.appdata.shieldQuestions.append(question["text"] as! String)
                        self.appdata.shieldAnswers.append(question["answers"]as! [String])
                        self.appdata.correctShieldA.append(string)
                    }else{
                        self.appdata.scienceQuestions.append(question["text"] as! String)
                        self.appdata.scienceAnswers.append(question["answers"]as! [String])
                        self.appdata.correctSA.append(string)
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

