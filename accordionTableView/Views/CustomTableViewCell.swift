//
//  CustomTableViewCell.swift
//  accordionTableView
//
//  Created by 大西玲音 on 2021/06/05.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    @IBOutlet private weak var textView: UITextView!
    
    func configure(title: String) {
        textView.text = title
    }
    
}
