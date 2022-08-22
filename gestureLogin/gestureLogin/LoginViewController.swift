//
//  LoginViewController.swift
//  gestureLogin
//
//  Created by nono chan  on 2022/8/22.
//

import Foundation
import UIKit
class LoginViewContoller: UIViewController {

    let gestureButton: UIButton =
    {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("GestureLogin", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(popUpGestureViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ewqasd")
        setUpView()
    }

    func setUpView() {
        view.addSubview(gestureButton)

        NSLayoutConstraint.activate([
            gestureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gestureButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gestureButton.widthAnchor.constraint(equalToConstant: 400)


        ])
    }

    @objc func popUpGestureViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GestureViewController")

        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.large()]
        }
        self.present(viewController, animated: true)
    }




}
