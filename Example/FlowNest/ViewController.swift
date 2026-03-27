//
//  ViewController.swift
//  FlowNest
//
//  Created by Louis on 03/27/2026.
//  Copyright (c) 2026 Louis. All rights reserved.
//

import UIKit

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
        
        stackView.addArrangedSubview(makeButton(title: "1. 无导航栏 + 默认 Segment", action: #selector(showNoNavigationDemo)))
        stackView.addArrangedSubview(makeButton(title: "2. 有导航栏 + 默认 Segment", action: #selector(showNavigationDefaultDemo)))
        stackView.addArrangedSubview(makeButton(title: "3. 有导航栏 + 自定义 Segment", action: #selector(showNavigationCustomDemo)))
        stackView.addArrangedSubview(makeButton(title: "4. 自定义导航栏 + 默认 Segment", action: #selector(showCustomNavigationBarDemo)))
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
    
    @objc private func showNoNavigationDemo() {
        navigationController?.pushViewController(NoNavigationDefaultSegmentDemo.makeViewController(), animated: true)
    }
    
    @objc private func showNavigationDefaultDemo() {
        navigationController?.pushViewController(NavigationDefaultSegmentDemo.makeViewController(), animated: true)
    }
    
    @objc private func showNavigationCustomDemo() {
        navigationController?.pushViewController(NavigationCustomSegmentDemo.makeViewController(), animated: true)
    }
    
    @objc private func showCustomNavigationBarDemo() {
        navigationController?.pushViewController(NavigationCustomBarDemo.makeViewController(), animated: true)
    }
}
