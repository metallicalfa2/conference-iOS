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

// userDefaults for persistant data storage.
let userDefaults = UserDefaults.standard

class LoginViewController: UIViewController ,GIDSignInUIDelegate,GIDSignInDelegate,LoginButtonDelegate{

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
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		if (userDefaults.object(forKey: "clientId") != nil){
			GIDSignIn.sharedInstance().clientID = userDefaults.object(forKey: "clientId") as! String
			GIDSignIn.sharedInstance().signInSilently()
		}
	}

	func segueToLoginDetails(){
		performSegue(withIdentifier: "loginToLoginDetails", sender: self)
	}
}

extension LoginViewController{
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if (error == nil) {
			userDefaults.set(user.profile.imageURL(withDimension: 500), forKey: "googleProfileImageUrl")
			userDefaults.set(false,forKey:"isFacebookLoggedIn")
			userDefaults.set(true, forKey: "isGoogleLoggedIn")
			userDefaults.set(user.profile.email as String!, forKey: "email")
			userDefaults.set(user.profile.name as String!, forKey: "name")
			userDefaults.set(signIn.clientID as String!, forKey: "clientId")
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
					//print(result)
					let info = result as! [String : AnyObject]
					let dataObject = info["picture"] as! [String:AnyObject]
					let imageObject = dataObject["data"] as! [String:AnyObject]
					let imageString = imageObject["url"] as! String
					
					userDefaults.set(false, forKey: "isGoogleLoggedIn")
					userDefaults.set(true,forKey:"isFacebookLoggedIn")
					userDefaults.set(URL(string:imageString), forKey: "facebookProfileImageUrl")
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
	func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
		print("fb login completed")
	}
	func loginButtonDidLogOut(_ loginButton: LoginButton) {}
	
}
