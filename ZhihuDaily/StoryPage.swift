//
//  StoryPage.swift
//  ZhihuDaily
//
//  Created by Lisong Xu on 2/16/17.
//  Copyright © 2017 Lisong Xu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class StoryPage {
    var body: String = ""
    var image_source: String = ""
    var title: String = ""
    var imageURL: String = ""
    var shareURL: String = ""
    var type: String = ""
    var id: String = "1"
    var css: String = ""
    

    
    func loadStory(id: String, completion: @escaping () -> ()) {
        Alamofire.request(BASE_STORY_URL+id).responseJSON { (response) in
            let json = JSON(response.value!)
            self.body = json["body"].stringValue
            self.image_source = json["image_source"].stringValue
            self.title = json["title"].stringValue
            self.imageURL = json["image"].stringValue
            self.shareURL = json["share_url"].stringValue
            self.type = json["type"].stringValue
            self.id = json["id"].stringValue
            self.css = json["css"][0].stringValue
            self.body = "<html><head><link rel=\"stylesheet\" href=\"style.css\"</head><body class=\"night\">"+self.body+"</body></html>"
            completion()
        }
    }
}
