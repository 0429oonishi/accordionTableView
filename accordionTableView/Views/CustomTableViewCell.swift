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
    var didChanged: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.delegate = self
        
    }
    
    func configure(section: Section) {
        textView.text = section.text
        textView.layer.cornerRadius = 10
    }
    
}

extension CustomTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        didChanged?()
    }
}
