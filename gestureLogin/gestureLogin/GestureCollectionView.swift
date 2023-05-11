//
//  GestureCollectionView.swift
//  GestureLogin
//
//  Created by chijung chan  on 2023/5/11.
//

import UIKit

protocol GestureCollectionViewDelegate: AnyObject {
    func move(point: CGPoint)
    func selectedItem(indexPath: IndexPath)
    func cancel()
}

class GestureCollectionView: UICollectionView {
    weak var gestureDelegate: GestureCollectionViewDelegate?
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first?.location(in: self) {
            if let indexPath = self.indexPathForItem(at: point) {
                gestureDelegate?.selectedItem(indexPath: indexPath)
            } else {
                gestureDelegate?.move(point: point)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        gestureDelegate?.cancel()
    }
    
    
}
