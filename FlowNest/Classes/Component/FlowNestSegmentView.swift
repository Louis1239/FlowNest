//
//  FlowNestSegmentView.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit

/// 自定义 segment 如果想接入 FlowNest 的分页联动，只需要实现这个协议。
/// 容器会负责把标题、当前选中项和点击回调同步给外部传入的 segment 视图。
public protocol FlowNestSegmentContentProtocol: AnyObject {
    
    /// segment 展示用的标题数组
    var titles: [String] { get set }
    /// 当前选中索引，容器在点击或滑动翻页后会同步更新
    var selectedIndex: Int { get set }
    /// 点击某一项后的回调，外部 segment 触发后交给容器处理切页
    var onSelect: ((Int) -> Void)? { get set }
    
}

/// FlowNest 默认提供的 segment 实现。
/// 如果外部没有传自定义 segmentView，容器就会使用它。
public final class FlowNestSegmentView: UIView, FlowNestSegmentContentProtocol {
    
    private var shouldAnimateSelectionUpdate = false
    
    public var titles: [String] = [] {
        didSet {
            reloadButtons()
        }
    }
    
    public var selectedIndex: Int = 0 {
        didSet {
            updateSelection(animated: shouldAnimateSelectionUpdate)
        }
    }
    
    public var onSelect: ((Int) -> Void)?
    
    private var buttons: [UIButton] = []
    private let stackView = UIStackView()
    private let indicatorView = UIView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateSelection(animated: false)
        shouldAnimateSelectionUpdate = true
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        indicatorView.backgroundColor = UIColor(red: 0.12, green: 0.17, blue: 0.24, alpha: 1.0)
        indicatorView.layer.cornerRadius = 1.5
        addSubview(indicatorView)
    }
    
    private func reloadButtons() {
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .custom)
            button.tag = index
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor(white: 0.42, alpha: 1.0), for: .normal)
            button.setTitleColor(UIColor(red: 0.12, green: 0.17, blue: 0.24, alpha: 1.0), for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            button.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        selectedIndex = min(selectedIndex, max(titles.count - 1, 0))
        setNeedsLayout()
        updateSelection(animated: false)
    }
    
    private func updateSelection(animated: Bool) {
        guard !buttons.isEmpty else {
            indicatorView.frame = .zero
            return
        }
        
        let safeIndex = min(max(selectedIndex, 0), buttons.count - 1)
        for (index, button) in buttons.enumerated() {
            button.isSelected = index == safeIndex
        }
        
        let buttonWidth = bounds.width / CGFloat(buttons.count)
        let targetFrame = CGRect(
            x: CGFloat(safeIndex) * buttonWidth + 18,
            y: bounds.height - 6,
            width: max(buttonWidth - 36, 24),
            height: 3
        )
        
        let updates = {
            self.stackView.frame = self.bounds
            self.indicatorView.frame = targetFrame
        }
        
        if animated {
            UIView.animate(withDuration: 0.22, animations: updates)
        } else {
            updates()
        }
    }
    
    @objc private func handleTap(_ sender: UIButton) {
        selectedIndex = sender.tag
        onSelect?(sender.tag)
    }
}
