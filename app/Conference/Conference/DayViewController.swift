//
//  DayViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 29/05/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Firebase
import FirebaseDatabase

class DayViewController:UIViewController, IndicatorInfoProvider{
	@IBOutlet weak var tableView: UITableView!
	var sessions = [sessionModel]()
	
	override func viewDidLoad() {
		self.tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
		self.tableView.separatorStyle = .none
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		
		super.viewDidLoad()
		let session = FIRDatabase.database().reference().child("264511")
		
		session.observe(FIRDataEventType.value, with: { (snapshot) in
			
			//if the reference have some values
			if snapshot.childrenCount > 0 {
				
				//clearing the list
				self.sessions.removeAll()
				
				//iterating through all the values
				for sessions in snapshot.children.allObjects as! [FIRDataSnapshot] {
					let sessionkey = sessions.key
					let sessionObject = sessions.value as? [String:AnyObject]
					let session = sessionModel(id: sessionkey, description:sessionObject?["description"] as? String,name: sessionObject?["name"] as? String)
					self.sessions.append(session)
					print(session)
				}
				//print(self.sessions)
				//reloading the tableview
				self.tableView.reloadData()
			}
		})
	}
	func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
		return IndicatorInfo(title: "Day 1")
	}
}

// Extention for tableViewMethods
extension DayViewController: UITableViewDelegate, UITableViewDataSource,UITableViewDataSourcePrefetching{

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
		return sessions.count
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 35
	}
	
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		let header = view as! UITableViewHeaderFooterView
		header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
		header.textLabel!.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
		header.backgroundView?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
		
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Time 10:00 - 11:00 am"
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	
		let cell = tableView.dequeueReusableCell(withIdentifier: "schedule-cell", for: indexPath) as! ScheduleViewCell
		cell.selectionStyle = .none
		cell.outerViewForCornerRadius.dropShadow()
		cell.calendarButton.addTarget(self, action: #selector(self.addCalendarEntry), for: .touchUpInside)
//		cell.layer.shouldRasterize = true
//		cell.layer.rasterizationScale = UIScreen.main.scal
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let objSecond = storyboard.instantiateViewController(withIdentifier: "scheduleDetails")
		navigationController?.pushViewController(objSecond, animated: true)
		
	}
	
	// This methods will be used for smooth scrolling.
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		print("prefetchRowsAt \(indexPaths)")
	}
	
	func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		print("cancelPrefetchingForRowsAt \(indexPaths)")
	}
	
}


