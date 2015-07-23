//
//  FontScrollView.swift
//  MemeMe
//
//  Created by Luke on 2015/07/13.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import UIKit


class FontScrollView: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet var fontScroll: UIScrollView!
    
    
    override func viewDidLoad() {
        fontScroll.delegate = self
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // let percentageScroll = foreground.contentOffset.y / foregroundHeight
        let fontScrollHeight = fontScroll.contentSize.height - CGRectGetHeight(fontScroll.bounds)
        
        //  background.contentOffset = CGPoint(x: 0, y: backgroundHeight * percentageScroll)
    }

    
    
    
}