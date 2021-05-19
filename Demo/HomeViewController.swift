//
//  HomeViewController.swift
//  Demo
//
//  Created by Jamil on 18/5/21.
//

import UIKit

protocol DataSelectionDelegate: class {
    func didSelectedData(_ data: Data)
}

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    weak var delegate  : DataSelectionDelegate?
    var dataArray:[Data] = []
    var currentPageIndex = 1
    
    var selectedData: Data? {
        didSet {
            refreshUI()
        }
    }

    private func refreshUI() {
        loadViewIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.splitViewController!.isCollapsed) {
            let navController:UINavigationController = self.splitViewController!.viewControllers.first as! UINavigationController
            navController.popToRootViewController(animated: false)
        }
        
        //set header title
        self.title = "Data List"
        
        //set tableview data source and delegate to this view
        tableView.dataSource = self
        tableView.delegate   = self
        
        //set cell seperator none
        tableView.separatorStyle = .none
        
        //register tableview cell
        registerCell()
        
        //Refresh data when user pull
        refreshData()
        
        //add refresh controll to table view when user pull
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    
    func refreshData() {
        //request api data from sever
        self.view.showProgressHUD()
        fetchDataForPage(currentPageIndex, completion: { responseDataArray in
            self.view.hideProgressHUD()
            
            self.dataArray += responseDataArray
            
            self.currentPageIndex += 1
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
            log("\n data count :\(String(describing: self.dataArray.count))")
        })
    }
    
    @objc func refresh(_ sender: AnyObject) {
        //refresh table view
        refreshData()
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
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataCell
        
        let data = dataArray[indexPath.row]
        if let _title = data.title {
            cell.dataTitle.text   = _title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           print(editingStyle)
            if editingStyle == .delete {
                dataArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedData = dataArray[indexPath.row]
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            delegate?.didSelectedData(selectedData)
            if let detailViewController = delegate as? DetailViewController,
               let detailNavigationController = detailViewController.navigationController {
                splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
            }
        } else {
            let storyboard: UIStoryboard = UIStoryboard.init(name: "Main",bundle: nil);
            let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            detailViewController.selectedData = selectedData
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
