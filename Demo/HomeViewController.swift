//
//  HomeViewController.swift
//  Demo
//
//  Created by Jamil on 18/5/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var dataArray:[Data]?

    var currentUserIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set header title
        self.title = "Data List"
        
        //set tableview data source and delegate to this view
        tableView.dataSource = self
        tableView.delegate   = self
        
        //set cell seperator none
        tableView.separatorStyle = .none
        
        //register tableview cell
        registerCell()
        
        //request api data from sever
        let dataModel = DataModel()
        self.view.showProgressHUD()
        
        dataModel.doDataRequest(completion: {(success,errorModel) in
            self.view.hideProgressHUD()
            self.dataArray = dataModel.dataArray
            self.tableView.reloadData()
            
            for data in dataModel.dataArray ?? [] {
                log("\n id :\(String(describing: data.id))")
                log("userId:\(String(describing: data.userId))")
                log("title :\(String(describing: data.title))")
                log("isCompleted:\(String(describing: data.isCompleted))")
            }
        })
    }
}

//MARK: ==== Table View ====
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func registerCell() {
        let identifer = "DataCell"
        let nib = UINib(nibName: identifer, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier:identifer)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataCell
        
        if let _dataArray = dataArray {
            let data = _dataArray[indexPath.row]
            if let _title = data.title {
                cell.dataTitle.text   = _title
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedData = dataArray?[indexPath.row]
        
        let storyboard: UIStoryboard = UIStoryboard.init(name: "Main",bundle: nil);
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.selectedData = selectedData ?? Data()
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

