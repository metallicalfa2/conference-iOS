//
//  LoginViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 08/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import GGLSignIn
import GoogleSignIn
import Google

class LoginViewController: UIViewController ,GIDSignInUIDelegate,GIDSignInDelegate{
	let userDefaults = UserDefaults.standard

	@IBOutlet weak var registrationId: UITextField!
	
	@IBAction func registerButton(_ sender: Any) {
	}
	
	@IBAction func googleSignIn(_ sender: Any) {
		GIDSignIn.sharedInstance().signIn()
	}

	@IBAction func facebookSignIn(_ sender: Any) {
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		GIDSignIn.sharedInstance().uiDelegate = self
		GIDSignIn.sharedInstance().delegate = self
    }
	
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if (error == nil) {
			let userId = user.userID                  // For client-side use only!
			let idToken = user.authentication.idToken // Safe to send to the server
			let fullName = user.profile.name
			let givenName = user.profile.givenName
			let familyName = user.profile.familyName
			let email = user.profile.email
			print(email as String!)
			let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabView")
			self.present(vc!, animated: true, completion: nil)
		} else {
			print("\(error.localizedDescription)")
		}
	}

}
