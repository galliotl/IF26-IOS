//
//  AccountViewController.swift
//  IF26-IOS
//
//  Created by FILIPPI Eliott on 05/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func logoff(_ sender: Any) {
        Switcher.loadDisconnectedScreen()
    }

}
