//
//  MainTableViewController.swift
//  Memory
//
//  Created by Charlot on 17/1/14.
//  Copyright © 2017年 Charlot. All rights reserved.
//

import UIKit
import CoreData


class MainTableViewController: UITableViewController {
    var allMemory : NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "全部"
        self.tableView.register(UINib(nibName: "MainMsgTableViewCell", bundle: nil), forCellReuseIdentifier: "MainMsgTableViewCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    @IBAction func CreateItemButton(_ sender: Any) {
         self.performSegue(withIdentifier: "toCreateView", sender: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData()  {
        getMemory()
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getMemory(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MemoryData")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            allMemory.removeAllObjects()
            for p in (searchResults as! [NSManagedObject]){
                allMemory.add(p.value(forKey: "name")!)
            }
            self.tableView.reloadData()
        } catch  {
            print(error)
        }
    }
    func searchMemory(name: NSString) -> NSString{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MemoryData")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "name") as! NSString == name) {
                    return p.value(forKey: "password") as! NSString
                }
            }
        } catch  {
            print(error)
        }
        return "NULL"
    }
//fghjk
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allMemory.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "MainMsgTableViewCell"

        let cell: MainMsgTableViewCell = tableView.dequeueReusableCell(withIdentifier: indentifier) as! MainMsgTableViewCell
        
        cell.nameLabel?.text = allMemory[indexPath.row] as? String

        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let passward = searchMemory(name: allMemory[indexPath.row] as! NSString)
        UIPasteboard.general.string = passward as String
        print(UIPasteboard.general.string ?? "NULLL")
    }



}
