//
//  SectionHeaderView.swift
//  accordionTableView
//
//  Created by 大西玲音 on 2021/06/05.
//

import UIKit

final class SectionHeaderView: UITableViewHeaderFooterView {
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    var onTapEvent: ((Int) -> Void)?
    var section: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didTapped))
        self.addGestureRecognizer(tapGR)
        
    }
    
    func configure(title: String, section: Int, onTapEvent: @escaping (Int) -> Void) {
        self.textLabel?.text = title
        self.section = section
        self.onTapEvent = onTapEvent
    }
    
    @objc private func didTapped(gestureRecognizer: UITapGestureRecognizer) {
        guard let headerView = gestureRecognizer.view as? SectionHeaderView,
              let section = headerView.section else { return }
        onTapEvent?(section)
    }
    
}
