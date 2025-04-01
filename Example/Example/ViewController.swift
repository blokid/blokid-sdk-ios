//
//  ViewController.swift
//  Example
//
//  Created by Netset on 03/01/25.
//

import UIKit
import BlokID_iOS_Netset

class ViewController: UIViewController {

    let objBlokIDTrack = BlokIDTrack(siteIdentifier: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objBlokIDTrack.trackEvent(event: .firstVisit)
    }


}

