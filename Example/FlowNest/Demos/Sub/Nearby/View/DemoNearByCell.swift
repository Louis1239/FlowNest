//
//  DemoNearByCell.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

final class DemoNearByCell: UITableViewCell {
    private let cardView = UIView()
    private let avatarImageView = UIImageView()
    private let nicknameLabel = UILabel()
    private let distanceLabel = UILabel()
    private let summaryLabel = UILabel()
    private let greetButton = UIButton(type: .custom)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(cardView)
        cardView.backgroundColor = UIColor.color("#1A1B1F")
        cardView.layer.cornerRadius = 14
        cardView.layer.masksToBounds = true

        cardView.addSubview(avatarImageView)
        avatarImageView.layer.cornerRadius = 24
        avatarImageView.layer.masksToBounds = true
        avatarImageView.contentMode = .scaleAspectFill

        cardView.addSubview(nicknameLabel)
        nicknameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nicknameLabel.textColor = UIColor.color("#F3F4F6")

        cardView.addSubview(distanceLabel)
        distanceLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        distanceLabel.textColor = UIColor.color("#FF8AAE")

        cardView.addSubview(summaryLabel)
        summaryLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        summaryLabel.textColor = UIColor.color("#A9ABB2")
        summaryLabel.numberOfLines = 2

        cardView.addSubview(greetButton)
        greetButton.setTitle("打招呼", for: .normal)
        greetButton.setTitleColor(.white, for: .normal)
        greetButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        greetButton.backgroundColor = UIColor.color("#FF5C8A")
        greetButton.layer.cornerRadius = 16
        greetButton.layer.masksToBounds = true
    }

    private func setLayout() {
        cardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }

        avatarImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(14)
            make.width.height.equalTo(48)
        }

        greetButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.centerY.equalTo(avatarImageView)
            make.width.equalTo(76)
            make.height.equalTo(32)
        }

        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView).offset(1)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.right.lessThanOrEqualTo(greetButton.snp.left).offset(-8)
        }

        distanceLabel.snp.makeConstraints { make in
            make.left.equalTo(nicknameLabel)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(5)
            make.right.lessThanOrEqualTo(greetButton.snp.left).offset(-8)
        }

        summaryLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().inset(12)
            make.top.equalTo(avatarImageView.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(14)
        }
    }

    func render(_ item: DemoNearByItem) {
        avatarImageView.image = UIImage(named: item.avatarImageName)
        nicknameLabel.text = item.nickname
        distanceLabel.text = item.distanceText
        summaryLabel.text = item.summary
    }
}
