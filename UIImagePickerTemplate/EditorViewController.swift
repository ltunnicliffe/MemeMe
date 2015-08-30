
//
//  EditorViewController.swift
//  MemeMeProject
//
//  Created by Luke on 2015/06/15.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//Template that shows how to use the UIImagePickerView

import UIKit


class EditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var topTextField: UITextField!
    @IBOutlet var bottomTextField: UITextField!
    @IBOutlet var sendMeme: UIBarButtonItem!
    @IBOutlet var topToolBar: UIToolbar!
    @IBOutlet var bottomToolBar: UIToolbar!
    @IBOutlet var cameraButton: UIBarButtonItem!
    
    
    var indexNumber:Int?
    var bigMeme: Meme?
    var memes:[Meme]!

    
    
    

    
    //Creates an instance of the UIImagePickerController
    let pickController = UIImagePickerController()
    let textFieldDelegate = TextFieldDelegate()
    let menuView = UIView()
    let barWidth:CGFloat = 150.0
    
    @IBAction func fontButton(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    func toggleSideMenuView(){
        menuView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, barWidth, imageView.frame.size.height)
        menuView.backgroundColor = UIColor.purpleColor()
    }

    @IBAction func takePicture(sender: AnyObject) {
        pickController.allowsEditing = false
        pickController.sourceType = UIImagePickerControllerSourceType.Camera
        sendMeme.enabled = true
        presentViewController(pickController, animated: true, completion: nil)
    }
    
    @IBAction func picker(sender: AnyObject) {
        pickController.allowsEditing = false
        pickController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        sendMeme.enabled = true
        //Button is given an action that allows it to present the image picker view.
        presentViewController(pickController, animated: true, completion: nil)
    }

        //This function is here because it would be useful to save a meme, even when you don't want to send it to someone.
    @IBAction func save(sender: AnyObject) {
        let image:UIImage = generateMemedImage()
        save()
    }
    
    @IBAction func sendMeme(sender: AnyObject) {
        let image:UIImage = generateMemedImage()
        let nextController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        presentViewController(nextController, animated: true, completion: nil)
        nextController.completionWithItemsHandler = {(activityType, completed:Bool, returnedItems,activityError) in
            if !completed {
                    //I think that the Meme would also be saved here when a Meme is sent because save is also called here.
                self.save()
                println("save called!")
                self.dismissViewControllerAnimated(true, completion: nil)
                return
            }
                  }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
        imageView.image = pickedImage
        //Makes sure the picture conforms to its aspect ratio
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.center = view.center
        //Goes back to the original UIImageView screen
        dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    

    //Used for when the user select cancel rather than picking an image. Goes back to the first view.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Sets this view controller to be the delegate for UIImagePicker.
        pickController.delegate = self
        topTextField.delegate = textFieldDelegate
        bottomTextField.delegate = textFieldDelegate
        textFieldSetter()
        sendMeme.enabled = false
        
        if (indexNumber != nil) {
            
            let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            memes = applicationDelegate.memes
            bigMeme = memes[indexNumber!]
            topTextField.text = bigMeme!.topText
            bottomTextField.text = bigMeme!.bottomText
            imageView.image = bigMeme!.mainImage
        }
        

    }
    
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return true
    }

    
    //Sets the text of the text field and calls the textFieldMaker function.
    func textFieldSetter() {
        topTextField.text = "Top"
        bottomTextField.text = "Bottom"
        textFieldMaker(topTextField)
        textFieldMaker(bottomTextField)
    }

    //A function that takes as its parameter a text field. It then sets the styles of the text fields.
    func textFieldMaker(textString: UITextField){
        let memeTextAttributes = [NSStrokeWidthAttributeName: -4.0,
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!]
        textString.defaultTextAttributes = memeTextAttributes
        textString.textAlignment = NSTextAlignment.Center
        textString.borderStyle = UITextBorderStyle.None
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    //If the camera is not enabled, then the user will not be able to press the camera button.
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        //resets the code independent of the getKeyboardHeight method
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }

    func save() {
        //Create the meme
        
        if (indexNumber != nil) {
            let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            applicationDelegate.memes[indexNumber!].topText = topTextField.text
            applicationDelegate.memes[indexNumber!].bottomText = bottomTextField.text
            applicationDelegate.memes[indexNumber!].mainImage = imageView.image
            applicationDelegate.memes[indexNumber!].memedImage = generateMemedImage()
        }
        else {
            var meme = Meme( topText: topTextField.text, bottomText: bottomTextField.text, mainImage: imageView.image, memedImage:generateMemedImage())
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        }
        
        
    }
    
    func generateMemedImage() -> UIImage {
        topToolBar.hidden = true
        bottomToolBar.hidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        topToolBar.hidden = false
        bottomToolBar.hidden = false
        return memedImage
    }
}

