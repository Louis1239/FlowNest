//
//  FlowNestScrollProxy.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit

final class FlowNestScrollProxy: NSObject, UIScrollViewDelegate {
    
    weak var coordinator: FlowNestScrollCoordinator?
    
    /// 原本业务的 delegate（不能丢）
    weak var originalDelegate: UIScrollViewDelegate?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        coordinator?.handleChildScroll(scrollView)
        originalDelegate?.scrollViewDidScroll?(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        originalDelegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        originalDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    override func responds(to aSelector: Selector!) -> Bool {
        super.responds(to: aSelector) || (originalDelegate?.responds(to: aSelector) ?? false)
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if originalDelegate?.responds(to: aSelector) == true {
            return originalDelegate
        }
        
        return super.forwardingTarget(for: aSelector)
    }
}
