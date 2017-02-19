//
//  ViewController.swift
//  ZhihuDaily
//
//  Created by Lisong Xu on 2/15/17.
//  Copyright © 2017 Lisong Xu. All rights reserved.
//

import UIKit

class StoryListVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var storyList = StoryList()
    var story = Story()
    var storyPage = StoryPage()
    var selectedId = ""

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
//        navigationController?.navigationBar.isHidden = true
        storyList.getStories(url: "latest") {
            self.storyList.getStories(url: "before/\(self.storyList.date)") {
//                self.beforeDate = self.storyList.date
                self.tableView.reloadData()
            }
            
        }
    
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return storyList.stories.count
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return nil
//        } else {
//            return storyList.sectionTitles[section]
//        }
//        
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 25))
        headerView.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 25))
        if section == 0 {
            label.text = "今日热闻"
        } else {
            label.text = storyList.sectionTitles[section]
        }
        label.textAlignment = .center
        label.textColor = .white
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0
        }
        return 25
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return storyList.numberOfNewStories[section]
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell") as! StoryCell
        let story = storyList.stories[indexPath.section][indexPath.row]
        cell.configureCell(story: story)
        
        if indexPath.section == storyList.sectionTitles.count - 1 && indexPath.row == (storyList.stories.last?.count)! - 4 {
            storyList.getStories(url: "before/\(self.storyList.date)", completion: {
                self.tableView.reloadData()
            })
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showStory", sender: StoryCell())
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showStory" {
            let destVC = segue.destination as! StoryPageVC

//            let cell = sender as! StoryCell
//            let section = tableView.indexPath(for: cell)?.section
//            let row = tableView.indexPath(for: cell)?.row
//            destVC.storyPage.id = storyList.stories[section!][row!].id!
//            let clicked = sender as! StoryCell
//            destVC.storyPage.id = clicked.story.id!
            destVC.storyPage.id = storyList.stories[(tableView.indexPathForSelectedRow?.section)!][(tableView.indexPathForSelectedRow?.row)!].id!
        }
    }
    
}

