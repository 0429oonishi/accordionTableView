//
//  ViewController.swift
//  accordionTableView
//
//  Created by 大西玲音 on 2021/06/05.
//

import UIKit


final class AccordionViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var sections = Section.data
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.nib,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.register(SectionHeaderView.nib,
                           forHeaderFooterViewReuseIdentifier: SectionHeaderView.identifier)
        tableView.tableFooterView = UIView()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    
}

extension AccordionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].expanded ? tableView.rowHeight : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.identifier) as! SectionHeaderView
        let mySection = sections[section]
        headerView.configure(section: mySection) { [weak self] in
            guard let self = self else { return }
            self.sections[section].expanded.toggle()
            self.tableView.beginUpdates()
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: section)],
                                      with: .automatic)
            self.tableView.endUpdates()
        }
        headerView.delegate = self
        return headerView
    }
    
}

extension AccordionViewController: SectionHeaderViewDelegate { }

extension AccordionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                 for: indexPath) as! CustomTableViewCell
        let section = sections[indexPath.section]
        cell.configure(section: section)
        cell.didChanged = {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        return cell
    }
    
}
