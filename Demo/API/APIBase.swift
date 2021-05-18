//
//  APIBase.swift
//  Demo
//
//  Created by Jamil on 18/5/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class APIBase {
    
    static let shared = APIBase()
    var header: HTTPHeaders!
    
    // Initialization
    init() {
        
    }
    
    //do request if params are outside of url request body
    func callAPIRequestOutsideBodyForJSONData(urlString: String, method:HTTPMethod, params: Parameters?, header: HTTPHeaders?, completion: @escaping(JSON?, NSError?) -> ()){
        
        //if /*let jsonData = try? JSONEncoding.encoding(param)*/ true {
            
            var request = URLRequest(url: URL(string: urlString)!)
            request.httpMethod = method.rawValue
            //request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = nil //jsonData
            
            Alamofire.request(request).responseJSON { (response) in
                
                print("\n\(response)\n\n")
                
                if let result = response.result.value as? NSArray {
                    let _jsonData = JSON(["result":result])
                    completion(_jsonData, nil)
                }else if let result = response.result.value as? NSDictionary{
                    let _jsonData = JSON(result as Any)
                    completion(_jsonData, nil)
                } else {
                    print("response.result.error: \(String(describing: response.result.error))")
                    completion(nil, response.result.error as NSError?)
                }
            }
       // }
    }
    
    /*
    //do request if params are inside of url request body
    func callAPIRequestWithJSONData(urlString: String, method: HTTPMethod, params: Parameters?, header: HTTPHeaders?, completion: @escaping(JSON?, NSError?) -> ()) {
        
        //check internet connection
        if !Reachability.isConnectedToNetwork() {
            showAlertOkay(message: "Not connected to the internet")
            return
        }
        
        // debug print
        if let _header = header {
            print("[REQUEST HEADER]: \(_header)")
        }
        
        if let _param = params {
            print("[REQUEST PARAM]: \(_param)")
        }
        
        print("[REQUEST URL]: \(urlString)")
        
        Alamofire.request(urlString, method: method, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in //URLEncoding JSONEncoding
            if let result = response.result.value as? NSDictionary {
                print("\n result::\(result)\n\n")
                let _jsonData = JSON(result as Any)
                completion(_jsonData, nil)
            } else {
                print("response.result.error: \(String(describing: response.result.error))")
                completion(nil, response.result.error as NSError?)
            }
        }
    }
     
     // Header with Access Token
    func getHeaderWithAccessToken(params:Parameters?) -> [String:String] {
        return ["Authorization": ""]
    }
     */
    
}

