//
//  DemoLiveingView.swift
//  FlowNest_Example
//
//  Created by Louis on 2026/3/28.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit

class DemoLivingView: UIView {
    // MARK: - Config
    private let columnWidth: CGFloat = 1.5
    private let columnSpacing: CGFloat = 3.0
    private let columnCount = 3

    private var animationLayers: [CALayer] = []
    private var didSetupLayers = false

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear
        isUserInteractionEnabled = false
    }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()

        // Auto Layout 确定尺寸后，再创建 & 布局
        guard bounds.width > 0, bounds.height > 0 else { return }

        if !didSetupLayers {
            setupAnimationLayers()
            didSetupLayers = true
        }

        layoutAnimationLayers()
    }

    // MARK: - Layers
    private func setupAnimationLayers() {
        for index in 0..<columnCount {
            let layer = CALayer()
            layer.backgroundColor = tintColor.cgColor
            layer.cornerRadius = columnWidth / 2
            self.layer.addSublayer(layer)
            animationLayers.append(layer)

            addAnimation(to: layer, index: index)
        }
    }

    private func layoutAnimationLayers() {
        let centerX = bounds.width / 2
        let height = bounds.height

        for (index, layer) in animationLayers.enumerated() {

            let x: CGFloat
            switch index {
            case 0:
                x = centerX - columnSpacing
            case 1:
                x = centerX
            case 2:
                x = centerX + columnSpacing
            default:
                continue
            }

            layer.bounds = CGRect(
                x: 0,
                y: 0,
                width: columnWidth,
                height: height
            )
            layer.position = CGPoint(x: x, y: height)
            layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        }
    }

    // MARK: - Animation
    private func addAnimation(to layer: CALayer, index: Int) {

        let fromScale: CGFloat
        let toScale: CGFloat
        let duration: CFTimeInterval

        switch index {
        case 0:
            fromScale = 0.5
            toScale   = 1.0
            duration  = 0.5
        case 1:
            fromScale = 1.0
            toScale   = 0.2
            duration  = 0.5
        case 2:
            fromScale = 0.15
            toScale   = 1.0
            duration  = 0.8
        default:
            return
        }

        let anim = CABasicAnimation(keyPath: "transform.scale.y")
        anim.fromValue = fromScale
        anim.toValue = toScale
        anim.duration = duration
        anim.autoreverses = true
        anim.repeatCount = .infinity
        anim.isRemovedOnCompletion = false

        layer.add(anim, forKey: "living")
    }

    // MARK: - Tint
    override func tintColorDidChange() {
        super.tintColorDidChange()
        animationLayers.forEach {
            $0.backgroundColor = tintColor.cgColor
        }
    }
    
}
