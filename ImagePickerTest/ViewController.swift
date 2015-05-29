//
//  ViewController.swift
//  ImagePickerTest
//
//  Created by Kevin Duck on 5/10/15.
//  Copyright (c) 2015 Kevin Duck. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomTolbar: UIToolbar!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    
    var memeImage: UIImage?
    
    
    //Set text attributes to give stroke and color
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.defaultTextAttributes = memeTextAttributes
        bottomLabel.defaultTextAttributes = memeTextAttributes
        self.actionButton.enabled = false
    }
    
    //Disble camera button if device has no camera
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
//MARK: Keyboard functionality
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //Move image out of way of keyboard
    func keyboardWillShow(notification: NSNotification) {
        if bottomLabel.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    //Move keyboard out of way of image
    func keyboardWillHide(notifcation: NSNotification) {
        if bottomLabel.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notifcation)
        }
    }
    
    //Calculate keyboard size for moving it
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        // Dissmiss the keyboard when the view is touched
        self.view.endEditing(true)
    }
    
//MARK: Image picking
    
    //Get image from album
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //Get image from camera
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }

    //Get image and dismiss picker
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.actionButton.enabled = true
            imagePickerView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func actionButtonPressed(sender: UIBarButtonItem)
    {
        println("Action button pressed")
        self.memeImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [self.memeImage!], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true) { () -> Void in
            println("presenting view controller")
        }

        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            self.save(self.memeImage!)
            println("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
        }
        
        
    }
    
    
    @IBAction func cancelMeme(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        println("canceled meme creation")
    }


    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        println("canceled image picking")
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
//MARK: Meme object
    
    //Create meme from image and text inputs
    func generateMemedImage() -> UIImage {
        //Hide toolbar
        self.topToolbar.hidden = true
        self.bottomTolbar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Show toolbar
        self.topToolbar.hidden = false
        self.bottomTolbar.hidden = false
        
        return memedImage
    }
    
    //Save meme and add it to array
    func save(memedImage:UIImage) {
        var newMeme = Meme(topTitle: self.topLabel.text!, bottomTitle: self.bottomLabel.text!, image: self.imagePickerView.image!, memedImage: memedImage)
        println("saving meme")
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(newMeme)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}


















































