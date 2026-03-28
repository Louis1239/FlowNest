//
//  DemoRecommendCell.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

final class DemoRecommendCell: UITableViewCell {
    /// 背景
    private let backView = UIView()
    /// 头像
    private let avatarImageView = UIImageView()
    /// 用户昵称
    private let nameLabel = UILabel()
    /// 标题
    private let titleLabel = UILabel()
    /// 内容
    private let contentLabel = UILabel()
    /// 发布时间
    private let publishTimeLabel = UILabel()
    /// 价格
    private let priceView = DemoPriceView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        // 背景
        contentView.addSubview(backView)
        backView.backgroundColor = UIColor.color("#1C1D1F")
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 8.0
        //头像
        backView.addSubview(avatarImageView)
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 16
        avatarImageView.contentMode = .scaleAspectFill
        // 昵称
        backView.addSubview(nameLabel)
        nameLabel.textColor = UIColor.color("#E1E2E5")
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        // 标题
        backView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 2
        // 内容
        backView.addSubview(contentLabel)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.color("#B9BBBF")
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
       
        // 发布时间
        backView.addSubview(publishTimeLabel)
        publishTimeLabel.textColor = UIColor.color("#7D7E80")
        publishTimeLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        // 价格
        backView.addSubview(priceView)
    }
    
    private func setLayout() {
        // 背景
        backView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview()
        }
        // 头像
        avatarImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(12)
            make.height.width.equalTo(32)
        }
        // 昵称
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.centerY.equalTo(avatarImageView)
            make.trailing.equalToSuperview().offset(-12)
        }
        // 标题
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(avatarImageView.snp.bottom).offset(10.0)
        }
        // 内容
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
        }
        // 发布时间
        publishTimeLabel.snp.makeConstraints { make in
            make.height.equalTo(12)
            make.leading.equalTo(contentLabel)
            make.top.equalTo(contentLabel.snp.bottom).offset(8.0)
            make.bottom.equalToSuperview().offset(-8)
        }
        // 金币
        priceView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalTo(publishTimeLabel)
        }
    }
    
    func render(model:DemoRecommendItem) {
        avatarImageView.image = UIImage(named: model.avatarImageName)
        nameLabel.text = model.name
        titleLabel.text = model.title
        contentLabel.text = model.content
        publishTimeLabel.text = model.publishTime

        if model.coin <= 0 {
            priceView.setFree()
        } else {
            priceView.setPrice(price: "\(model.coin)")
        }
    }

}
