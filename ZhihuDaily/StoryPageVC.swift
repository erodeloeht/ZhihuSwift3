//
//  StoryPageVC.swift
//  ZhihuDaily
//
//  Created by Lisong Xu on 2/16/17.
//  Copyright © 2017 Lisong Xu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class StoryPageVC: UIViewController {

    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var storyWebView: UIWebView!
    @IBAction func swipeBack(_ sender: UISwipeGestureRecognizer) {
    }

    var storyPage = StoryPage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        storyPage.loadStory(id: storyPage.id){
            self.setupUI()
        }

    
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupUI() {
        let mainbundle = Bundle.main.bundlePath
        let bundleURL = NSURL(fileURLWithPath: mainbundle)
        
//        storyWebView.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1)
//        storyWebView.isOpaque = false
        storyWebView.loadHTMLString(storyPage.body, baseURL: bundleURL as URL)
        
        
        storyImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        storyImage.layer.shadowColor = UIColor.black.cgColor
        storyImage.layer.shadowOpacity = 0.5
        storyImage.layer.shadowRadius = 3
        storyImage.layer.shadowOffset = CGSize(width: 0, height: 3)
        storyImage.layer.shouldRasterize = true
        storyWebView.scrollView.addSubview(storyImage)
        storyImage.kf.setImage(with: URL(string: storyPage.imageURL)!)
        
        
    }
    
    
    
    
}
