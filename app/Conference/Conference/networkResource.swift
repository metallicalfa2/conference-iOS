//
//  netwrokResource.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 08/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class networkResource{
	
	let accessTokenRequest = "https://www.eiseverywhere.com/api/v2/global/authorize.json?accountid=7157&key=74b7ba663ce4885fd0c1ecefbb57fe8580e2a932"
	var token:String = ""
	static var listPages: JSON = []
	static var listQuestions: [JSON] = []
	static var currentPage : String = ""
	
	func getListPagesString(_ token:String) -> String {
		return "https://www.eiseverywhere.com/api/v2/ereg/listPages.json?accesstoken="+token+"&eventid=246511"
	}
	
	func getListQuestionsString(_ token:String,id:String) -> String{
		return "https://www.eiseverywhere.com/api/v2/ereg/listQuestions.json?accesstoken="+token+"&eventid=246511&pageid="+id
	}
	
	func postCreateAttendeeString(_ token:String,email:String) -> String{
		return "https://www.eiseverywhere.com/api/v2/ereg/createAttendee.json?accesstoken="+token+"&eventid=246511&email="+email
	}
	
	func getListSessionString(_ token:String) -> String{
		return "https://www.eiseverywhere.com/api/v2/ereg/listSessions.json?accesstoken="+token+"&eventid=246511"
	}
	
	func getToken(){
		Alamofire.request(accessTokenRequest, method: .get).responseJSON { response in
			print("Error: \(String(describing: response.error))")
			let res: JSON
			if let json = response.result.value {
				res = JSON(json)
				self.token = res["accesstoken"].string!
				//self.getListPages(res["accesstoken"].string!)
				self.listSessions(res["accesstoken"].string!)
			}
		}
	}
	
	func listSessions(_ token: String){
		Alamofire.request(getListSessionString(token), method: .get).responseJSON { response in
			print("Error: \(String(describing: response.error))")
			
			if let json = response.result.value {
				let data = JSON(json).map{ return $1 }
				//print(data)
				data.forEach{ el in
					let session = sessionModel()
					print(el["sessiondate"])
					session.setValues(id: el["sessionid"].string ?? "0", description: "sample desciption", name: el["name"].string ?? "sample name", startTime: el["starttime"].string ?? "stime", endTime: el["endtime"].string ?? "etime", sessiondate: el["sessiondate"].string!)
					sessionModel.sessionsInstance.append(session)
				}
				
				let notificationName = NSNotification.Name("listSessionsFetched")
				NotificationCenter.default.post(name: notificationName, object: nil)
				print(sessionModel.sessionsInstance)
			}
		}
	}
	
	func getListPages(_ token: String){
		Alamofire.request(getListPagesString(token), method: .get).responseJSON { response in
			print("Error: \(String(describing: response.error))")
			if let json = response.result.value {
				networkResource.listPages = JSON(json)
				let _ = JSON(json).map{ (index,value) -> String? in
					self.getListQuestions(value["pageid"].string!)
					return value["pageid"].string
				}
				
				let notificationName = NSNotification.Name("listPagesFetched")
				NotificationCenter.default.post(name: notificationName, object: nil)
			}
		}
	}
	
	func getListQuestions(_ id:String){
		Alamofire.request(getListQuestionsString(self.token, id: id), method: .get).responseJSON { response in
			print("Error: \(String(describing: response.error))")
			if let json = response.result.value {
				networkResource.listQuestions.append(JSON(json))
				
				if (networkResource.listPages.array?.count == networkResource.listQuestions.count){
					let notificationName = NSNotification.Name("listQuestionsFetched")
					NotificationCenter.default.post(name: notificationName, object: nil)
				}
				
			}
			
		}
	}
	
	func createAttendee(_ email:String){
		Alamofire.request(postCreateAttendeeString(token, email: email), method: .post).responseJSON { response in
			print("Error: \(String(describing: response.error))")
			if let json = response.result.value {
				print(json)
				
			}
			
		}
	}
	
	
}
