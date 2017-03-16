//
//  CreateViewController.swift
//  Memory
//
//  Created by Charlot on 17/1/14.
//  Copyright © 2017年 Charlot. All rights reserved.
//

import UIKit
import CoreData


class CreateViewController: XLFormViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeForm()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initializeForm()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed(_:)))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeForm()  {
        let form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor(title: "Add Event")
        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: "name", rowType: XLFormRowDescriptorTypeText)
        row.cellConfigAtConfigure["textField.placeholder"] = "Title"
        row.isRequired = true
        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: "account", rowType: XLFormRowDescriptorTypeText)
        row.cellConfigAtConfigure["textField.placeholder"] = "帐号"
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "password", rowType: XLFormRowDescriptorTypeText)
        row.cellConfigAtConfigure["textField.placeholder"] = "密码"
        section.addFormRow(row)
        
        self.form = form
        
        
    }
    
    override func formRowDescriptorValueHasChanged(_ formRow: XLFormRowDescriptor!, oldValue: Any!, newValue: Any!) {
//        print(formRow.value ?? "haha")
    }

    func cancelPressed(_ button: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
    
    
    func savePressed(_ button: UIBarButtonItem){
        let validationErrors : Array<NSError> = formValidationErrors() as! Array<NSError>
        if (validationErrors.count > 0){
            showFormValidationError(validationErrors.first)
            getMemory()
            return
        }else{
            print(formValues()["name"] ?? "no")
            let nameInput = formValues()!["name"] as! String
            let accountInput = formValues()!["account"] as! String
            let passwordInput = formValues()!["password"] as! String

            storeMemory(name:nameInput, account:accountInput, password:passwordInput)
        }
        tableView.endEditing(true)
    }

    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func storeMemory(name:String, account:String, password:String){
        let context = getContext()
        // 定义一个entity，这个entity一定要在xcdatamodeld中做好定义
        let entity = NSEntityDescription.entity(forEntityName: "MemoryData", in: context)
        
        let memory = NSManagedObject(entity: entity!, insertInto: context)
        
        memory.setValue(name, forKey: "name")
        memory.setValue(account, forKey: "account")
        memory.setValue(password, forKey: "password")
        
        do {
            try context.save()
            print("saved")
            dismiss(animated: true, completion: nil)
            
        }catch{
            print(error)
        }
        
    }
    
    func getMemory(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MemoryData")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            print("numbers of \(searchResults.count)")
            
            for p in (searchResults as! [NSManagedObject]){
                print("name:  \(p.value(forKey: "name")!) count:  \(p.value(forKey: "account")!) pas: \(p.value(forKey: "password")!)")
            }
        } catch  {
            print(error)
        }
    }
}
