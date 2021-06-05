//
//  ViewController.swift
//  accordionTableView
//
//  Created by 大西玲音 on 2021/06/05.
//

import UIKit

struct Section {
    var title: String
    var values: [String]
    var expanded: Bool
}

final class AccordionViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var sections: [Section] = [Section(title: "Apple",
                                               values: ["mac book",
                                                        "iPhone 12"],
                                               expanded: false),
                                       Section(title: "Microsoft",
                                               values: ["Windows",
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
        tableView.register(SectionHeaderView.nib,
                           forHeaderFooterViewReuseIdentifier: SectionHeaderView.identifier)
        tableView.tableFooterView = UIView()
        
    }
    
    
}

extension AccordionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].expanded ? 100 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.identifier) as! SectionHeaderView
        headerView.configure(title: sections[section].title, section: section) { [weak self] section in
            guard let self = self else { return }
            self.sections[section].expanded.toggle()
            self.tableView.beginUpdates()
            self.sections[section].values.enumerated().forEach { i, title in
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
        return sections[section].values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                 for: indexPath) as! CustomTableViewCell
        let title = sections[indexPath.section].values[indexPath.row]
        cell.configure(title: title)
        return cell
    }
    
}
