//
//  ViewController.swift
//  gestureLogin
//
//  Created by nono chan  on 2022/8/20.
//

import UIKit

class ViewController: UIViewController {
    
    let settingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Go to Unlock", for: .normal)
        button.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 35)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let lockButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Go to Lock", for: .normal)
        button.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 35)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.addSubview(settingButton)
        self.view.addSubview(lockButton)
        
        NSLayoutConstraint.activate([
            settingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            settingButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            settingButton.widthAnchor.constraint(equalToConstant: 300),
            settingButton.heightAnchor.constraint(equalToConstant: 300),
            
            lockButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lockButton.topAnchor.constraint(equalTo: settingButton.bottomAnchor, constant: 30),
            lockButton.widthAnchor.constraint(equalToConstant: 300),
            lockButton.heightAnchor.constraint(equalToConstant: 300),
            
        ])
        
    }

}

