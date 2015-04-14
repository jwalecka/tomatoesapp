//
//  MovieDetailViewController.swift
//  tomatoesapp
//
//  Created by John Walecka on 4/10/15.
//  Copyright (c) 2015 John Walecka. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var movie: NSDictionary!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var title = movie["title"] as? String
        var year = movie["year"] as? Int
        var criticScore = movie.valueForKeyPath("ratings.critics_score") as? Int
        var audienceScore = movie.valueForKeyPath("ratings.audience_score") as? Int
        var rating = movie["mpaa_rating"] as? String
        
        
        titleLabel.text = "\(title!) (\(year!))"
        scoreLabel.text = "Critics Score: \(criticScore!), Audience Score: \(audienceScore!)"
        ratingLabel.text = "\(rating!)"
        
        
        synopsisLabel.text = movie["synopsis"] as? String
        synopsisLabel.sizeToFit()
        self.scrollView.contentSize = synopsisLabel.frame.size
        
        println(synopsisLabel.frame.size)
        
        var url = movie.valueForKeyPath("posters.original") as? String
        var range = url!.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            url = url!.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        
        
        movieImage.setImageWithURL(NSURL(string: url!)!)
        

        // Do any additional setup after loading the view.
    }
    
    func sizeToFitHeight()->Void {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
