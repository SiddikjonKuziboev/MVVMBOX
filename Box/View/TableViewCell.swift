//
//  TableViewCell.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 10/23/22.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(data: UserDM) {
        imgView.sd_setImage(with: URL(string: data.picture), placeholderImage: UIImage(systemName: "plus"))
        subTitleLbl.text = data.title
        titleLbl.text = data.firstName
    }
}
