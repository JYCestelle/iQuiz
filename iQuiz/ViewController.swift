//
//  ViewController.swift
//  iQuiz
//
//  Created by Yicheng Jiang on 2/12/18.
//  Copyright © 2018 Yicheng Jiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var appdata = AppData.shared
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func settingBtn(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //myIndex = indexPath.row
//        performSegue(withIdentifier: "segue", sender: self)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.dataSource = self
//        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

