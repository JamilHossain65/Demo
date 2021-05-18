//
//  HomeViewController.swift
//  Demo
//
//  Created by Jamil on 18/5/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //request api data from sever
        let dataModel = DataModel()
        dataModel.doDataRequest(completion: {(success,errorModel) in
            //self.view.hideProgressHUD()
            for data in dataModel.dataArray ?? [] {
                log("\n id :\(String(describing: data.id))")
                log("userId:\(String(describing: data.userId))")
                log("title :\(String(describing: data.title))")
                log("isCompleted:\(String(describing: data.isCompleted))")
            }
            
        })
    }
}

