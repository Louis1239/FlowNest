//
//  DemoLiveViewController.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import FlowNest

final class DemoLiveViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /// 列表
    private let collectionView: UICollectionView
    /// 列表数据
    private var dataList: [DemoLiveItem] = []

    var nestedScrollView: UIScrollView {
        collectionView
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12.0
        layout.minimumInteritemSpacing = 10.0
        layout.sectionInset = UIEdgeInsets(top: 14, left: 0, bottom: 16, right: 0)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setLayout()
        loadMockData()
    }

    private func setupView() {
        view.backgroundColor = UIColor.color("#111214")

        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DemoLiveCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = .zero
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 14, left: 0, bottom: 16, right: 0)
    }

    private func setLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func loadMockData() {
        dataList = DemoLiveItem.mockItems(count: 20)
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DemoLiveCell
        cell.render(dataList[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let itemWidth = floor((totalWidth - 10.0) / 2.0)
        return CGSize(width: itemWidth, height: itemWidth * 1.45)
    }
}

extension DemoLiveViewController: FlowNestChildProtocol, FlowNestRefreshableChildProtocol {
    func flowNestHandleRefresh(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else {
                completion()
                return
            }

            dataList = DemoLiveItem.mockItems(count: 20)
            collectionView.reloadData()
            completion()
        }
    }
}
