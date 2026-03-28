//
//  DemoNearByViewController.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import FlowNest

final class DemoNearbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let headerView = DemoNearByHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 122))
    private var dataList: [DemoNearByItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setLayout()
        loadMockData()
    }

    private func setupView() {
        view.backgroundColor = UIColor.color("#111214")

        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DemoNearByCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 108
        tableView.tableHeaderView = headerView
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }

    private func setLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func loadMockData() {
        dataList = DemoNearByItem.mockItems(count: 20)
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DemoNearByCell
        cell.selectionStyle = .none
        cell.render(dataList[indexPath.row])
        return cell
    }
}

extension DemoNearbyViewController: FlowNestChildProtocol, FlowNestRefreshableChildProtocol {
    var nestedScrollView: UIScrollView {
        tableView
    }

    func flowNestHandleRefresh(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else {
                completion()
                return
            }

            dataList = DemoNearByItem.mockItems(count: 20)
            tableView.reloadData()
            completion()
        }
    }
}
