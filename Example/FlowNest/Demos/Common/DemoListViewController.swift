//
//  DemoListViewController.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit
import FlowNest

final class DemoListViewController: UIViewController, FlowNestChildProtocol, FlowNestRefreshableChildProtocol {
    
    let nestedScrollView: UIScrollView
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let items: [String]
    private let color: UIColor
    private let titleText: String
    
    init(titleText: String, color: UIColor) {
        self.titleText = titleText
        self.color = color
        self.items = (1...30).map { "\(titleText)内容 \($0)" }
        self.nestedScrollView = tableView
        super.init(nibName: nil, bundle: nil)
        title = titleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    func flowNestHandleRefresh(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            guard let self = self else {
                completion()
                return
            }
            
            let banner = UILabel(frame: CGRect(x: 16, y: 8, width: self.view.bounds.width - 32, height: 36))
            banner.autoresizingMask = [.flexibleWidth]
            banner.backgroundColor = UIColor(red: 0.12, green: 0.17, blue: 0.24, alpha: 0.08)
            banner.textColor = UIColor(red: 0.12, green: 0.17, blue: 0.24, alpha: 1.0)
            banner.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            banner.textAlignment = .center
            banner.layer.cornerRadius = 10
            banner.layer.masksToBounds = true
            banner.text = "\(self.titleText) 模拟刷新完成"
            self.view.addSubview(banner)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                banner.removeFromSuperview()
                completion()
            }
        }
    }
}

extension DemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.text = items[indexPath.row]
        cell.detailTextLabel?.text = "第 \(indexPath.row + 1) 行"
        cell.backgroundColor = .clear
        return cell
    }
}

extension DemoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
