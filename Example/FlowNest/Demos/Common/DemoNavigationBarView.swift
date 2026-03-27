//
//  DemoNavigationBarView.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit

final class DemoNavigationBarView: UIView {
    
    var onBack: (() -> Void)? {
        didSet {
            backButton.onTap = onBack
        }
    }
    
    private let backButton = DemoActionButton(type: .custom)
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    init(title: String, subtitle: String) {
        super.init(frame: .zero)
        setupUI(title: title, subtitle: subtitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backButton.frame = CGRect(x: 16, y: max(bounds.height - 44, 0), width: 56, height: 44)
        titleLabel.frame = CGRect(x: 76, y: max(bounds.height - 48, 0), width: bounds.width - 152, height: 24)
        subtitleLabel.frame = CGRect(x: 76, y: max(bounds.height - 24, 0), width: bounds.width - 152, height: 18)
    }
    
    private func setupUI(title: String, subtitle: String) {
        backgroundColor = UIColor(red: 0.12, green: 0.17, blue: 0.24, alpha: 1.0)
        
        backButton.setTitle("返回", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        backButton.contentHorizontalAlignment = .left
        addSubview(backButton)
        
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        addSubview(titleLabel)
        
        subtitleLabel.text = subtitle
        subtitleLabel.textColor = UIColor(white: 1.0, alpha: 0.72)
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        addSubview(subtitleLabel)
    }
}
