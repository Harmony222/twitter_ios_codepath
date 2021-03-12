//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Harmony Scarlet on 3/11/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {
    var userInfo = NSDictionary()
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userScreenName: UILabel!
    @IBOutlet weak var userBio: UILabel!
    
    @IBOutlet weak var numTweets: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    @IBOutlet weak var numFollowers: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserInfo()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func getUserInfo() {
        let myUrl = "https://api.twitter.com/1.1/account/verify_credentials.json"
        
        let myParams = ["include_email": true]
        
        TwitterAPICaller.client?.getDictionaryRequest(url: myUrl, parameters: myParams, success: { (userInfo: NSDictionary) in
            self.userInfo = userInfo
//            print(self.userInfo)
            let userName = userInfo["name"] as! String
            let userBio = userInfo["description"] as! String
            let userScreenName = userInfo["screen_name"] as! String
            self.userName.text = userName
            self.userScreenName.text = "@" + userScreenName
            self.userBio.text = userBio
            // set profile image and make a circle
            let profileImagePath = userInfo["profile_image_url_https"] as! String
            let imageUrl = URL(string: profileImagePath)
            self.userImageView.setImageWith(imageUrl!)
            self.userImageView.layer.masksToBounds = true
            let radius = self.userImageView.frame.height/2
            self.userImageView.layer.cornerRadius = radius
            // set # tweets, following, followers
            let tweets = userInfo["statuses_count"] as! Int
            let following = userInfo["friends_count"] as! Int
            let followers = userInfo["followers_count"] as! Int
            self.numTweets.text = String(tweets)
            self.numFollowing.text = String(following)
            self.numFollowers.text = String(followers)
            
        }, failure: { (Error) in
            print("error retriving user info")
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
