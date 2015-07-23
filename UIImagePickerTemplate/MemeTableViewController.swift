//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Luke on 2015/07/03.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import Foundation

import UIKit

//http://helpmecodeswift.com/advanced-functions/generating-uibuttons-loop
//http://www.raywenderlich.com/78568/create-slide-out-navigation-panel-swift



class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    var memes:[Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        var editorButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: self, action: "editorView")
        self.navigationItem.rightBarButtonItem = editorButton2
        self.navigationItem.leftBarButtonItem = editButtonItem()

    }
    
    func editorView(){
    
    let editorViewController = self.storyboard!.instantiateViewControllerWithIdentifier("EditorViewController") as! EditorViewController
    self.navigationController!.pushViewController(editorViewController, animated: true)

        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBar.hidden = true
        
    }
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
     func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! UITableViewCell
        let mymeme = self.memes[indexPath.row]
        
        // Set the name and image
        cell.textLabel?.text = mymeme.topText
        cell.imageView?.image = mymeme.memedImage
        
               return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailController.bigMeme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    
    
}
