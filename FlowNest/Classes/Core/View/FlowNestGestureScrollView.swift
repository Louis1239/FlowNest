//
//  FlowNestGestureScrollView.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit

final class FlowNestGestureScrollView: UIScrollView, UIGestureRecognizerDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        panGestureRecognizer.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        panGestureRecognizer.delegate = self
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer is UIPanGestureRecognizer || gestureRecognizer is UIRotationGestureRecognizer else {
            return false
        }
        
        if let scrollView = otherGestureRecognizer.view as? UIScrollView,
           scrollView.contentSize.width > scrollView.bounds.width {
            return false
        }
        
        return true
    }
}
