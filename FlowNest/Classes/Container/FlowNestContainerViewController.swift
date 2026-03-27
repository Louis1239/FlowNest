//
//  FlowNestContainerViewController.swift
//  FlowNest
//
//  Created by Louis on 2026/3/27.
//

import UIKit
import MJRefresh

public final class FlowNestContainerViewController: UIViewController {
    
    // MARK: - Public
    /// 头视图
    public var headerView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            setupHeader()
        }
    }
    
    /// 顶部切换条
    public var segmentView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            setupSegment()
        }
    }
    
    /// 容器内导航栏视图，不传则使用默认标题栏
    public var navigationBarView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            setupNavigationBar()
        }
    }
    
    /// 配置
    public var config: FlowNestConfig {
        didSet {
            coordinator.setMaxOffset(config.resolvedMaxOffset())
            if isViewLoaded {
                layoutContent()
            }
        }
    }
    
    public init(config: FlowNestConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    /// 外层垂直滚动
    private let verticalScrollView = FlowNestGestureScrollView()
    
    /// 默认导航栏容器
    private let defaultNavigationBarView = FlowNestNavigationView()
    
    /// 默认 segment
    private let defaultSegmentView = FlowNestSegmentView()
    
    /// 内层横向分页
    private let horizontalScrollView = UIScrollView()
    
    /// 子控制器
    private var viewControllers: [UIViewController] = []
    
    /// 当前页索引
    private var currentIndex: Int = 0
    
    /// 滚动协调器
    private let coordinator = FlowNestScrollCoordinator()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        setupUI()
        setupCoordinator()
        setupNavigationBar()
        setupHeader()
        setupSegment()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutContent()
    }
    
    private func setupUI() {
        view.addSubview(verticalScrollView)
        verticalScrollView.showsVerticalScrollIndicator = false
        verticalScrollView.alwaysBounceVertical = true
        verticalScrollView.delegate = self
        verticalScrollView.contentInset = .zero
        verticalScrollView.scrollIndicatorInsets = .zero
        if #available(iOS 11.0, *) {
            verticalScrollView.contentInsetAdjustmentBehavior = .never
        }
        
        verticalScrollView.addSubview(horizontalScrollView)
        horizontalScrollView.isPagingEnabled = true
        horizontalScrollView.showsHorizontalScrollIndicator = false
        horizontalScrollView.bounces = false
        horizontalScrollView.delegate = self
        horizontalScrollView.contentInset = .zero
        horizontalScrollView.scrollIndicatorInsets = .zero
        if #available(iOS 11.0, *) {
            horizontalScrollView.contentInsetAdjustmentBehavior = .never
        }
        
        verticalScrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.handleRefresh()
        })
        verticalScrollView.mj_header?.isAutomaticallyChangeAlpha = true
    }
    
    private func setupNavigationBar() {
        guard isViewLoaded else { return }
        
        defaultNavigationBarView.removeFromSuperview()
        navigationBarView?.removeFromSuperview()
        
        guard config.navigationBarHeight > 0 else {
            layoutContent()
            return
        }
        
        let barView = navigationBarView ?? defaultNavigationBarView
        if navigationBarView == nil {
            defaultNavigationBarView.apply(config: config, showsBackButton: config.showsNavigationBarBackButton)
            defaultNavigationBarView.onBack = { [weak self] in
                self?.handleBackButtonTap()
            }
        }
        
        view.addSubview(barView)
        layoutContent()
    }
    
    private func setupHeader() {
        guard isViewLoaded, let headerView = headerView else { return }
        verticalScrollView.addSubview(headerView)
        layoutContent()
    }
    
    private func setupSegment() {
        guard isViewLoaded else { return }
        
        defaultSegmentView.removeFromSuperview()
        segmentView?.removeFromSuperview()
        
        guard config.segmentHeight > 0 else {
            layoutContent()
            return
        }
        
        let currentSegmentView = segmentView ?? defaultSegmentView
        verticalScrollView.addSubview(currentSegmentView)
        
        (currentSegmentView as? FlowNestSegmentContentProtocol)?.onSelect = { [weak self] index in
            self?.scrollToPage(index, animated: true)
        }
        
        layoutContent()
    }
    
    private func setupCoordinator() {
        coordinator.setParentScrollView(verticalScrollView)
        coordinator.setMaxOffset(config.resolvedMaxOffset())
    }
    
    /// 添加子视图
    public func setViewControllers(_ vcs: [UIViewController]) {
        for vc in viewControllers {
            vc.willMove(toParentViewController: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParentViewController()
        }
        
        viewControllers = vcs
        
        for vc in vcs {
            addChildViewController(vc)
            horizontalScrollView.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
            
            if let child = vc as? FlowNestChildProtocol {
                bindProxyIfNeeded(to: child.nestedScrollView)
            } else {
                assertionFailure("子控制器必须实现 FlowNestChildProtocol")
            }
        }
        
        layoutPages()
        
        if let first = vcs.first as? FlowNestChildProtocol {
            coordinator.setCurrentChildScrollView(first.nestedScrollView)
        }
        
        currentIndex = 0
        updateSegmentTitlesIfNeeded()
        currentSegmentContentView()?.selectedIndex = 0
    }
    
    /// 绑定 proxy
    private func bindProxyIfNeeded(to scrollView: UIScrollView) {
        if getProxy(from: scrollView) != nil {
            return
        }
        
        let proxy = FlowNestScrollProxy()
        proxy.coordinator = coordinator
        proxy.originalDelegate = scrollView.delegate
        
        scrollView.delegate = proxy
        setProxy(proxy, to: scrollView)
    }
    
    private func getProxy(from scrollView: UIScrollView) -> FlowNestScrollProxy? {
        objc_getAssociatedObject(scrollView, &AssociatedKeys.proxyKey) as? FlowNestScrollProxy
    }
    
    private func setProxy(_ proxy: FlowNestScrollProxy, to scrollView: UIScrollView) {
        objc_setAssociatedObject(
            scrollView,
            &AssociatedKeys.proxyKey,
            proxy,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }
    
    private func layoutContent() {
        let navigationBarHeight = config.navigationBarHeight
        let contentHeight = max(view.bounds.height - navigationBarHeight, 0)
        let navigationBarFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: navigationBarHeight)
        
        if config.navigationBarHeight > 0 {
            let barView = navigationBarView ?? defaultNavigationBarView
            barView.frame = navigationBarFrame
        }
        
        verticalScrollView.frame = CGRect(
            x: 0,
            y: navigationBarHeight,
            width: view.bounds.width,
            height: contentHeight
        )
        
        guard let headerView = headerView else {
            let segmentHeight = config.segmentHeight
            currentSegmentView()?.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: segmentHeight)
            horizontalScrollView.frame = CGRect(
                x: 0,
                y: segmentHeight,
                width: view.bounds.width,
                height: verticalScrollView.bounds.height - segmentHeight
            )
            verticalScrollView.contentSize = verticalScrollView.bounds.size
            layoutPages()
            return
        }
        
        let headerHeight = config.headerHeight
        let segmentHeight = config.segmentHeight
        
        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: headerHeight
        )
        
        currentSegmentView()?.frame = CGRect(
            x: 0,
            y: headerHeight,
            width: view.bounds.width,
            height: segmentHeight
        )
        
        horizontalScrollView.frame = CGRect(
            x: 0,
            y: headerHeight + segmentHeight,
            width: view.bounds.width,
            height: verticalScrollView.bounds.height - segmentHeight
        )
        
        verticalScrollView.contentSize = CGSize(
            width: view.bounds.width,
            height: verticalScrollView.bounds.height + headerHeight
        )
        
        layoutPages()
    }
    
    private func layoutPages() {
        for (index, vc) in viewControllers.enumerated() {
            vc.view.frame = CGRect(
                x: CGFloat(index) * horizontalScrollView.bounds.width,
                y: 0,
                width: horizontalScrollView.bounds.width,
                height: horizontalScrollView.bounds.height
            )
        }
        
        horizontalScrollView.contentSize = CGSize(
            width: CGFloat(viewControllers.count) * horizontalScrollView.bounds.width,
            height: horizontalScrollView.bounds.height
        )
    }
    
    private func updateSegmentTitlesIfNeeded() {
        let titles = viewControllers.enumerated().map { index, viewController in
            if let title = viewController.title, !title.isEmpty {
                return title
            }
            return "Page \(index + 1)"
        }
        currentSegmentContentView()?.titles = titles
    }
    
    private func scrollToPage(_ index: Int, animated: Bool) {
        guard viewControllers.indices.contains(index) else { return }
        let pageWidth = max(horizontalScrollView.bounds.width, 1)
        let targetOffset = CGPoint(x: CGFloat(index) * pageWidth, y: 0)
        horizontalScrollView.setContentOffset(targetOffset, animated: animated)
        updateCurrentPage(index)
    }
    
    private func updateCurrentPage(_ index: Int) {
        guard viewControllers.indices.contains(index),
              let child = viewControllers[index] as? FlowNestChildProtocol else {
            return
        }
        
        currentIndex = index
        currentSegmentContentView()?.selectedIndex = index
        coordinator.didSwitchPage(to: child.nestedScrollView)
    }
    
    private func handleRefresh() {
        guard viewControllers.indices.contains(currentIndex) else {
            endRefreshing()
            return
        }
        
        let currentViewController = viewControllers[currentIndex]
        
        guard let refreshableChild = currentViewController as? FlowNestRefreshableChildProtocol else {
            endRefreshing()
            return
        }
        
        refreshableChild.flowNestHandleRefresh { [weak self] in
            DispatchQueue.main.async {
                self?.endRefreshing()
            }
        }
    }
    
    private func endRefreshing() {
        verticalScrollView.mj_header?.endRefreshing()
    }
    
    @objc private func handleBackButtonTap() {
        if let navigationController = navigationController, navigationController.viewControllers.first != self {
            navigationController.popViewController(animated: true)
        } else if presentingViewController != nil {
            dismiss(animated: true)
        }
    }
    
    private func currentSegmentView() -> UIView? {
        config.segmentHeight > 0 ? (segmentView ?? defaultSegmentView) : nil
    }
    
    private func currentSegmentContentView() -> FlowNestSegmentContentProtocol? {
        currentSegmentView() as? FlowNestSegmentContentProtocol
    }
    
    private struct AssociatedKeys {
        static var proxyKey: UInt8 = 0
    }
}

extension FlowNestContainerViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == verticalScrollView {
            coordinator.handleParentScroll(scrollView)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == horizontalScrollView {
            let pageWidth = max(scrollView.bounds.width, 1)
            let index = Int(round(scrollView.contentOffset.x / pageWidth))
            updateCurrentPage(index)
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == horizontalScrollView, !decelerate {
            let pageWidth = max(scrollView.bounds.width, 1)
            let index = Int(round(scrollView.contentOffset.x / pageWidth))
            updateCurrentPage(index)
        }
    }
}
