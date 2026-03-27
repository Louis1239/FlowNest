//
//  DemoCustomSegmentView.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit
import FlowNest

final class DemoCustomSegmentView: UIView, FlowNestSegmentContentProtocol {
    
    var titles: [String] = [] {
        didSet {
            reloadButtons()
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            updateSelection()
        }
    }
    
    var onSelect: ((Int) -> Void)?
    
    private var buttons: [UIButton] = []
    private let stackView = UIStackView()
    private let highlightView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds.insetBy(dx: 16, dy: 8)
        highlightView.layer.cornerRadius = stackView.bounds.height / 2
        updateSelection()
    }
    
    private func setupUI() {
        backgroundColor = UIColor(red: 0.95, green: 0.97, blue: 0.99, alpha: 1.0)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        highlightView.backgroundColor = UIColor(red: 0.12, green: 0.17, blue: 0.24, alpha: 1.0)
        stackView.addSubview(highlightView)
        addSubview(stackView)
    }
    
    private func reloadButtons() {
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .custom)
            button.tag = index
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor(red: 0.12, green: 0.17, blue: 0.24, alpha: 0.7), for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            button.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        selectedIndex = min(selectedIndex, max(titles.count - 1, 0))
    }
    
    private func updateSelection() {
        guard !buttons.isEmpty else {
            highlightView.frame = .zero
            return
        }
        
        let safeIndex = min(max(selectedIndex, 0), buttons.count - 1)
        let buttonWidth = stackView.bounds.width / CGFloat(buttons.count)
        highlightView.frame = CGRect(
            x: CGFloat(safeIndex) * buttonWidth,
            y: 0,
            width: buttonWidth - stackView.spacing + (stackView.spacing / CGFloat(buttons.count)),
            height: stackView.bounds.height
        )
        
        for (index, button) in buttons.enumerated() {
            button.isSelected = index == safeIndex
        }
        
        stackView.sendSubview(toBack: highlightView)
    }
    
    @objc private func handleTap(_ sender: UIButton) {
        selectedIndex = sender.tag
        onSelect?(sender.tag)
    }
}
