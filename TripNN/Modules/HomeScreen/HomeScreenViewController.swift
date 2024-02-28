//
//  HomeScreenViewController.swift
//  TripNN
//
//  Created by Pavel on 30.01.2024.
//

import UIKit

final class HomeScreenViewController: UIViewController {
    
    var sideMenuViewController: SideMenuViewController?
    
    var isSideMenuPresent:  Bool = false
    
    // MARK: - View
    
    weak var homeScreenView: HomeScreenView? {
        return self.view as? HomeScreenView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuViewController = SideMenuViewController()
        
        setupActions()
    }
    
    override func loadView() {
        self.view = HomeScreenView(frame: UIScreen.main.bounds)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBarStyle(isHidden: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setupNavigationBarStyle(isHidden: false)
    }
    
    // MARK: - Styles
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func setupNavigationBarStyle(isHidden: Bool) {
        navigationController?.navigationBar.isHidden = isHidden
        navigationItem.backButtonTitle = ""
    }
    
    // MARK: - Actions
    
    private func setupActions() {
        homeScreenView?.onSideMenuButtonAction = { [weak self] in self?.sideMenuOpenAction() }
        homeScreenView?.onNewRouteButtonAction = { [weak self] in self?.createNewRoute() }
        homeScreenView?.onAllPreparedRoutesButtonAction = { [weak self] in self?.openAllPreparedRoutes() }
    }
    
    @objc private func createNewRoute() {
        let controller = CreatingRouteViewController()
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func openAllPreparedRoutes() {
        let controller = AllPreparedRoutesViewController()
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func sideMenuOpenAction() {
        if let sideMenuViewController {
            sideMenuViewController.modalPresentationStyle = .custom
            sideMenuViewController.transitioningDelegate = self
            present(sideMenuViewController, animated: true, completion: nil)
        }
    }
}

extension HomeScreenViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransitionAnimation()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransitionAnimation()
    }
}

class presentTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let presentedView = transitionContext.viewController(forKey: .to)?.view else {
            transitionContext.completeTransition(false)
            return
        }
        
        transitionContext.containerView.addSubview(presentedView)
        
        let size = CGSize(width: UIScreen.main.bounds.size.width / 1.5, height: UIScreen.main.bounds.size.height)
        
        let preFrame = CGRect(origin: CGPoint(x: -size.width, y: 0), size: size)
        let finalFrame = CGRect(origin: CGPoint(x: .zero, y: 0), size: size)
        
        presentedView.frame = preFrame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView.frame = finalFrame
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}

class dismissTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let startView = transitionContext.viewController(forKey: .from)?.view else {
            transitionContext.completeTransition(false)
            return
        }
        
        let size = CGSize(width: UIScreen.main.bounds.size.width / 1.5, height: UIScreen.main.bounds.size.height)
        let preFrame = CGRect(origin: CGPoint(x: -size.width, y: 0), size: size)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            startView.frame = preFrame
        }) { (finished) in
            startView.removeFromSuperview()
            transitionContext.completeTransition(finished)
        }
    }
}
