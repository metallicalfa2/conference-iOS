//
//  LoginDetailsViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 17/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class LoginDetailsViewController: UIViewController {
	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var titleInCompany: UITextField!
	@IBOutlet weak var company: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	override func viewWillAppear(_ animated: Bool) {
		name.text = UserDefaults().string(forKey: "name") ?? "name"
		email.text = UserDefaults().string(forKey: "email") ?? "email"
		
	}
	@IBAction func donePressed(_ sender: Any) {
		print(titleInCompany.text as String!)
		userDefaults.set(titleInCompany.text as String!, forKey: "title")
		userDefaults.set(titleInCompany.text as String!, forKey: "company")
		performSegue(withIdentifier: "loginDetailsToTabBar", sender: self)
	}

}
