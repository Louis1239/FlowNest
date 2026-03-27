//
//  FlowNestScrollCoordinator.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit

class FlowNestScrollCoordinator: NSObject {
    private let offsetTolerance: CGFloat = 0.5
    
    /// 当前滚动归属
    var owner: FlowNestScrollOwner = .parent
    /// 最大偏移
    private(set) var maxOffset: CGFloat = 0
    /// 父图层 scrollView
    private(set) weak var parentScrollView: UIScrollView?
    /// 当前子 scrollView（关键！）
    private(set)  weak var currentChildScrollView: UIScrollView?
    
    
    /// 设置最大偏移
    func setMaxOffset(_ offset: CGFloat) {
        maxOffset = offset
    }
    
    /// 设置父图层ScrollView
    func setParentScrollView(_ scrollView: UIScrollView) {
        parentScrollView = scrollView
    }
    
    /// 设置当前子 scrollView
    func setCurrentChildScrollView(_ scrollView: UIScrollView) {
        currentChildScrollView = scrollView
    }
    
    //MARK: 处理父ScrollView滚动
    func handleParentScroll(_ scrollView: UIScrollView) {
        guard let _ = currentChildScrollView else { return }
        
        let offset = scrollView.contentOffset.y
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView)
        let reachedMaxOffset = offset >= maxOffset - offsetTolerance
        
        if owner == .parent {
            // 到顶后优先切给子，避免减速阶段 velocity 归零导致卡住
            if reachedMaxOffset && (velocity.y < 0 || scrollView.isDecelerating || !scrollView.isDragging) {
                scrollView.contentOffset.y = maxOffset
                owner = .child
            }
        } else {
            // 子在滚，父锁住
            scrollView.contentOffset.y = maxOffset
        }
    }
    
    //MARK: 处理子scrollView滚动
    func handleChildScroll(_ scrollView: UIScrollView) {
        guard let parent = parentScrollView else { return }
        
        let offset = scrollView.contentOffset.y
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView)
        let reachedTop = offset <= offsetTolerance
        
        if owner == .child {
            // 到顶后优先切给父，避免减速阶段 velocity 归零导致卡住
            if reachedTop && (velocity.y > 0 || scrollView.isDecelerating || !scrollView.isDragging) {
                scrollView.contentOffset.y = 0
                owner = .parent
            }
            
            // 惯性修正
            if scrollView.isDecelerating && reachedTop {
                scrollView.contentOffset.y = 0
            }
            
        } else {
            let parentOffset = parent.contentOffset.y
            let parentReachedMaxOffset = parentOffset >= maxOffset - offsetTolerance
            
            // 🔥 兜底切换（非常关键）
            if parentReachedMaxOffset && (velocity.y < 0 || parent.isDecelerating || !parent.isDragging) {
                owner = .child
                return
            }
            
            // 父还持有控制权时，子列表必须固定在顶部，不能跟着父一起下拉
            if abs(scrollView.contentOffset.y) > offsetTolerance || parentOffset > offsetTolerance {
                scrollView.contentOffset.y = 0
            }
        }
    }
    
    //MARK: 切换子
    func didSwitchPage(to newChild: UIScrollView?) {
        guard let newChild = newChild else { return }
        
        currentChildScrollView = newChild
        
        let parentOffset = parentScrollView?.contentOffset.y ?? 0
        
        if parentOffset < maxOffset {
            newChild.contentOffset = .zero
            owner = .parent
        } else {
            owner = .child
        }
    }
    
}
