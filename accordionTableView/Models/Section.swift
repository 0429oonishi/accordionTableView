//
//  Section.swift
//  accordionTableView
//
//  Created by 大西玲音 on 2021/06/05.
//

import Foundation

struct Section {
    var title: String
    var time: Time
    var text: String
    var expanded: Bool
    static let data: [Section] = [Section(title: "Apple",
                                       time: Time(today: 100, total: 300),
                                       text: "aaa",
                                       expanded: false),
                               Section(title: "Microsoft",
                                       time: Time(today: 200, total: 400),
                                       text: "bbb",
                                       expanded: false),
    ]
}

struct Time {
    var today: Int
    var total: Int
}
