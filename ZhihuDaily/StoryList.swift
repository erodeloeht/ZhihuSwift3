//
//  LatestNews.swift
//  ZhihuDaily
//
//  Created by Lisong Xu on 2/15/17.
//  Copyright © 2017 Lisong Xu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class StoryList {
    var date: String = ""
    var story: [String: AnyObject] = ["": "" as AnyObject]
    var stories: [[Story]] = []
    var sectionTitles = [String]()
    var numberOfNewStories = [Int]()
    
    func getStories(url: String, completion: @escaping () -> ()) {
        Alamofire.request(BASE_STORY_URL+url).responseJSON { (response) in
            let json = JSON(response.value!)
            self.date = json["date"].stringValue
            self.sectionTitles.append(self.date)
            
            var aStory = Story()
            var oneDayStories = [Story]()
            
            let stories = json["stories"].array
            for s in stories! {
                aStory.title = s["title"].stringValue
                aStory.imageURL = s["images"][0].stringValue
                aStory.type = s["type"].stringValue
                aStory.id = s["id"].stringValue

                oneDayStories.append(aStory)
             
            }
            oneDayStories.remove(at: 0)
            

            self.stories.append(oneDayStories)
            self.numberOfNewStories.append(oneDayStories.count)
//            self.stories.remove(at: 0)
//            print(oneDayStories.count)
//            print(self.stories)
//            print(self.numberOfNewStories)
            completion()
        }
        
    }
}
