//
//  FlowNestChildProtocol.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit

public protocol FlowNestChildProtocol: AnyObject {
    
    /// 子控制器内部用于滚动联动的 scrollView
    var nestedScrollView: UIScrollView { get }
    
}

public protocol FlowNestRefreshableChildProtocol: AnyObject {
    
    /// 父容器下拉刷新后，将刷新事件透传给当前子列表
    func flowNestHandleRefresh(completion: @escaping () -> Void)
    
}
