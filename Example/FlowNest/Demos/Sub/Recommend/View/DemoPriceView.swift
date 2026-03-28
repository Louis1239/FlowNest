//
//  DemoPriceView.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class DemoPriceView: UIView {

    /// 图标
    private let imageView = UIImageView()
    /// 金额
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        // 图标
        self.addSubview(imageView)
        imageView.image = UIImage(named: "coin_icon")
        // 金额
        self.addSubview(priceLabel)
        priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        priceLabel.textColor = UIColor.color("#FFCC33")
        
    }
    
    private func setLayout() {
        // 图标
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        // 金额
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(4.0)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    /// 免费
    func setFree() {
        priceLabel.text = "FREE"
        priceLabel.textColor = UIColor.color("#00B23B")
    }
    
    /// 设置金额
    func setPrice(price: String) {
        priceLabel.text = price
        priceLabel.textColor = UIColor.color("#FFCC33")
    }

}
