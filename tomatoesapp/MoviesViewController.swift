//
//  MoviesViewController.swift
//  tomatoesapp
//
//  Created by John Walecka on 4/8/15.
//  Copyright (c) 2015 John Walecka. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movies: [NSDictionary]! = [NSDictionary]()
    
    var refresh = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var errorView: UIView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refresh.addTarget(self, action: "loadMovies", forControlEvents: .ValueChanged)
        tableView.insertSubview(refresh, atIndex: 0)
        
        loadAPI()
        
        
            // Do any additional setup after loading the view.
    }
    
    func loadAPI()->Void {
        var url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5")!
        
        var request = NSURLRequest(URL: url)
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            self.movies = json["movies"] as [NSDictionary]
            
            self.errorLabel.text = "Networking Error"
            
            self.tableView.reloadData()
            
            if (error == nil) {
                self.errorView.hidden = true
            }
            else {
                self.errorView.hidden = false
            }
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMovies() {
        refresh.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as MovieCell
            
        var movie = movies[indexPath.row]
        var rating = movie["mpaa_rating"] as? String
        var synopsis = movie["synopsis"] as? String
        
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = "\(rating!) \(synopsis!)"
        
        var url = movie.valueForKeyPath("posters.thumbnail") as? String
        
        cell.posterView.setImageWithURL(NSURL(string: url!)!)
        
        cell.accessoryType = UITableViewCellAccessoryType.None
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var movieDetailViewController = segue.destinationViewController as MovieDetailViewController
        
        var cell = sender as UITableViewCell
        var indexPath = tableView.indexPathForCell(cell)!
        
        movieDetailViewController.movie = movies[indexPath.row]
        
        
        
        

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
