//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Luke on 2015/07/03.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import UIKit
import Foundation

class MemeCollectionViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
        
    var memes:[Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let myMeme = self.memes[indexPath.row]
        // Set the name and image
        cell.topLabel.text = myMeme.topText
        cell.memeImage.image = myMeme.memedImage
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailController.bigMeme = self.memes[indexPath.row]
        navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}
