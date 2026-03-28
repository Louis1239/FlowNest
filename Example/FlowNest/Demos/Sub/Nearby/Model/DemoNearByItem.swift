//
//  DemoNearByItem.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit

final class DemoNearByItem: NSObject {
    let nickname: String
    let avatarImageName: String
    let distanceText: String
    let summary: String

    init(
        nickname: String,
        avatarImageName: String,
        distanceText: String,
        summary: String
    ) {
        self.nickname = nickname
        self.avatarImageName = avatarImageName
        self.distanceText = distanceText
        self.summary = summary
    }
}

extension DemoNearByItem {
    static func mockItems(count: Int = 20) -> [DemoNearByItem] {
        let nicknames = [
            "Luna",
            "Mia",
            "Aki",
            "Iris",
            "Nora",
            "Coco",
            "Yuki",
            "Momo",
            "Lina",
            "Kira"
        ]

        let distances = [
            "120m",
            "380m",
            "520m",
            "860m",
            "1.1km",
            "1.8km",
            "2.4km"
        ]

        let summaries = [
            "下班喜欢散步，也喜欢认识说话舒服的人。",
            "周末常去咖啡馆，最近在找一起看展的搭子。",
            "爱聊天也爱安静，慢热但熟了以后很好相处。",
            "喜欢拍照和夜跑，希望附近能遇到同频的人。",
            "平时会做饭、追剧、听歌，想认识有趣的新朋友。",
            "刚搬到这附近，想找个能一起逛街和吃饭的人。"
        ]

        return (0..<count).map { index in
            DemoNearByItem(
                nickname: nicknames[index % nicknames.count],
                avatarImageName: String(format: "header_%02d", (index % 10) + 1),
                distanceText: distances[index % distances.count],
                summary: summaries[index % summaries.count]
            )
        }
    }
}
