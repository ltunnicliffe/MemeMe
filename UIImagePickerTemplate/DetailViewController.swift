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
  

    //Makes sure the picture conforms to its aspect ratio
    
    
    var bigMeme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)


        //imageView.contentMode = .ScaleAspectFill

        self.tabBarController?.tabBar.hidden = true
        
        self.imageView!.image = bigMeme.memedImage
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
}
