//
//  SideMenuViewController.swift
//  TripNN
//
//  Created by Pavel on 26.02.2024.
//

import UIKit

final class SideMenuViewController: UIViewController {
    
    // MARK: - Constants

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
    
    // MARK: - Setup
    
    private func setup() {
        setupActions()
        setupGestures()
    }
    
    private func setupActions() {
        sideMenuView?.onSideMenuButtonCloseAction = { [weak self] in self?.sideMenuCloseAction() }
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SideMenuViewController.handleTap(_:)))
        sideMenuView?.sideMenuBackgroundView.addGestureRecognizer(tapGesture)
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGesture))
        swipeRecognizer.direction = .left
        view.addGestureRecognizer(swipeRecognizer)
    }
    
    @objc private func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        sideMenuCloseAction()
    }
    
    // MARK: - Action
    
    @objc func sideMenuCloseAction() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

extension SideMenuViewController: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        guard let sideMenu = sideMenuView?.sideMenuView,
              let sideMenuBackground = sideMenuView?.sideMenuBackgroundView,
              let sideMenuWidth = sideMenuView?.sideMenuWidth else {
            return
        }
        
        isSideMenuPresenting = !isSideMenuPresenting
        
        if isSideMenuPresenting {
            transitionContext.containerView.addSubview(toViewController.view)
            
            sideMenu.frame.origin.x -= sideMenuWidth
            sideMenuBackground.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                sideMenu.frame.origin.x += sideMenuWidth
                sideMenuBackground.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                sideMenu.frame.origin.x -= sideMenuWidth
                sideMenuBackground.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
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
