//
//  EditProfileViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 18/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
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
		profileImageView.isUserInteractionEnabled = true
		let tap = UITapGestureRecognizer(target: self, action: #selector(editImage))
		profileImageView.addGestureRecognizer(tap)
		profileImage.cornerRadius()
		picker.delegate = self
    }
	func editImage(){
		picker.allowsEditing = false
		picker.sourceType = .photoLibrary
		picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
		present(picker, animated: true, completion: nil)
	}
	func imagePickerController(_ picker: UIImagePickerController,
	                           didFinishPickingMediaWithInfo info: [String : Any])
	{
		if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
			print(chosenImage)
			profileImage.image = chosenImage
		}
		dismiss(animated:true, completion: nil)
	}
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)

	}
	override func viewWillAppear(_ animated: Bool) {
		name.text = UserDefaults().string(forKey: "name") ?? "Enter Name"
		titleAtCompnay.text = UserDefaults().string(forKey: "title")
		company.text = UserDefaults().string(forKey: "company")
		if(UserDefaults().bool(forKey: "isGoogleLoggedIn") == true){
			profileImage.imageFromServerURL(url: userDefaults.url(forKey: "googleProfileImageUrl")!)
		}
		else if(userDefaults.object(forKey: "facebookProfileImageUrl") != nil){
			profileImage.imageFromServerURL(url: userDefaults.url(forKey: "facebookProfileImageUrl")! )
		}
	}

	@IBAction func donePressed(_ sender: Any) {
		userDefaults.set(self.name.text as String!, forKey: "name")
		userDefaults.set(self.titleAtCompnay.text as String!, forKey: "title")
		userDefaults.set(self.company.text as String!, forKey: "company")
		dismiss(animated: true, completion: nil)
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
