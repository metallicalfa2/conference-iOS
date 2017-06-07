//
//  DayViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 29/05/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Day2ViewController:UIViewController, IndicatorInfoProvider{
	@IBOutlet weak var tableView: UITableView!
	override func viewDidLoad() {
		self.tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
		self.tableView.separatorStyle = .none
		super.viewDidLoad()
	}
	func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
		return IndicatorInfo(title: "Day 2")
	}
}
extension Day2ViewController: UITableViewDelegate, UITableViewDataSource{
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
		return 20
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "schedule-cell-2", for: indexPath)
		cell.selectionStyle = .none
		//cell.view.dropShadow()
		return cell
	}
	
}
