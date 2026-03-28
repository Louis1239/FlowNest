//
//  DemoHeaderView.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit

class DemoHeaderView: UIView {

    /// 渐变
    private let gradientLayer = CAGradientLayer()
    /// 标题
    private let titleLabel = UILabel()
    /// 副标题
    private let subtitleLabel = UILabel()
    /// 返回按钮
    private let backButton = UIButton()
    /// 返回回调
    var onBack: (() -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    
    private func setupView() {
        // 渐变
        gradientLayer.colors = [
            UIColor(red: 0.12, green: 0.17, blue: 0.24, alpha: 1.0).cgColor,
            UIColor(red: 0.95, green: 0.98, blue: 1.0, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
        // 标题
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        // 副标题
        subtitleLabel.textColor = UIColor(white: 1.0, alpha: 0.72)
        subtitleLabel.font = UIFont.systemFont(ofSize: 15)
        subtitleLabel.textAlignment = .center
        addSubview(subtitleLabel)
        // 返回按钮
        backButton.setTitle("返回", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        backButton.contentHorizontalAlignment = .left
        addSubview(backButton)
        backButton.addTarget(self, action: #selector(onBackAction), for: .touchUpInside)
    }
    
    @objc private func onBackAction() {
        onBack?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        titleLabel.frame = CGRect(x: 0, y: 72, width: bounds.size.width, height: 34)
        subtitleLabel.frame = CGRect(x: 0, y: 112, width: bounds.size.width, height: 22)
        backButton.frame = CGRect(x: 20, y: 40, width: 56, height: 32)
    }
    
    /// 渲染标题 副标题-按钮隐藏
    func render(title: String, subtitle: String,hiddenBack:Bool) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        backButton.isHidden = hiddenBack
    }

}
