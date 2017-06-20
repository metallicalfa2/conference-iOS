//
//  LoginDetailsViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 17/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class LoginDetailsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
	let picker = UIImagePickerController()

	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var titleInCompany: UITextField!
	@IBOutlet weak var company: UITextField!
	@IBOutlet weak var viewforImage: UIView!
	@IBOutlet weak var uiImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
		uiImage.isUserInteractionEnabled = true
		let tap = UITapGestureRecognizer(target: self, action: #selector(editImage))
		uiImage.addGestureRecognizer(tap)
		uiImage.cornerRadius()
		picker.delegate = self
    }
	
	override func viewWillAppear(_ animated: Bool) {
		func fetchProfileImage(){
			if(UserDefaults().object(forKey: "manualChosenImage") != nil){
				let data = UserDefaults().object(forKey: "manualChosenImage")
				self.uiImage.image = UIImage(data: data as! Data)
			}
			else if(UserDefaults().bool(forKey: "isGoogleLoggedIn") == true){
				self.uiImage.imageFromServerURL(url: userDefaults.url(forKey: "googleProfileImageUrl")!)
			}
			else if(userDefaults.object(forKey: "facebookProfileImageUrl") != nil){
				self.uiImage.imageFromServerURL(url: userDefaults.url(forKey: "facebookProfileImageUrl")! )
			}
		}
		
		name.text = UserDefaults().string(forKey: "name")
		email.text = UserDefaults().string(forKey: "email")
		titleInCompany.text = UserDefaults().string(forKey: "title")
		company.text = UserDefaults().string(forKey: "company")
	}
	
	@IBAction func donePressed(_ sender: Any) {
		userDefaults.set(name.text as String!, forKey: "name")
		userDefaults.set(titleInCompany.text as String!, forKey: "title")
		userDefaults.set(company.text as String!, forKey: "company")
		performSegue(withIdentifier: "loginDetailsToTabBar", sender: self)
	}
	func editImage(){
		picker.allowsEditing = true
		picker.sourceType = .photoLibrary
		picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
		present(picker, animated: true, completion: nil)
	}
	func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any])
	{
		if let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage{
			self.uiImage.image = chosenImage
			let ImageData: NSData = UIImagePNGRepresentation(chosenImage)!	as NSData
			userDefaults.set(ImageData, forKey: "manualChosenImage")
		}
		else if let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage{
			self.uiImage.image = chosenImage
			let ImageData: NSData = UIImagePNGRepresentation(chosenImage)!	as NSData
			userDefaults.set(ImageData, forKey: "manualChosenImage")
		}
		else{
			print("Error")
		}
		dismiss(animated:true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
		
	}

}
