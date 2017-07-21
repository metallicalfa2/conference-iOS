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

var token:String = ""

class networkResource{
	
	let accessTokenRequest = "https://www.eiseverywhere.com/api/v2/global/authorize.json?accountid=7157&key=74b7ba663ce4885fd0c1ecefbb57fe8580e2a932"
	let eventid = "246511"
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
	
	func getSessionString(_ token:String,sessionKey:String,sessionId:String) -> String{
		return "https://www.eiseverywhere.com/api/v2/ereg/getSession.json?accesstoken="+token+"&eventid=246511&sessionkey="+sessionKey+"&sessionid="+sessionId+"&showhidden=1"
	}
	
	func getTracksString(_ token:String) -> String{
		return "https://www.eiseverywhere.com/api/v2/global/listTracks.json?accesstoken="+token
	}

	
	func getToken(){
		Alamofire.request(accessTokenRequest, method: .get).responseJSON { response in
			print("Error in fetching token: \(String(describing: response.error))")
			let res: JSON
			if let json = response.result.value {
				res = JSON(json)
				//print(res)
				token = res["accesstoken"].string!
				self.listSessions(res["accesstoken"].string!)
				self.getTracks(token)
			}
		}
	}
	
	func listSessions(_ token: String){
		Alamofire.request(getListSessionString(token), method: .get).responseJSON { response in
			print("Error in fetching listSessions: \(String(describing: response.error))")
			
			if let json = response.result.value {
				let data = JSON(json).map{ return $1 }
				
				data.forEach{ el in
					let session = sessionModel(id: el["sessionid"].string ?? "0", description: "sample desciption", name: el["name"].string ?? "sample name", startTime: el["starttime"].string ?? "stime", endTime: el["endtime"].string ?? "etime", sessiondate: el["sessiondate"].string!, sessionKey: el["sessionkey"].string!, speakerId: "")
					
					self.getSession(token,session: session)
				}
				

			}
		}
	}
	
	func getSession(_ token:String,session:sessionModel){
		let request =  getSessionString(token, sessionKey: session.sessionKey!, sessionId: session.sessionId!)
		Alamofire.request( request ,method: .get).responseJSON { response in
			print("Error in getSession: \(String(describing: response.error))")
			
			if let json = response.result.value {
				let data = JSON(json)
				let tracks = data["session_tracks"].map{ return $1.string! }
				let speakers = data["speakers"].map{return $1["speakerid"].string!}
				
				session.setSpeakers(speakers)
				session.setTracks(tracks)
				session.description = data["description"]["eng"].string
				
				if(session.sessiondate == "2017-07-14" ){
					sessionModel.sessionsDay1.append(session)
				}else if (session.sessiondate == "2017-07-15"){
					sessionModel.sessionsDay2.append(session)
				}else{
					sessionModel.sessionsDay3.append(session)
				}
				
				let notificationName = NSNotification.Name("sessionFetched")
				NotificationCenter.default.post(name: notificationName, object: nil)
			}
		}
	}
	
	func getTracks(_ token:String){
		Alamofire.request(getTracksString(token),method: .get).responseJSON { response in
			print("Error in fetching tracks: \(String(describing: response.error))")
			
			if let json = response.result.value {
				let data = JSON(json).map{ return $1 }
				data.forEach{ el in
					let track = tracksModel(el["track_name"].string!, track_id:el["track_id"].string!)
					tracksModel.tracks.append(track)
				}
			}
		}
	}
	
	
	func getListPages(_ token: String){
		Alamofire.request(getListPagesString(token), method: .get).responseJSON { response in
			print("Error in getListPages: \(String(describing: response.error))")
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
		Alamofire.request(getListQuestionsString(token, id: id), method: .get).responseJSON { response in
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
				//print(json)
				
			}
			
		}
	}
	
	
}
