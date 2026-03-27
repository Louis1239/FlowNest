//
//  NavigationCustomSegmentDemoViewController.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit
import FlowNest

enum NavigationCustomSegmentDemo {
    
    static func makeViewController() -> FlowNestContainerViewController {
        let config = FlowNestConfig()
        config.navigationBarHeight = 88
        config.navigationBarTitle = "Custom Segment"
        config.headerHeight = 220
        config.segmentHeight = 52
        
        let viewController = FlowNestContainerViewController(config: config)
        viewController.title = "有导航栏 + 自定义 Segment"
        viewController.view.backgroundColor = .white
        viewController.segmentView = DemoCustomSegmentView()
        viewController.headerView = makeHeaderView(title: "Custom Segment", subtitle: "容器内导航栏 + 外部自定义 Segment")
        viewController.setViewControllers(makeDemoPages())
        return viewController
    }
    
    private static func makeHeaderView(title: String, subtitle: String) -> UIView {
        let header = UIView()
        header.backgroundColor = UIColor(red: 0.12, green: 0.17, blue: 0.24, alpha: 1.0)
        
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 72, width: 280, height: 34))
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        header.addSubview(titleLabel)
        
        let subtitleLabel = UILabel(frame: CGRect(x: 20, y: 112, width: 320, height: 22))
        subtitleLabel.text = subtitle
        subtitleLabel.textColor = UIColor(white: 1.0, alpha: 0.72)
        subtitleLabel.font = UIFont.systemFont(ofSize: 15)
        header.addSubview(subtitleLabel)
        
        return header
    }
    
    private static func makeDemoPages() -> [UIViewController] {
        [
            DemoListViewController(titleText: "热门", color: UIColor(red: 1.0, green: 0.97, blue: 0.93, alpha: 1.0)),
            DemoListViewController(titleText: "最新", color: UIColor(red: 0.94, green: 0.99, blue: 1.0, alpha: 1.0)),
            DemoListViewController(titleText: "收藏", color: UIColor(red: 0.95, green: 1.0, blue: 0.95, alpha: 1.0))
        ]
    }
}
