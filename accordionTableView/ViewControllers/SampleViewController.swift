//
//  SampleViewController.swift
//  accordionTableView
//
//  Created by 大西玲音 on 2021/06/05.
//

import UIKit

final class SampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    static func instaintiate() -> SampleViewController {
        let vc = UIStoryboard(name: "Sample", bundle: nil).instantiateViewController(identifier: String(describing: self)) as! SampleViewController
        return vc
    }
    
}
