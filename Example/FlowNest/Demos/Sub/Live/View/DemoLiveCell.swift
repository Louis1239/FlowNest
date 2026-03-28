//
//  DemoLiveCell.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

final class DemoLiveCell: UICollectionViewCell {

    /// 背景
    private let bgView = UIView()
    /// 图片
    private let imageView = UIImageView()
    /// 渐变遮罩
    private let gradientOverlayView = UIView()
    private let gradientLayer = CAGradientLayer()
    /// 标题
    private let titleLabel = UILabel()
    /// 直播状态
    private let liveBadgeView = UIView()
    private let livingView = DemoLivingView()
    private let livingLabel = UILabel()
    /// 分类标签
    private let categoryLabel = UILabel()
    /// 底部信息
    private let infoContainerView = UIView()
    private let anchorNameLabel = UILabel()
    private let audienceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientOverlayView.bounds
    }

    private func setupView() {
        contentView.backgroundColor = .clear

        contentView.addSubview(bgView)
        bgView.backgroundColor = UIColor.color("#1A1B1F")
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = true

        bgView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        bgView.addSubview(gradientOverlayView)
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.08).cgColor,
            UIColor.black.withAlphaComponent(0.72).cgColor
        ]
        gradientLayer.locations = [0.0, 0.55, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientOverlayView.layer.addSublayer(gradientLayer)

        bgView.addSubview(liveBadgeView)
        liveBadgeView.backgroundColor = UIColor.color("#FF4D6D")
        liveBadgeView.layer.cornerRadius = 10
        liveBadgeView.layer.masksToBounds = true

        livingView.tintColor = .white
        liveBadgeView.addSubview(livingView)

        livingLabel.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        livingLabel.textColor = .white
        livingLabel.text = "LIVE"
        liveBadgeView.addSubview(livingLabel)

        categoryLabel.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        categoryLabel.textColor = .white
        categoryLabel.backgroundColor = UIColor.black.withAlphaComponent(0.28)
        categoryLabel.layer.cornerRadius = 10
        categoryLabel.layer.masksToBounds = true
        categoryLabel.textAlignment = .center
        bgView.addSubview(categoryLabel)

        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        bgView.addSubview(titleLabel)

        bgView.addSubview(infoContainerView)
        infoContainerView.backgroundColor = UIColor.color("#1A1B1F")

        anchorNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        anchorNameLabel.textColor = UIColor.color("#E4E6EB")
        infoContainerView.addSubview(anchorNameLabel)

        audienceLabel.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        audienceLabel.textColor = UIColor.color("#7D7E80")
        infoContainerView.addSubview(audienceLabel)
    }

    private func setLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(bgView.snp.width).multipliedBy(1.18)
        }

        gradientOverlayView.snp.makeConstraints { make in
            make.edges.equalTo(imageView)
        }

        liveBadgeView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }

        livingView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(10)
            make.height.equalTo(10)
        }

        livingLabel.snp.makeConstraints { make in
            make.left.equalTo(livingView.snp.right).offset(4)
            make.right.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }

        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(imageView.snp.bottom).inset(10)
        }

        infoContainerView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        anchorNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(10)
        }

        audienceLabel.snp.makeConstraints { make in
            make.top.equalTo(anchorNameLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }

    /// 渲染直播间数据
    func render(_ item: DemoLiveItem) {
        imageView.image = UIImage(named: item.coverImageName)
        titleLabel.text = item.title
        categoryLabel.text = "  \(item.category)  "
        anchorNameLabel.text = item.anchorName
        audienceLabel.text = item.audienceText
    }
}
