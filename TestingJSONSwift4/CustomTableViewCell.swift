//
//  CustomTableViewCell.swift
//  TestingJSONSwift4
//
//  Created by Ahmed on 02/02/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var report:Report!{
        didSet{
        nameLabel.text=report.name
        companyName.text=report.companyDetails
        addressLabel.text=report.address
        }
    }
   
    
}
class Report{
    var name:String?
    var companyDetails:String?
    var address:String?
    init(name:String?,companyDetails:String?,address:String?) {
        self.name=name
        self.companyDetails=companyDetails
        self.address=address
    }
}
