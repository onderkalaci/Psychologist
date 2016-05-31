//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Onder Kalaci on 30/05/16.
//  Copyright © 2016 Onder Kalaci. All rights reserved.
//

import UIKit

class DiagnosedHapinessController: HapinessViewController, UIPopoverPresentationControllerDelegate
{
    @IBAction func ClearHistory(sender: AnyObject)
    {
        diagnasticHistory = [Int]()
        updateUI()
    }
    
    
    private let historyData = NSUserDefaults.standardUserDefaults()
    
    var diagnasticHistory: [Int]
    {
        get { return historyData.objectForKey(History.HistoryDataDefaultsKey) as? [Int] ?? []}
        set { historyData.setObject(newValue, forKey: History.HistoryDataDefaultsKey) }
    }
    

    private struct History
    {
        static let SegueIdentifier = "ShowHistory"
        static let HistoryDataDefaultsKey = "HistoryDataDefaultsKey"
    }
    
    override var hapiness: Int
    {
        didSet
        {
            diagnasticHistory += [hapiness]
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let identifier = segue.identifier
        {
            switch identifier
            {
                case History.SegueIdentifier:
                    if let historyViewController = segue.destinationViewController as? HistoryTextViewController
                    {
                        if let popoverController = historyViewController.popoverPresentationController
                        {
                            popoverController.delegate = self
                        }
                        
                        let textArrayOfHistory = diagnasticHistory.map(hapinessToString)
                        let textOfHistory = textArrayOfHistory.joinWithSeparator("\n")
                        
                        historyViewController.textData = "\(textOfHistory)"
                    }
                
                default:
                    break
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.None
    }
}
