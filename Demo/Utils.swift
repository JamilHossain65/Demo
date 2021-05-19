//
//  Utils.swift
//  Demo
//
//  Created by Jamil on 18/5/21.
//

import UIKit
import MBProgressHUD

let kBgColor = UIColor.init(red: 209/255, green: 212/255, blue: 219/255, alpha: 1)

func log(_ msg: Any?) {
    #if DEBUG
    if let _msg = msg { print(String(describing: _msg)) }
    #endif
}

func fetchDataForPage(_ index:Int, completion: @escaping([Data]) -> ()) {
    //request api data from sever
    let dataModel = DataModel()
    dataModel.userId = index
    
    //self.view.showProgressHUD()
    dataModel.doDataRequest(completion: {(success,errorModel) in
        //self.view.hideProgressHUD()
        if let _dataArray = dataModel.dataArray {
            completion(_dataArray)
        }
    })
}

//class Utils:NSObject{
//
//}

extension UIView{
    func showProgressHUD(){
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.label.text = ""
        hud.isUserInteractionEnabled = false
    }
    
    func hideProgressHUD(){
        MBProgressHUD.hide(for: self, animated: true)
    }
    
}



