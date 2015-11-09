//
//  FoundTagCell.swift
//  Third Eye
//
//  Created by Admin on 10/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit

class FoundTagViewCell: UITableViewCell {

    @IBOutlet weak var lblMinor: UILabel!
    
    @IBOutlet weak var lblMajor: UILabel!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func configure(major major:String, minor:String, minor1:Int) {
        
        lblMajor.text = major
        lblMinor.text = minor
//        textField.text = text
//        textField.placeholder = placeholder
//        
//        textField.accessibilityValue = text
//        textField.accessibilityLabel = placeholder
    }
    
    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
