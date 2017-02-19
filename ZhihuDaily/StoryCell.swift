//
//  NewsCell.swift
//  ZhihuDaily
//
//  Created by Lisong Xu on 2/15/17.
//  Copyright © 2017 Lisong Xu. All rights reserved.
//

import UIKit
import Kingfisher

class StoryCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    var story = Story()
    
    @IBOutlet weak var storyTitle: VerticalAlignLabel!
    @IBOutlet weak var storyImage: UIImageView!
    
    
    
    func configureCell(story: Story) {
        
        self.story = story
        storyTitle.text = story.title
        storyTitle.verticalAlignment = .middle
        guard (URL(string: story.imageURL!) != nil) else {
            return
        }
        storyImage.kf.setImage(with: URL(string: story.imageURL!)!)
    }
    
    
}
