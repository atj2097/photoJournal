//
//  Settings ControllerViewController.swift
//  photoJournal
//
//  Created by God on 10/14/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class Settings_ControllerViewController: UIViewController {
    
    
    @IBOutlet weak var darkModeText: UILabel!
    
    @IBOutlet weak var colorSwitch: UISwitch!
    @IBOutlet weak var scrollText: UILabel!
    @IBOutlet weak var scrollSwitch: UISwitch!
    
    @IBAction func backGroundColorSwitch(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            UserDefaultsWrapper.manager.storeBackCol(backColor: true)
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case false:
            UserDefaultsWrapper.manager.storeBackCol(backColor: false)
            self.view.backgroundColor = #colorLiteral(red: 0.5515964627, green: 0.7481098175, blue: 0.9596171975, alpha: 1)
        default:
            print("This is not being called")
        }
    }
    
    @IBAction func scrollDirectionSwitch(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            UserDefaultsWrapper.manager.storeScrollDir(scorllDir: true)
        case false:
            UserDefaultsWrapper.manager.storeScrollDir(scorllDir: false)
        default:
            print("Fix!")
        }
    }
    
    private func loadDefaultSettings() {
        if UserDefaultsWrapper.manager.getBackground() == true {
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        else {
            self.view.backgroundColor = #colorLiteral(red: 0.5515964627, green: 0.7481098175, blue: 0.9596171975, alpha: 1)
        }
        //UISwitchColor
        switch UserDefaultsWrapper.manager.getBackground(){
        case true:
            colorSwitch.isOn = true
        case false:
            colorSwitch.isOn = false
        default:
            print(" ")
        }
        
        //UISwitchScrollDirection
        switch UserDefaultsWrapper.manager.getScrollDir() {
        case true:
            scrollSwitch.isOn = true
        case false:
            scrollSwitch.isOn = false
        default:
            print(" ")
        }
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaultSettings()
        switch colorSwitch.isOn {
        case true:
            self.view.backgroundColor = .black
        case false:
            self.view.backgroundColor = #colorLiteral(red: 0.5515964627, green: 0.7481098175, blue: 0.9596171975, alpha: 1)
        default:
            print(" ")
        }
        // Do any additional setup after loading the view.
    }
    
    
    
}
