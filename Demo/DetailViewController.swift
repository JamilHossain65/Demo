//
//  DetailViewController.swift
//  Demo
//
//  Created by Jamil on 18/5/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailTextLabel: UILabel!
    
    var selectedData: Data? {
        didSet {
            refreshUI()
        }
    }
    
    private func refreshUI() {
        loadViewIfNeeded()
        
        detailTextLabel.text = "id: \(selectedData?.id ?? 0)\n userId: \(selectedData?.userId ?? 0)\n title: \(selectedData?.title ?? "")\n completed: \(selectedData?.isCompleted ?? false)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set header title
        self.title = "Detail Data"
        refreshUI()
    }
}

extension DetailViewController: DataSelectionDelegate {
    func didSelectedData(_ data: Data) {
        selectedData = data
    }
}
