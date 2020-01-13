//
//  DetailedViewController.swift
//  UserDefaultLab
//
//  Created by David Lin on 1/13/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var horoscopeDetails: Horoscopes?
    
    @IBOutlet weak var horoscopeName: UILabel!
    @IBOutlet weak var horoscopeDescription: UITextView!
    @IBOutlet weak var horoscopeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        horoscopeName.text = horoscopeDetails?.sunsign
        horoscopeDescription.text = horoscopeDetails?.horoscope
        horoscopeImage.image = UIImage(named: "\(horoscopeDetails?.sunsign.lowercased())")
    }
    

}
