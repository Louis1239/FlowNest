//
//  FlowNestNavigationView.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit

/// Default navigation bar used by FlowNest when no custom navigationBarView is provided.
final class FlowNestNavigationView: UIView {
    
    var onBack: (() -> Void)?
    
    private let titleLabel = UILabel()
    private let backButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contentHeight = min(44, bounds.height)
        let contentY = max(bounds.height - contentHeight, 0)
        
        backButton.frame = CGRect(x: 16, y: contentY, width: 64, height: contentHeight)
        titleLabel.frame = CGRect(x: 72, y: contentY, width: max(bounds.width - 144, 0), height: contentHeight)
    }
    
    func apply(config: FlowNestConfig, showsBackButton: Bool) {
        backgroundColor = config.navigationBarBackgroundColor
        titleLabel.text = config.navigationBarTitle
        titleLabel.textColor = config.navigationBarTitleColor
        titleLabel.font = config.navigationBarTitleFont
        
        backButton.setTitle(config.navigationBarBackButtonTitle, for: .normal)
        backButton.setTitleColor(config.navigationBarTitleColor, for: .normal)
        backButton.isHidden = !(config.showsNavigationBarBackButton && showsBackButton)
        if #available(iOS 13.0, *) {
            backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        backButton.tintColor = config.navigationBarTitleColor
    }
    
    private func setupUI() {
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        backButton.contentHorizontalAlignment = .left
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        backButton.addTarget(self, action: #selector(handleBackTap), for: .touchUpInside)
        addSubview(backButton)
    }
    
    @objc private func handleBackTap() {
        onBack?()
    }
}
