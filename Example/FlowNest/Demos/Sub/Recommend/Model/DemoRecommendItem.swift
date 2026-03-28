//
//  DemoRecommendItem.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit

final class DemoRecommendItem: NSObject {

    /// 标题
    let title: String

    /// 昵称
    let name: String
    /// 头像
    let avatarImageName: String
    /// 内容
    let content: String
    /// 发布时间
    let publishTime: String
    /// 金币
    let coin: Int

    init(
        title: String,
        name: String,
        avatarImageName: String,
        content: String,
        publishTime: String,
        coin: Int
    ) {
        self.title = title
        self.name = name
        self.avatarImageName = avatarImageName
        self.content = content
        self.publishTime = publishTime
        self.coin = coin
    }
}

extension DemoRecommendItem {
    static func mockItems(count: Int = 20) -> [DemoRecommendItem] {
        let titles = [
            "本周精选搭配思路",
            "高转化详情页拆解",
            "新手也能用的封面模板",
            "电商首页视觉优化清单",
            "内容种草标题结构",
            "低成本拍出质感素材",
            "短视频封面排版技巧",
            "提升停留时长的卡片设计",
            "直播预热海报素材包",
            "活动页氛围感配色参考"
        ]

        let names = [
            "Nora",
            "Aiden",
            "Mika",
            "Ethan",
            "Luna",
            "Ryan",
            "Olivia",
            "Mason",
            "Chloe",
            "Lucas"
        ]

        let contents = [
            "整理了一套适合首页推荐位的视觉模板，封面、标题和 CTA 的优先级都标出来了，拿来就能改。",
            "把最近点击率比较高的三种卡片样式做了归纳，顺手补了适合电商和内容社区的两套文案结构。",
            "这版素材重点优化了首屏氛围感，背景、头像和价格区都能直接复用，比较适合做推荐流样式。",
            "如果你在做活动页，建议先把信息层级和视觉焦点分开，不然首屏会显得很挤，我把示例一起放进来了。",
            "做了一版偏轻拟物的推荐卡片，重点是让头像、昵称和内容区更有呼吸感，看起来会比纯列表更高级。",
            "这一组内容主要解决封面图不统一的问题，顺手附了常用尺寸和裁切安全区，适合直接给设计或运营用。"
        ]

        let times = [
            "3分钟前",
            "12分钟前",
            "25分钟前",
            "1小时前",
            "2小时前",
            "今天 09:24",
            "今天 13:08",
            "昨天 21:16"
        ]

        let coins = [0, 9, 12, 18, 20, 28, 36, 48]

        return (0..<count).map { index in
            DemoRecommendItem(
                title: titles[index % titles.count],
                name: names[index % names.count],
                avatarImageName: String(format: "header_%02d", (index % 10) + 1),
                content: contents[index % contents.count],
                publishTime: times[index % times.count],
                coin: coins[index % coins.count]
            )
        }
    }
}
