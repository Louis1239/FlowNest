//
//  NavigationCustomBarDemoViewController.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit
import FlowNest

enum NavigationCustomBarDemo {
    
    static func makeViewController() -> FlowNestContainerViewController {
        let config = FlowNestConfig()
        config.navigationBarHeight = 92
        config.headerHeight = 220
        config.segmentHeight = 48
        
        let viewController = FlowNestContainerViewController(config: config)
        viewController.title = "自定义导航栏"
        
        let navigationBarView = DemoNavigationBarView(title: "Custom Bar", subtitle: "外部传入自定义导航栏")
        navigationBarView.onBack = { [weak viewController] in
            viewController?.navigationController?.popViewController(animated: true)
        }
        viewController.navigationBarView = navigationBarView
        viewController.headerView = makeHeaderView(title: "Custom Navigation", subtitle: "容器内自定义导航栏 + 默认 Segment")
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
            DemoListViewController(titleText: "推荐", color: UIColor(red: 0.95, green: 0.98, blue: 1.0, alpha: 1.0)),
            DemoListViewController(titleText: "关注", color: UIColor(red: 1.0, green: 0.96, blue: 0.93, alpha: 1.0)),
            DemoListViewController(titleText: "发现", color: UIColor(red: 0.95, green: 1.0, blue: 0.95, alpha: 1.0))
        ]
    }
}
