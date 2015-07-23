//
//  MemeObject.swift
//  MemeMe
//
//  Created by Luke on 2015/07/02.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import Foundation
import UIKit


struct Meme{
    
    let topText: String
    let bottomText: String
    let mainImage: UIImage!
    let memedImage: UIImage!
    

    
    
    init(topText:String, bottomText: String, mainImage: UIImage!, memedImage:UIImage! ) {
        
        self.topText = topText
        self.bottomText = bottomText
        self.mainImage = mainImage
        self.memedImage = memedImage
        

    }




}


