//
//  registerViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 14/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import Eureka
import SwiftyJSON

class registerViewController: FormViewController{
	let net = networkResource()
	var string = ""
	var index = 0
	let section = Section("Enter Details")

	override func viewDidLoad() {
		super.viewDidLoad()
		net.getToken()

		NotificationCenter.default.addObserver(self, selector: #selector(self.listPagesFetched), name: NSNotification.Name("listPagesFetched"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.listQuestionsFetched), name: NSNotification.Name("listQuestionsFetched"), object: nil)
		
	}
	
	func listPagesFetched(){
		let pages = networkResource.listPages.map{ $1 }.sorted(by: { (Int($0["pageid"].string!)!) < (Int($1["pageid"].string!)!) })
		//print(pages)
		if let pageid = pages[index]["pageid"].string{
			string = pageid
		}
		if let page = pages[index]["page"].string {
			self.title = page
			let rightButton = UIBarButtonItem(title: "next", style: .plain, target: self, action: #selector(donepressed))
			rightButton.title = "next"
			self.navigationItem.rightBarButtonItem = rightButton
		}
		
	}
	
	func listQuestionsFetched(){
		let pages = networkResource.listQuestions.flatMap{ $0 }.map{ $1 }.filter{ $0["pageid"].string == string }
		print(pages)
		

		if(index > 0 ){
			print(form[0].removeAll())
			for el in pages {
				section <<< EmailRow () {
					$0.title = el["fieldname"].string
				}
			}
		}
		else{
			for el in pages {
				section <<< EmailRow () {
					$0.title = el["fieldname"].string
				}
			}
			form +++ section

		}
		

		
	}
	
	func donepressed(){
		self.index += 1
		print(index)
		listPagesFetched()
		listQuestionsFetched()
		print("done pressed")
	}
	
	
	

}
