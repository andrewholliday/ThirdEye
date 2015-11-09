//
//  FoundTagNotRegisteredViewCell.swift
//  Third Eye
//
//  Created by Admin on 10/12/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit

class FoundTagNotRegisteredViewCell: UITableViewCell {

    @IBOutlet weak var lblTag:UILabel!
    
   

    func configure(#major:String ) {
        
        lblTag.text = major
       
        //        textField.text = text
        //        textField.placeholder = placeholder
        //
        //        textField.accessibilityValue = text
        //        textField.accessibilityLabel = placeholder
    }
    
    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
