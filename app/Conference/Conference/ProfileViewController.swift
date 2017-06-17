//
//  ProfileViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 17/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import GoogleSignIn

class ProfileViewController: UIViewController {
	
	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var titleatCompany: UITextField!
	@IBOutlet weak var company: UITextField!
	@IBOutlet weak var facebook: UIImageView!
	@IBOutlet weak var google: UIImageView!
	
	@IBAction func signOut(_ sender: Any) {
		GIDSignIn.sharedInstance().signOut()
		
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "profileView")
		self.present(vc!, animated: true, completion: nil)
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	override func viewWillAppear(_ animated: Bool) {
		email.text = UserDefaults().string(forKey: "email") ?? "email Address"
		name.text = UserDefaults().string(forKey: "name") ?? "Name"
		titleatCompany.text = UserDefaults().string(forKey: "title") ?? "title"
		company.text = UserDefaults().string(forKey: "company") ?? "Company"

		UserDefaults().bool(forKey: "isGoogleLoggedIn") ? GoogleLoggedIn() : facebookLoggedIn()
		
	}
	func GoogleLoggedIn(){
		self.google.image = #imageLiteral(resourceName: "google_plus")
	}
	func facebookLoggedIn() {
		self.facebook.image = #imageLiteral(resourceName: "facebook")
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
