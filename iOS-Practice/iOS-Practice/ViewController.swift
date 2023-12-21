//
//  ViewController.swift
//  iOS-Practice
//
//  Created by 신지원 on 12/21/23.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {

    private var myView = UIView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        myView.do {
            $0.backgroundColor = .systemPink
        }
    }
    
    private func setLayout() {
        self.view.addSubview(myView)
        
        myView.snp.makeConstraints() {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(200)
        }
    }


}

