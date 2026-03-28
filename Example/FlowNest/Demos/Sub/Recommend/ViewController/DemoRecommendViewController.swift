//
//  DemoRecommendViewController.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import FlowNest

final class DemoRecommendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    /// 列表
    private let tableView = UITableView(frame: .zero, style: .plain)
    /// 数据
    private var dataLis: [DemoRecommendItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setLayout()
        loadMockData()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.color("#111214")
        // 列表
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(DemoRecommendCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    private func setLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func loadMockData() {
        dataLis = DemoRecommendItem.mockItems(count: 20)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataLis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DemoRecommendCell
        cell.selectionStyle = .none
        cell.render(model: dataLis[indexPath.row])
        return cell
    }
}


extension DemoRecommendViewController:FlowNestChildProtocol, FlowNestRefreshableChildProtocol {
    
    var nestedScrollView: UIScrollView {
        return tableView
    }
    
    func flowNestHandleRefresh(completion: @escaping () -> Void) {
        // 刷新
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            guard let self = self else {
                completion()
                return
            }
            
            let banner = UILabel(frame: CGRect(x: 16, y: 50, width: self.view.bounds.width - 32, height: 36))
            banner.autoresizingMask = [.flexibleWidth]
            banner.backgroundColor = UIColor(red: 0.12, green: 0.17, blue: 0.24, alpha: 0.08)
            banner.textColor = UIColor(red: 0.12, green: 0.17, blue: 0.24, alpha: 1.0)
            banner.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            banner.textAlignment = .center
            banner.layer.cornerRadius = 10
            banner.layer.masksToBounds = true
            banner.text = "模拟刷新完成"
            self.view.addSubview(banner)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                banner.removeFromSuperview()
                completion()
            }
        }
    }
    
    
}
