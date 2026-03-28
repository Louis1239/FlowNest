//
//  ViewController.swift
//  FlowNest
//
//  Created by Louis on 03/27/2026.
//  Copyright (c) 2026 Louis. All rights reserved.
//

import UIKit
import FlowNest

final class ViewController: UIViewController {
    
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "FlowNest Examples"
        view.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.99, alpha: 1.0)
        setupButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let horizontalInset: CGFloat = 20
        let buttonHeight: CGFloat = 72
        let spacing: CGFloat = 14
        let width = view.bounds.width - horizontalInset * 2
        let totalHeight = buttonHeight * 4 + spacing * 3
        stackView.frame = CGRect(
            x: horizontalInset,
            y: (view.bounds.height - totalHeight) / 2,
            width: width,
            height: totalHeight
        )
    }
    
    private func setupButtons() {
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.addArrangedSubview(makeButton(title: "1. 有导航栏 + 默认 Segment", action: #selector(showNavigationDefaultDemo)))
        stackView.addArrangedSubview(makeButton(title: "2. 有导航栏 + 自定义 Segment", action: #selector(showNavigationCustomDemo)))
        stackView.addArrangedSubview(makeButton(title: "3. 自定义导航栏 + 默认 Segment", action: #selector(showCustomNavigationBarDemo)))
    }
    
    private func makeButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.12, green: 0.17, blue: 0.24, alpha: 1.0)
        button.layer.cornerRadius = 16
        button.contentHorizontalAlignment = .center
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    
    //MARK: 默认导航+默认segment
    @objc private func showNavigationDefaultDemo() {
        let config = FlowNestConfig()
        config.navigationBarHeight = 88
        config.navigationBarTitle = "FlowNest"
        config.headerHeight = 220
        config.segmentHeight = 48
        
        let viewController = FlowNestContainerViewController(config: config)
        viewController.title = "有导航栏 + 默认 Segment"
        viewController.view.backgroundColor = .white
        let headerView = DemoHeaderView()
        headerView.render(title: "Default Segment", subtitle: "容器内导航栏 + 默认 Segment", hiddenBack: true)
        viewController.headerView = headerView
        viewController.setViewControllers(childList)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //MARK: 默认导航+自定义segment
    @objc private func showNavigationCustomDemo() {
        let config = FlowNestConfig()
        config.navigationBarHeight = 88
        config.navigationBarTitle = "Custom Segment"
        config.headerHeight = 220
        config.segmentHeight = 52
        
        let viewController = FlowNestContainerViewController(config: config)
        viewController.title = "有导航栏 + 自定义 Segment"
        viewController.view.backgroundColor = .white
        viewController.segmentView = DemoCustomSegmentView()
        let headerView = DemoHeaderView()
        headerView.render(title: "Custom Segment", subtitle: "容器内导航栏 + 外部自定义 Segment", hiddenBack: true)
        viewController.headerView = headerView
        viewController.setViewControllers(childList)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //MARK: 自定义导航+默认segment
    @objc private func showCustomNavigationBarDemo() {
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
        let headerView = DemoHeaderView()
        headerView.render(title: "Custom Navigation", subtitle: "容器内自定义导航栏 + 默认 Segment", hiddenBack: true)
        viewController.headerView = headerView
        viewController.setViewControllers(childList)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    /// 构建子列表
    private var childList: [UIViewController] {
        var subList: [UIViewController] = []
        //1.推荐
        let recommendViewController = DemoRecommendViewController()
        recommendViewController.title = "推荐"
        subList.append(recommendViewController)
        //2.直播
        let liveViewController = DemoLiveViewController()
        liveViewController.title = "直播"
        subList.append(liveViewController)
        //3.附近
        let nearbyViewController = DemoNearbyViewController()
        nearbyViewController.title = "附近"
        subList.append(nearbyViewController)
        return subList
        
    }
}
