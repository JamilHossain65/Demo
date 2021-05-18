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
    //static let sharedModel = DataModel()
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
        let header = ["Authorization":""]
        
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
        
        let resultArray = jsonDic?[APIKey.result].array
        if let _resultArray = resultArray{
            self.dataArray = []
            
            for dataDic in _resultArray{
                let data = Data()
                data.id     = dataDic[APIKey.id].intValue
                data.userId = dataDic[APIKey.userId].intValue
                data.title  = dataDic[APIKey.title ].stringValue
                data.isCompleted  = dataDic[APIKey.completed].boolValue
                dataArray?.append(data)
            }
        }
    }
}
