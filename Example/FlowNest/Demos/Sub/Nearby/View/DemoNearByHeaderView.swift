//
//  DemoNearByHeaderView.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

final class DemoNearByHeaderView: UIView {
    private let cardView = UIView()
    private let glowView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let primaryAvatarImageView = UIImageView()
    private var avatarImageViews: [UIImageView] = []
    private var didAddAnimations = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard window != nil, !didAddAnimations else { return }
        didAddAnimations = true
        addAvatarAnimations()
    }

    private func setupView() {
        backgroundColor = .clear

        addSubview(cardView)
        cardView.backgroundColor = UIColor.color("#1A1B1F")
        cardView.layer.cornerRadius = 18
        cardView.layer.masksToBounds = true

        cardView.addSubview(glowView)
        glowView.backgroundColor = UIColor.color("#FF5C8A", alpha: 0.18)
        glowView.layer.cornerRadius = 40

        cardView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.text = "附近有 128 位新朋友"

        cardView.addSubview(subtitleLabel)
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        subtitleLabel.textColor = UIColor.color("#A9ABB2")
        subtitleLabel.numberOfLines = 2
        subtitleLabel.text = "主动打个招呼，今晚可能就会收到回应。"

        cardView.addSubview(primaryAvatarImageView)
        primaryAvatarImageView.image = UIImage(named: "header_01")
        primaryAvatarImageView.layer.cornerRadius = 28
        primaryAvatarImageView.layer.masksToBounds = true
        primaryAvatarImageView.layer.borderWidth = 2
        primaryAvatarImageView.layer.borderColor = UIColor.color("#FF5C8A").cgColor
        primaryAvatarImageView.contentMode = .scaleAspectFill

        let avatarNames = ["header_02", "header_03", "header_04", "header_05", "header_06"]
        avatarNames.forEach { name in
            let imageView = UIImageView(image: UIImage(named: name))
            imageView.layer.cornerRadius = 16
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 1.5
            imageView.layer.borderColor = UIColor.color("#2B2C31").cgColor
            imageView.contentMode = .scaleAspectFill
            cardView.addSubview(imageView)
            avatarImageViews.append(imageView)
        }
    }

    private func setLayout() {
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 12, bottom: 12, right: 12))
            make.height.equalTo(100)
        }

        glowView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.left.equalToSuperview().offset(-18)
            make.centerY.equalToSuperview()
        }

        primaryAvatarImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(56)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.left.equalTo(primaryAvatarImageView.snp.right).offset(14)
            make.right.lessThanOrEqualTo(avatarImageViews[0].snp.left).offset(-10)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.right.lessThanOrEqualTo(avatarImageViews[0].snp.left).offset(-10)
        }

        let topOffsets: [CGFloat] = [18, 10, 26, 14, 32]
        let trailingOffsets: [CGFloat] = [96, 74, 52, 30, 8]

        for (index, imageView) in avatarImageViews.enumerated() {
            imageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(topOffsets[index])
                make.right.equalToSuperview().inset(trailingOffsets[index])
                make.width.height.equalTo(32)
            }
        }
    }

    private func addAvatarAnimations() {
        for (index, imageView) in avatarImageViews.enumerated() {
            let moveAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
            moveAnimation.values = [0, -4 - CGFloat(index % 2), 0, 3]
            moveAnimation.duration = 2.2 + Double(index) * 0.18
            moveAnimation.repeatCount = .infinity
            moveAnimation.isRemovedOnCompletion = false
            moveAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            imageView.layer.add(moveAnimation, forKey: "float")
        }

        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.05
        pulseAnimation.duration = 1.8
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        pulseAnimation.isRemovedOnCompletion = false
        primaryAvatarImageView.layer.add(pulseAnimation, forKey: "pulse")
    }
}
