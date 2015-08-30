//
//  File.swift
//  MemeMe
//
//  Created by Luke on 2015/07/03.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import Foundation


import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    var bigMeme: Meme!
    var indexNumber:Int!


    
    @IBAction func deleteButton(sender: AnyObject) {
        if let navigationController = self.navigationController {
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(indexNumber)
            navigationController.popToRootViewControllerAnimated(true)
        }
    }

    
    @IBAction func editorButton(sender: AnyObject) {
        editorView()
    }

    
    func editorView(){
        let editorViewController = storyboard!.instantiateViewControllerWithIdentifier("EditorViewController") as! EditorViewController
        editorViewController.indexNumber = indexNumber
        navigationController!.pushViewController(editorViewController, animated: true)
        tabBarController?.tabBar.hidden = true
        navigationController?.navigationBar.hidden = true
    }
    

    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hidden = true
        imageView!.image = bigMeme.memedImage
        println(indexNumber)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.hidden = false
    }
    
}
