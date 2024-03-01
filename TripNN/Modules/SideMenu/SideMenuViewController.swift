//
//  SideMenuViewController.swift
//  TripNN
//
//  Created by Pavel on 26.02.2024.
//

import UIKit

final class SideMenuViewController: UIViewController {
    
    var onSideMenuSettingsButtonAction: (() -> Void)?
    
    // MARK: - Constants

    let animationDuration = 0.3
    var isSideMenuPresenting: Bool = false
    
    // MARK: - View
    
    weak var sideMenuView: SideMenuView? {
        return self.view as? SideMenuView
    }
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = SideMenuView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Action
    
    @objc func sideMenuCloseAction(animated: Bool) {
        presentingViewController?.dismiss(animated: animated, completion: nil)
    }
    
    @objc func sideMenuSettingsScreenAction() {
        onSideMenuSettingsButtonAction?()
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupActions()
        setupGestures()
    }
    
    private func setupActions() {
        sideMenuView?.onSideMenuButtonCloseAction = { [weak self] in self?.sideMenuCloseAction(animated: true) }
        sideMenuView?.onSideMenuSettingsButtonAction = { [weak self] in self?.sideMenuSettingsScreenAction() }
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SideMenuViewController.handleTap(_:)))
        sideMenuView?.sideMenuBackgroundView.addGestureRecognizer(tapGesture)
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGesture))
        swipeRecognizer.direction = .left
        view.addGestureRecognizer(swipeRecognizer)
    }
    
    @objc private func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        sideMenuCloseAction(animated: true)
    }
}

extension SideMenuViewController: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        guard let sideMenu = sideMenuView?.sideMenuСontentView,
              let sideMenuBackground = sideMenuView?.sideMenuBackgroundView,
              let sideMenuWidth = sideMenuView?.sideMenuWidth else {
            return
        }
        
        isSideMenuPresenting = !isSideMenuPresenting
        
        if isSideMenuPresenting {
            transitionContext.containerView.addSubview(toViewController.view)
            
            sideMenu.frame.origin.x -= sideMenuWidth
            sideMenuBackground.alpha = 0
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseOut], animations: {
                sideMenu.frame.origin.x += sideMenuWidth
                sideMenuBackground.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseOut], animations: {
                sideMenu.frame.origin.x -= sideMenuWidth
                sideMenuBackground.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
}

extension SideMenuViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
