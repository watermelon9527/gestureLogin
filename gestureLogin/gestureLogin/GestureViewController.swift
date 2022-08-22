//
//  ViewController.swift
//  gestureLogin
//
//  Created by nono chan  on 2022/8/20.
//

import UIKit
enum gestureType {
    case unclock
    case setting
    case doubleSetting
}

class GestureViewController: UIViewController {


    @IBOutlet weak var gestureCollectionView: UICollectionView!


    let gestureTitleLabel: UILabel =
    {
        let label = UILabel()
        label.text = "手勢登入"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let gestureDescriptionLabel: UILabel =
    {
        let lable = UILabel()
        lable.text = "請畫出4-9圖形密碼"
        lable.textColor = .gray
        lable.translatesAutoresizingMaskIntoConstraints = false

        return lable
    }()

    let unlockAlertLabel: UILabel =
    {
        let label = UILabel()
        label.text = "解鎖錯誤超過三次將會退出"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ewqasd")
    }


    func setUpView() {
        self.view.addSubview(gestureTitleLabel)
        self.view.addSubview(gestureDescriptionLabel)
        self.view.addSubview(unlockAlertLabel)
        NSLayoutConstraint.activate([
            gestureTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: -10),
            gestureTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            gestureTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),

            gestureDescriptionLabel.topAnchor.constraint(equalTo: gestureTitleLabel.bottomAnchor, constant: -10),
            gestureDescriptionLabel.leadingAnchor.constraint(equalTo: gestureTitleLabel.leadingAnchor),
            gestureDescriptionLabel.trailingAnchor.constraint(equalTo: gestureTitleLabel.trailingAnchor),

            unlockAlertLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            unlockAlertLabel.leadingAnchor.constraint(equalTo: gestureTitleLabel.leadingAnchor),
            unlockAlertLabel.trailingAnchor.constraint(equalTo: gestureTitleLabel.trailingAnchor)

        ])
    }


}

