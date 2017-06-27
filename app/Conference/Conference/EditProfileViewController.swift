//
//  EditProfileViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 18/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
	let picker = UIImagePickerController()

	@IBOutlet weak var profileImageView: UIView!
	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var company: UITextField!
	@IBOutlet weak var titleAtCompnay: UITextField!
	@IBOutlet weak var name: UITextField!
	@IBAction func cancelPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	override func viewDidLoad() {
        super.viewDidLoad()
		self.hideKeyboard()
		profileImage.cornerRadius()
		picker.delegate = self
		
		profileImageView.isUserInteractionEnabled = true
		let tap = UITapGestureRecognizer(target: self, action: #selector(editImage))
		profileImageView.addGestureRecognizer(tap)

		name.delegate = self
		titleAtCompnay.delegate = self
		company.delegate = self
    }
	
	override func viewWillAppear(_ animated: Bool) {
		name.text = UserDefaults().string(forKey: "name") ?? "Enter Name"
		titleAtCompnay.text = UserDefaults().string(forKey: "title")
		company.text = UserDefaults().string(forKey: "company")
		fetchProfileImage()

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
			self.profileImage.image = chosenImage
			let ImageData: NSData = UIImagePNGRepresentation(chosenImage)!	as NSData
			userDefaults.set(ImageData, forKey: "manualChosenImage")
		}
		else if let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage{
			self.profileImage.image = chosenImage
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
	
	@IBAction func donePressed(_ sender: Any) {
		userDefaults.set(self.name.text as String!, forKey: "name")
		userDefaults.set(self.titleAtCompnay.text as String!, forKey: "title")
		userDefaults.set(self.company.text as String!, forKey: "company")
		dismiss(animated: true, completion: nil)
	}
	func fetchProfileImage(){
		if(UserDefaults().object(forKey: "manualChosenImage") != nil){
			let data = UserDefaults().object(forKey: "manualChosenImage")
			self.profileImage.image = UIImage(data: data as! Data)
		}
		else if(UserDefaults().bool(forKey: "isGoogleLoggedIn") == true){
			self.profileImage.imageFromServerURL(url: userDefaults.url(forKey: "googleProfileImageUrl")!)
		}
		else if(userDefaults.object(forKey: "facebookProfileImageUrl") != nil){
			self.profileImage.imageFromServerURL(url: userDefaults.url(forKey: "facebookProfileImageUrl")! )
		}
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if ( textField == self.name)
		{
			self.titleAtCompnay.becomeFirstResponder()
			self.name.resignFirstResponder()
		}
		else if(textField == self.titleAtCompnay){
			self.company.becomeFirstResponder()
			self.titleAtCompnay.resignFirstResponder()
		}
		else{
			textField.resignFirstResponder()
			donePressed(self)
		}
		return true
	}
	
}
