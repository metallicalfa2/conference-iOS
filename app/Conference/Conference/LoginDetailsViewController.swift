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
	@IBOutlet weak var viewforImage: UIView!
	@IBOutlet weak var uiImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		viewforImage.cornerRadius()
		if(userDefaults.object(forKey: "googleProfileImageUrl") != nil){
			uiImage.imageFromServerURL(url: userDefaults.url(forKey: "googleProfileImageUrl")!)
		}
		else if(userDefaults.object(forKey: "facebookProfileImageUrl") != nil){
			uiImage.imageFromServerURL(url: userDefaults.url(forKey: "facebookProfileImageUrl")! )
		}
		
		name.text = UserDefaults().string(forKey: "name") ?? "name"
		email.text = UserDefaults().string(forKey: "email") ?? "email"
		titleInCompany.text = UserDefaults().string(forKey: "title") ?? "Enter Title"
		company.text = UserDefaults().string(forKey: "company") ?? "Enter Company"
	}
	
	@IBAction func donePressed(_ sender: Any) {
		userDefaults.set(name.text as String!, forKey: "name")
		userDefaults.set(titleInCompany.text as String!, forKey: "title")
		userDefaults.set(company.text as String!, forKey: "company")
		performSegue(withIdentifier: "loginDetailsToTabBar", sender: self)
	}

}
