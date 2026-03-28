//
//  DemoLiveItem.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit

final class DemoLiveItem: NSObject {

    /// 直播间标题
    let title: String
    /// 封面
    let coverImageName: String
    /// 主播名称
    let anchorName: String
    /// 分类标签
    let category: String
    /// 在线人数
    let audienceText: String

    init(
        title: String,
        coverImageName: String,
        anchorName: String,
        category: String,
        audienceText: String
    ) {
        self.title = title
        self.coverImageName = coverImageName
        self.anchorName = anchorName
        self.category = category
        self.audienceText = audienceText
    }
}

extension DemoLiveItem {
    static func mockItems(count: Int = 20) -> [DemoLiveItem] {
        let titles = [
            "陪你聊会儿天，顺便开箱今晚的新设备",
            "深夜电台模式，点歌和故事都可以来",
            "这局带粉上分，开麦直接进队",
            "周末居家氛围场，边做饭边聊天",
            "今天换了一套新布景，来看看效果",
            "直播拆礼物，看看有没有你想要的款",
            "轻松唠嗑场，分享最近值得买的好物",
            "摄影棚实景试拍，现场调灯给你看",
            "今天做一期穿搭直播，现场试衣搭配",
            "城市夜景慢直播，陪你放空十分钟"
        ]

        let anchors = [
            "Miya",
            "Rex",
            "Luna",
            "Aki",
            "Noah",
            "Lina",
            "Kane",
            "Ivy",
            "Milo",
            "Coco"
        ]

        let categories = [
            "闲聊",
            "上分",
            "唱歌",
            "居家",
            "开箱",
            "摄影",
            "穿搭",
            "陪伴"
        ]

        let audiences = [
            "1.2k 在看",
            "2.8k 在看",
            "3.4k 在看",
            "5.1k 在看",
            "8.6k 在看",
            "1.1w 在看"
        ]

        return (0..<count).map { index in
            DemoLiveItem(
                title: titles[index % titles.count],
                coverImageName: String(format: "live_%02d.JPG", (index % 10) + 1),
                anchorName: anchors[index % anchors.count],
                category: categories[index % categories.count],
                audienceText: audiences[index % audiences.count]
            )
        }
    }
}
