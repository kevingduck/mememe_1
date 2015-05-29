//
//  MemesTableViewController.swift
//  ImagePickerTest
//
//  Created by Kevin Duck on 5/26/15.
//  Copyright (c) 2015 Kevin Duck. All rights reserved.
//


import UIKit

class MemesTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var memeTable: UITableView!
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
    }
    
    override func viewDidAppear(animated: Bool) {
        self.memeTable.reloadData()
    }
    
    //Count items in meme array
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes.count
    }
    
    //Prepare cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CollectionViewCell", forIndexPath: indexPath) as! UITableViewCell
        cell.imageView?.image = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row].memedImage
        cell.textLabel?.text = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row].topTitle
        
        return cell
    }
    
    //Share meme info with incoming detail view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "memeDetailView"
        {
            let detailVC = segue.destinationViewController as! MemeDetailViewController
            var memeIndex = self.tableView.indexPathForSelectedRow()?.row
            detailVC.savedMeme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[memeIndex!]
        }
        
    }

}
