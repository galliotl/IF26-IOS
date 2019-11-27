//
//  FeedControllerViewController.swift
//  IF26-IOS
//
//  Created by GALLIOT Lucas on 27/11/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppVariables.songs.count
    }

}
