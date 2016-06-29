//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by satoutakeshi on 2016/06/27.
//  Copyright © 2016年 satoutakeshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let pageList = [
    "ButtonTap",
    "Validation",
    "KonamiCommand"
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pageList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = self.pageList[indexPath.row]
        
        return cell
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let identifier = self.pageList[indexPath.row]
        let viewController = UIStoryboard.init(name: "Sample", bundle: nil).instantiateViewControllerWithIdentifier(identifier)
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    


}

