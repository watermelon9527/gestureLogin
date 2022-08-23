//
//  ViewController.swift
//  gestureLogin
//
//  Created by nono chan  on 2022/8/20.
//
import AudioToolbox
import UIKit
enum GestureType: Int {
    case unlock = 0
    case setting = 1
    case doubleSetting = 2
}

class GestureViewController: UIViewController {

    @IBOutlet weak var gestureCollectionView: GestureCollectionView!
    private var currentPoint: CGPoint?
    private var gestureType = GestureType.setting
    private var password = [Int]()
    private var selectedPassword = [Int]()
    private var lineLayers = [CAShapeLayer]() {
        didSet {
            print(lineLayers.count)
        }
    }
    private var row = 3
    private let buttonTag = -1
    private let cellID = "cell"
    private var moveLayer: CAShapeLayer?

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
        gestureCollectionView.dataSource = self
        gestureCollectionView.delegate = self
        gestureCollectionView.gestureDelegate = self
        gestureCollectionView.isUserInteractionEnabled = false

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

    private func drawLine(to point: CGPoint) {
        if let currentPoint = currentPoint {
            let shapeLayer = CAShapeLayer()
            shapeLayer.frame = gestureCollectionView.bounds
            shapeLayer.position = gestureCollectionView.center
            shapeLayer.fillColor = nil
            shapeLayer.lineWidth = 3
            shapeLayer.strokeColor = UIColor.green.cgColor
            let path = UIBezierPath()
            path.move(to: currentPoint)
            path.addLine(to: point)
            shapeLayer.path = path.cgPath
            shapeLayer.lineCap = .round
            view.layer.addSublayer(shapeLayer)
            lineLayers.append(shapeLayer)
        }
        currentPoint = point
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        gestureCollectionView.touchesMoved(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        gestureCollectionView.touchesEnded(touches, with: event)
    }

    func showMessageAlert(message: String) {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        let alert = UIAlertController(title: "Gesture Password", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self](_) in
            self?.lineLayers.forEach { (layer) in
                layer.removeFromSuperlayer()
            }
            self?.lineLayers.removeAll()
            self?.selectedPassword.removeAll()
            self?.gestureCollectionView.reloadSections(IndexSet(integer: 0))
            self?.currentPoint = nil
            self?.moveLayer?.removeFromSuperlayer()
            self?.moveLayer = nil
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension GestureViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return row * row
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.tag = indexPath.row
        cell.layer.cornerRadius = cell.bounds.height / 2
        cell.layer.borderColor = !selectedPassword.contains(indexPath.row) ? UIColor.white.cgColor : UIColor.green.cgColor
        cell.layer.borderWidth = 3
        return cell
    }
}

extension GestureViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / CGFloat(row * 2 - 1)
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let width = collectionView.bounds.width / CGFloat(row * 2 - 1)
        return width
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let width = collectionView.bounds.width / CGFloat(row * 2 - 1)
        return width
    }

}

extension GestureViewController:  GestureCollectionViewDelegate {
    func cancel() {
        switch gestureType  {
        case .setting:
            if selectedPassword.count >= 4 {
                password = selectedPassword
                showMessageAlert(message: "Password setting is successful")
            } else {
                showMessageAlert(message: "Password must be greater than 4, please try again")
            }
        case .unlock:
            if selectedPassword == password {
                showMessageAlert(message: "Unlocked successfully")
            } else {
                lineLayers.forEach { (layer) in
                    layer.strokeColor = UIColor.red.cgColor
                }
                gestureCollectionView.visibleCells.forEach { (cell) in
                    cell.layer.borderColor = UIColor.red.cgColor
                }
                moveLayer?.strokeColor = UIColor.red.cgColor
                showMessageAlert(message: "Unlock failed, please try again")
            }
        case .doubleSetting:
            showMessageAlert(message: "Password setting is successful")

        }

    }


    func move(point: CGPoint) {
        if let currentPoint = currentPoint {
            if moveLayer == nil {
                moveLayer = CAShapeLayer()
                view.layer.addSublayer(moveLayer!)
            }
            moveLayer?.frame = gestureCollectionView.bounds
            moveLayer?.position = gestureCollectionView.center
            moveLayer?.fillColor = nil
            moveLayer?.lineWidth = 3
            moveLayer?.strokeColor = UIColor.green.cgColor
            let path = UIBezierPath()
            path.move(to: currentPoint)
            path.addLine(to: point)
            moveLayer?.path = path.cgPath
            moveLayer?.lineCap = .round
        }
    }

    func selectedItem(indexPath: IndexPath) {
        if selectedPassword.contains(indexPath.row) { return }
        let cell = gestureCollectionView.cellForItem(at: indexPath)
        drawLine(to: cell!.center)
        selectedPassword.append(indexPath.row)
        moveLayer?.removeFromSuperlayer()
        moveLayer = nil
        AudioServicesPlaySystemSound(1520)
        gestureCollectionView.reloadItems(at: [indexPath])
    }

}
