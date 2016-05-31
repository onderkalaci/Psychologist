//
//  HistoryViewController.swift
//  Psychologist
//
//  Created by Onder Kalaci on 30/05/16.
//  Copyright © 2016 Onder Kalaci. All rights reserved.
//

import UIKit

class HistoryViewController: UIView
{
    @IBOutlet weak var HistoryText: UITextView!
        {
        didSet
        {
            HistoryText.text = inputText
        }
    }
    
    var inputText :String = ""
        {
        didSet
        {
            HistoryText?.text = inputText
        }
    }
}
