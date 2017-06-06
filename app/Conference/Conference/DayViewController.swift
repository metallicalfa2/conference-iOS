//
//  DayViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 29/05/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DayViewController:UIViewController, IndicatorInfoProvider{
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var uiview: UIView!
	
	override func viewDidLoad() {
		self.tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
		self.tableView.separatorStyle = .none
		super.viewDidLoad()
	}
	func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
		return IndicatorInfo(title: "Day 1")
	}
}
extension DayViewController: UITableViewDelegate, UITableViewDataSource{

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
		return 20
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "schedule-cell", for: indexPath) as! ScheduleViewCell
		
		cell.selectionStyle = .none
		cell.view.dropShadow()
		return cell
	}
	

}

extension UIView {
	
	func dropShadow(scale: Bool = true) {
		
		self.layer.masksToBounds = false
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = 0.18
		self.layer.shadowOffset = CGSize(width: 0, height: 0)
		self.layer.shadowRadius = 4
		
		self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
		self.layer.shouldRasterize = true
		self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
	}
}
