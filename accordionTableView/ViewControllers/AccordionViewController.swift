//
//  ViewController.swift
//  accordionTableView
//
//  Created by 大西玲音 on 2021/06/05.
//

import UIKit

private struct Section {
    var title: String
    var titles: [String]
    var expanded: Bool
}

final private class SectionHeaderView: UITableViewHeaderFooterView {
    
    var onTapEvent: ((Int) -> Void)?
    var section: Int?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didTapped))
        self.addGestureRecognizer(tapGR)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

final class AccordionViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var sections: [Section] = [Section(title: "Apple",
                                               titles: ["mac book",
                                                        "iPhone 12",
                                                        "apple watch"],
                                               expanded: false),
                                       Section(title: "Microsoft",
                                               titles: ["Windows",
                                                        "Office",
                                                        "Surface"],
                                               expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.nib,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        
    }
    
    
}

extension AccordionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].expanded ? 50 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SectionHeaderView()
        headerView.configure(title: sections[section].title, section: section) { [weak self] section in
            guard let self = self else { return }
            self.sections[section].expanded.toggle()
            self.tableView.beginUpdates()
            self.sections[section].titles.enumerated().forEach { i, title in
                self.tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
            }
            self.tableView.endUpdates()
        }
        return headerView
    }
    
}

extension AccordionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                 for: indexPath) as! CustomTableViewCell
        let title = sections[indexPath.section].titles[indexPath.row]
        cell.configure(title: title)
        return cell
    }
    
}
