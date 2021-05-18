//
//  DataModel.swift
//  Demo
//
//  Created by Jamil on 18/5/21.
//

import UIKit
import SwiftyJSON

class Data: NSObject {
    var id    : Int?
    var userId: Int?
    var title : String?
    var isCompleted : Bool?
}

class DataModel: APIBase {
    static let sharedModel = DataModel()
    //Resuest fields
    var userId : Int?
    
    //Response fields
    var dataArray : [Data]?
    
    /*
     "userId": 1,
     "id": 3,
     "title": "fugiat veniam minus",
     "completed": false
    */
    
    func doDataRequest(completion: @escaping (Bool, ErrorModel?) -> ()) {
        let params:[String:Any] = [:]
        let header = ["Authorization":""] //self.getHeaderWithAccessToken(params: params)
        
        log("api data list :: \(API_DATA_LIST)")
        
        let requestUrl = BASE_URL + API_DATA_LIST
        APIBase.shared.callAPIRequestOutsideBodyForJSONData(urlString: requestUrl, method: .get, params: params, header: header) { (result, error) in
            if let _result = result {
                self.parseData(jsonDic: _result)
                completion(true,nil)
            }
        }
    }
    
    private func parseData(jsonDic: JSON?) {
        
        let resultArray = jsonDic?["result"].array
        if let _resultArray = resultArray{
            self.dataArray = []
            
            for dataDic in _resultArray{
                let data = Data()
                data.id     = dataDic["id"    ].intValue
                data.userId = dataDic["userId"].intValue
                data.title  = dataDic["title" ].stringValue
                data.isCompleted  = dataDic["completed" ].boolValue
                dataArray?.append(data)
            }
        }
    }
}
