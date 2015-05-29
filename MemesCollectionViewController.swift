//
//  MemesCollectionViewController.swift
//  ImagePickerTest
//
//  Created by Kevin Duck on 5/26/15.
//  Copyright (c) 2015 Kevin Duck. All rights reserved.
//

import UIKit

class MemesCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    
    //Refresh collection view, necessary when saving new meme
    override func viewDidAppear(animated: Bool) {
        self.collectionView.reloadData()
    }
    
    //select cell and create new detail vc
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let object:AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")!
        let detailVC = object as! MemeDetailViewController
        detailVC.savedMeme = self.memes[indexPath.row]
    }
    
    //Count number of memes
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes.count
    }
    
    //set up collection view cell (labels and image)
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        cell.topLabel.text = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.item].topTitle
        cell.bottomLabel.text = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.item].bottomTitle
        cell.memeImageView.image = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.item].image!
        return cell
    }
    
    //Pass meme index to new VC during segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "memeDetailView" {
            let detailViewController = segue.destinationViewController as! MemeDetailViewController
            var memeIndex = self.collectionView.indexPathForCell(sender as! CollectionViewCell)?.row
            detailViewController.savedMeme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[memeIndex!]
        }
        
    }
    
    //Cell helper
    func setCell(cell: CollectionViewCell, topText:String, bottomText:String, backgroundImage:UIImage)
    {
        cell.topLabel.text = topText
        cell.bottomLabel.text = bottomText
        cell.memeImageView.image = backgroundImage
    }
}