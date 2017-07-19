//
//  sessionClass.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 08/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class sessionModel{

	static var sessionsInstance : [sessionModel] = []
	
	var sessionId: String?
	var description: String?
	var endtime: String?
	var location:String?
	var name:String?
	var sessiondate:String?
	var sessiontype:String?
	var speakers: [String]?
	var starttime: String?
	var tracks: [String]?
	
	func setValues(id: String?, description: String?, name:String?, startTime:String? , endTime:String?, sessiondate: String?){
		self.sessionId = id!
		self.description = description
		self.name = name
		self.starttime = startTime
		self.endtime = endTime
		self.sessiondate = sessiondate
	}
	
	init(){
		print("session initialised")
	}
}



