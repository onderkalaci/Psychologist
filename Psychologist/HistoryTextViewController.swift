//
//  HistoryTextViewController.swift
//  Psychologist
//
//  Created by Onder Kalaci on 31/05/16.
//  Copyright © 2016 Onder Kalaci. All rights reserved.
//

import UIKit

class HistoryTextViewController: UIViewController
{

    @IBOutlet weak var HistoryTextView: UITextView!
    {
        didSet
        {
            HistoryTextView.text = textData
        }
    }
    
    var textData: String = ""
    {
        didSet
        {
            HistoryTextView?.text = textData
        }
    }
    
    
    override var preferredContentSize: CGSize
    {
        get
        {
            if HistoryTextView != nil && presentingViewController != nil
            {
                return HistoryTextView.sizeThatFits(presentingViewController!.view.bounds.size)
                
            }
            
            return super.preferredContentSize
        }
        
        set
        {
            super.preferredContentSize = newValue
        }
    }
}
