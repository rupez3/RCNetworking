//
//  ViewController.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/23/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .blue
        
        //Example Implementation:
        ConfigurationConsumer(api: .configuration(queryParams: ["configId":"co19"])).loadData { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            case .empty:
                print("dfaa")
            }
        }
        
    }

}

