//
//  LoginViewController.swift
//  Memory
//
//  Created by Charlot on 17/1/13.
//  Copyright © 2017年 Charlot. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createLoginButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createLoginButton() {
        let button = UIButton(frame:CGRect(x:10, y:150, width:self.view.frame.width/3, height:30))
        button.setTitle("login", for: UIControlState.normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func login() {
        print("11111")
        self.performSegue(withIdentifier: "toMainSegue", sender: self)
        
    }
    

}
