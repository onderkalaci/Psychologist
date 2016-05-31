//
//  ViewController.swift
//  Psychologist
//
//  Created by Onder Kalaci on 26/05/16.
//  Copyright © 2016 Onder Kalaci. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController
{

    @IBAction func SawNothing(sender: UIButton)
    {
        performSegueWithIdentifier("nothing", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        var destinationController = segue.destinationViewController as? UIViewController
        
        if let navigationController = destinationController as? UINavigationController
        {
            destinationController = navigationController.visibleViewController
        }
        
        if let hapinessViewController = destinationController as? HapinessViewController
        {
            if let identifier = segue.identifier
            {
                switch identifier {
                case "Sad":
                       hapinessViewController.hapiness = 0
                case "Happy":
                    hapinessViewController.hapiness = 100
                case "nothing":
                    hapinessViewController.hapiness = 25
                default:
                    hapinessViewController.hapiness = 50
                }
            }
        }
    }
}

