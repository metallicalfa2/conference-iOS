//
//  EditProfileViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 18/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

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
    }
	override func viewWillAppear(_ animated: Bool) {
		name.text = UserDefaults().string(forKey: "name") ?? "Enter Name"
		titleAtCompnay.text = UserDefaults().string(forKey: "title")
		company.text = UserDefaults().string(forKey: "company")
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
