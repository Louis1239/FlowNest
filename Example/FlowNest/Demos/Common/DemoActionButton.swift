//
//  DemoActionButton.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit

final class DemoActionButton: UIButton {
    
    var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc private func handleTap() {
        onTap?()
    }
}
