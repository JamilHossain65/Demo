//
//  Utils.swift
//  Demo
//
//  Created by Jamil on 18/5/21.
//

import UIKit
import MBProgressHUD

enum UIUserInterfaceIdiom : Int {
    case unspecified
    
    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}

let kBgColor = UIColor.init(red: 209/255, green: 212/255, blue: 219/255, alpha: 1)

func log(_ msg: Any?) {
    #if DEBUG
    if let _msg = msg { print(String(describing: _msg)) }
    #endif
}

func isPad() -> Bool {
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
        break
    case .pad:
        break
    case .unspecified:
        break
    case .tv:
        break
    case .carPlay:
        break
    case .mac:
        break
    default:
        break
    }
    return false
}

func showAlertOkay(title: String? = "", message:String? = "", completion: @escaping (Bool) -> () = {_ in}) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //alert.view.tintColor = UIColor.gray
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
        completion(true)
    }))

    let window = UIApplication.shared.keyWindow
    window?.rootViewController?.present(alert, animated: true, completion: nil)
}

//class Utils:NSObject{
//
//}

extension UIView{
    func showProgressHUD(){
        //MBProgressHUD.showAdded(to: self, animated: true)
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.label.text = ""
        hud.isUserInteractionEnabled = false
    }
    
    func hideProgressHUD(){
        MBProgressHUD.hide(for: self, animated: true)
    }
    
}



