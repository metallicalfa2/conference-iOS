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
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

let userDefaults = UserDefaults.standard

class LoginViewController: UIViewController ,GIDSignInUIDelegate,GIDSignInDelegate,LoginButtonDelegate{
	// userDefaults for persistant data storage.

	@IBOutlet weak var registrationId: UITextField!
	
	@IBAction func registerButton(_ sender: Any) {
	}
	
	@IBAction func googleSignIn(_ sender: Any) {
		GIDSignIn.sharedInstance().signIn()
	}

	@IBAction func facebookSignIn(_ sender: Any) {
		manageFbLogin()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		GIDSignIn.sharedInstance().uiDelegate = self
		GIDSignIn.sharedInstance().delegate = self
    }
	
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if (error == nil) {
			userDefaults.set(true, forKey: "isGoogleLoggedIn")
			userDefaults.set(user.profile.email as String!, forKey: "email")
			userDefaults.set(user.profile.name as String!, forKey: "name")
			segueToLoginDetails()
		} else {
			print("\(error.localizedDescription)")
		}
	}
	func manageFbLogin(){
		let loginManager = LoginManager()
		loginManager.logIn([.publicProfile, .email ], viewController: self) { (result) in
			switch result{
			case .cancelled:
				print("Cancel button click")
			case .success:
				let params = ["fields" : "id, name, first_name, last_name, picture.type(large), email "]
				let graphRequest = FBSDKGraphRequest.init(graphPath: "/me", parameters: params)
				let Connection = FBSDKGraphRequestConnection()
				Connection.add(graphRequest) { (Connection, result, error) in
					let info = result as! [String : AnyObject]
					print(info["name"] as! String)
					userDefaults.set(info["name"] as! String, forKey: "name")
					userDefaults.set(info["email"] as! String, forKey: "email")
					userDefaults.set(false, forKey: "isGoogleLoggedIn")

					self.segueToLoginDetails()
				}
				Connection.start()
			default:
				print("??")
			}
		}
	}
	func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {}
	func loginButtonDidLogOut(_ loginButton: LoginButton) {}
	func segueToLoginDetails(){
		performSegue(withIdentifier: "loginToLoginDetails", sender: self)
	}
}
