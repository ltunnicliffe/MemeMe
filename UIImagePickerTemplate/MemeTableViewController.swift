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
    
    
    
    @IBOutlet var tableView: UITableView!
    
    var memes:[Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var editorButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "editorView")
        navigationItem.rightBarButtonItem = editorButton2
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        tableView.reloadData()
        println(memes)
    }
    
    func editorView(){
    
    let editorViewController = storyboard!.instantiateViewControllerWithIdentifier("EditorViewController") as! EditorViewController
        navigationController!.pushViewController(editorViewController, animated: true)
        tabBarController?.tabBar.hidden = true
        navigationController?.navigationBar.hidden = true
        
    }
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Delete the row from the data source
            memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.reloadData()
        }
    }
    
     func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! UITableViewCell
        let mymeme = memes[indexPath.row]
        // Set the name and image
        cell.textLabel?.text = mymeme.topText
        cell.imageView?.image = mymeme.memedImage
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailController.bigMeme = self.memes[indexPath.row]
        detailController.indexNumber = indexPath.row
        navigationController!.pushViewController(detailController, animated: true)
    }
    
  
}
