//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by Luke on 2015/07/02.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import Foundation
import UIKit



class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    //This method means that the keyboard is hidden when the users presses return.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true;

    }
    //This delegate does not allow the user to edit existing text. If this method is absent then when you tap the text field,  you can edit the existing text. In addition, when this method is present, an x appears in the right of the textfield box.
    func textFieldDidBeginEditing(textField: UITextField) {
      //Check whether the default text is entered or not prior clearing the input
        if  textField.text == "Top"   {
            textField.text = ""
        }
        else if textField.text == "Bottom" {
            textField.text = ""
        }
    }
    
}