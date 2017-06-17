//
//  ScheduleDetailsViewController.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 17/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class ScheduleDetailsViewController: UIViewController {
	@IBOutlet weak var addToCalendar: UIButton!
	
	@IBOutlet weak var info: UILabel!
	@IBOutlet weak var speakerName: UILabel!
	
	@IBOutlet weak var eventName: UILabel!
	@IBOutlet weak var eventTime: UILabel!
	@IBOutlet weak var speakerImage: UIImageView!
	@IBOutlet weak var speakerTitle: UILabel!
	@IBAction func addToCalendar(_ sender: Any) {
		self.addCalendarEntry()
	}
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
}
