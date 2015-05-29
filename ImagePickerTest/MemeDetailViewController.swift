//
//  MemeDetailViewController.swift
//  ImagePickerTest
//
//  Created by Kevin Duck on 5/26/15.
//  Copyright (c) 2015 Kevin Duck. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    var savedMeme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = savedMeme.memedImage
    }
    
}