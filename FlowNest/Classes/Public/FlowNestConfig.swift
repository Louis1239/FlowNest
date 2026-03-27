//
//  FlowNestConfig.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit

public class FlowNestConfig: NSObject {
    
    /// 容器内导航栏高度，0 表示不显示
    public var navigationBarHeight: CGFloat = 0
    
    /// 默认导航栏标题
    public var navigationBarTitle: String?
    
    /// 默认导航栏是否显示返回按钮
    public var showsNavigationBarBackButton: Bool = true
    
    /// 默认导航栏返回按钮标题
    public var navigationBarBackButtonTitle: String = "返回"
    
    /// 默认导航栏背景色
    public var navigationBarBackgroundColor: UIColor = .white
    
    /// 默认导航栏标题颜色
    public var navigationBarTitleColor: UIColor = .black
    
    /// 默认导航栏标题字体
    public var navigationBarTitleFont: UIFont = .boldSystemFont(ofSize: 17)

    /// 顶部头视图高度
    public var headerHeight: CGFloat = 0
    
    /// 顶部 segment 高度
    public var segmentHeight: CGFloat = 44
    
    /// 父 scrollView 与子 scrollView 的切换阈值
    /// 默认为 0 时，会退回使用 headerHeight
    public var maxOffset: CGFloat = 0
    
    func resolvedMaxOffset() -> CGFloat {
        maxOffset > 0 ? maxOffset : headerHeight
    }
    
}
