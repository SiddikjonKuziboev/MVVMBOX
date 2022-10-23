//
//  ViewController.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 10/19/22.
//

import UIKit

class UserVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: UserVM = UserVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        bindData()
        viewModel.getAllUser()
    }
    
    private func bindData() {
        viewModel.users.subscribe { _ in
            self.tableView.reloadData()
        }
    }
    
  
}

extension UserVC: UITableViewDelegate, UITableViewDataSource {
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)as! TableViewCell
        cell.updateCell(data: viewModel.users.value[indexPath.row])
        return cell
    }
}
