//
//  ProfileViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 17/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import GoogleSignIn
import Google

class ProfileViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {
	
	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var titleatCompany: UITextField!
	@IBOutlet weak var company: UITextField!
	@IBOutlet weak var facebook: UIImageView!
	@IBOutlet weak var google: UIImageView!
	
	@IBAction func signOut(_ sender: Any) {
		manageGoogleLogout()
		manageFbLogout()
		segueToLoginView()
	}

	
	override func viewDidLoad() {
        super.viewDidLoad()
		GIDSignIn.sharedInstance().uiDelegate = self
		GIDSignIn.sharedInstance().delegate = self
		profileImage.cornerRadius()
		self.addRecognizer()
		
    }
	override func viewWillAppear(_ animated: Bool) {
		email.text = UserDefaults().string(forKey: "email") ?? "email Address"
		name.text = UserDefaults().string(forKey: "name") ?? "Name"
		titleatCompany.text = UserDefaults().string(forKey: "title") ?? "Title"
		company.text = UserDefaults().string(forKey: "company") ?? "Company"
		
		if(UserDefaults().bool(forKey: "isGoogleLoggedIn") == true){
			profileImage.imageFromServerURL(url: userDefaults.url(forKey: "googleProfileImageUrl")!)
			self.GoogleLoggedIn()
		}
		else if(userDefaults.object(forKey: "facebookProfileImageUrl") != nil){
			profileImage.imageFromServerURL(url: userDefaults.url(forKey: "facebookProfileImageUrl")! )
			self.facebookLoggedIn()
		}
		
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

extension ProfileViewController{
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if (error == nil) {
		
			userDefaults.set(user.profile.imageURL(withDimension: 500), forKey: "googleProfileImageUrl")
			userDefaults.set(user.profile.email as String!, forKey: "email")
			userDefaults.set(user.profile.name as String!, forKey: "name")
		} else {
			print("\(error.localizedDescription)")
		}
	}
	func GoogleLoggedIn(){
		userDefaults.set(true,forKey: "isGoogleLoggedIn")
		self.google.image = #imageLiteral(resourceName: "google_plus")
	}
	func facebookLoggedIn() {
		userDefaults.set(true,forKey: "isFacebookLoggedIn")
		self.facebook.image = #imageLiteral(resourceName: "facebook")
	}
	func googleLoggedOut(){
		userDefaults.set(false,forKey: "isGoogleLoggedIn")
		self.google.image = #imageLiteral(resourceName: "google_plus_inactive")
	}
	func facebookLoggedOut(){
		userDefaults.set(false,forKey: "isFacebookLoggedIn")
		self.facebook.image = #imageLiteral(resourceName: "facebook_inactive")
	}
	
	func fbClicked(){
		print("fb image clicked")
		if(UserDefaults().bool(forKey: "isFacebookLoggedIn") == false){
			manageFbLogin()
			facebookLoggedIn()
		}
		else{
			self.manageFbLogout()
			facebookLoggedOut()
		}
		if(checkIfBothLoggedOut()){
			segueToLoginView()
		}
	}
	
	func googleClicked(){
		if(UserDefaults().bool(forKey: "isGoogleLoggedIn") == false){
			GIDSignIn.sharedInstance().signIn()
			GoogleLoggedIn()
		}
		else{
			GIDSignIn.sharedInstance().signOut()
			googleLoggedOut()
		}
		if(checkIfBothLoggedOut()){
			segueToLoginView()
		}
	}
	
	func addRecognizer(){
		let fbTapped = UITapGestureRecognizer(target: self, action: #selector(fbClicked))
		let googleTapped = UITapGestureRecognizer(target: self, action: #selector(googleClicked))
		facebook.isUserInteractionEnabled = true
		google.isUserInteractionEnabled = true
		facebook.addGestureRecognizer(fbTapped)
		google.addGestureRecognizer(googleTapped)
	}
	func segueToLoginView(){
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginView")
		self.present(vc!, animated: true, completion: nil)
	}
}
