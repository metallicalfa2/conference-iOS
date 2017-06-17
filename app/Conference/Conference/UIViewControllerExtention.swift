//
//  UIViewControllerExtention.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 17/06/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import EventKit

extension UIViewController {
	func showAlertMessage(titleStr:String, messageStr:String) {
		let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.alert)
		let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
			UIAlertAction in
			NSLog("OK Pressed")
		}
		alert.addAction(okAction)
		self.present(alert, animated: true, completion: nil)
	}
	func addCalendarEntry(){
		let eventStore : EKEventStore = EKEventStore()
		
		//Access permission
		eventStore.requestAccess(to: EKEntityType.event) { (granted,error) in
			
			if (granted) &&  (error == nil) {
				print("permission is granted")
				
				let event:EKEvent = EKEvent(eventStore: eventStore)
				event.title = "Event Creater 1"
				event.startDate = NSDate() as Date
				event.endDate = NSDate() as Date
				event.notes = "This is a note of creating event"
				event.calendar = eventStore.defaultCalendarForNewEvents
				event.addAlarm(EKAlarm.init(relativeOffset: 60.0))
				do {
					try eventStore.save(event, span: .thisEvent)
					self.showAlertMessage(titleStr: "Event Saved", messageStr: "You will be notified before the event")
				} catch let specError as NSError {
					print("A specific error occurred: \(specError)")
				} catch {
					print("An error occurred")
				}
				print("Event saved")
				
			} else {
				print("need permission to create a event")
			}
		}
	}

}
