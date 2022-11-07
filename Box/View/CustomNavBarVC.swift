//
//  CustomNavBarVC.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 03/11/22.
//

import UIKit

class CustomNavBarVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    var viewModel: UserVM = UserVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
}

extension CustomNavBarVC: UITableViewDelegate, UITableViewDataSource {
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .singleLine
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)as! TableViewCell
        cell.titleLbl.text = "123456"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.462745098, blue: 0.7294117647, alpha: 1)
        view.frame = CGRect(x: 0, y: 0, width: SCREEN_SIZE.width, height: 40)
        
        return view
    }
    
}
