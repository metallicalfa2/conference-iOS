//
//  LoginViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 08/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var register: UIImageView!
	
	@IBOutlet weak var registrationId: UITextField!
	@IBOutlet weak var connectWithGoogle: UIImageView!
	@IBOutlet weak var connectWithFb: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		register.isUserInteractionEnabled = true
		register.addGestureRecognizer(tapGestureRecognizer)
    }
	func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
	{
		let vc = TabBarViewController()
		self.present(vc, animated: true, completion: nil)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
}
