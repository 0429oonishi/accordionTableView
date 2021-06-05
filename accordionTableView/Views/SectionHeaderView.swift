//
//  SectionHeaderView.swift
//  accordionTableView
//
//  Created by 大西玲音 on 2021/06/05.
//

import UIKit

protocol SectionHeaderViewDelegate: UIViewController {
    func didTapped()
}

extension SectionHeaderViewDelegate {
    func didTapped() {
        let sampleVC = SampleViewController.instaintiate()
        self.present(sampleVC, animated: true, completion: nil)
    }
}

final class SectionHeaderView: UITableViewHeaderFooterView {
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    var buttonDidTapped: (() -> Void)?
    var isExpanded = false
    var delegate: SectionHeaderViewDelegate?
    
    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var timeLabel1: UILabel!
    @IBOutlet private weak var timeLabel2: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didTapped))
        self.view.addGestureRecognizer(tapGR)
        
    }
    
    @objc private func didTapped() {
        delegate?.didTapped()
    }
    
    @IBAction private func buttonDidTapped(_ sender: UIButton) {
        UIView.setAnimationsEnabled(false)
        button.setTitle("\(isExpanded ? "▼" : "▲") メモ", for: .normal)
        button.layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
        isExpanded.toggle()
        buttonDidTapped?()
    }
    
    func configure(section: Section, buttonDidTapped: @escaping () -> Void) {
        self.buttonDidTapped = buttonDidTapped
        label.text = section.title
        timeLabel1.text = "今日: \(section.time.today)分"
        timeLabel2.text = "合計: \(section.time.total)分"
    }
    
}
