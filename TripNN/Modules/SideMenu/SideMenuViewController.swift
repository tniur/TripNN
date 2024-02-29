//
//  SideMenuViewController.swift
//  TripNN
//
//  Created by Pavel on 26.02.2024.
//

import UIKit

final class SideMenuViewController: UIViewController {
    
    // MARK: - Constants
    
    let menuWidth = UIScreen.main.bounds.width / 2
    var isPresenting = false
    
    // MARK: - View
    
    lazy var backgroundView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return bdView
    }()
    
    let menuView = UIView()
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(backgroundView)
        view.addSubview(menuView)
        
        menuView.backgroundColor = .white
        
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupConstraints()
        setupGestures()
    }
    
    private func setupConstraints() {
        setupSideMenuViewConstraints()
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SideMenuViewController.handleTap(_:)))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Action
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Constraints
    
    private func setupSideMenuViewConstraints() {
        menuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuView.widthAnchor.constraint(equalToConstant: menuWidth),
            menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuView.topAnchor.constraint(equalTo: view.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}













extension SideMenuViewController: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        isPresenting = !isPresenting
        
        if isPresenting {
            transitionContext.containerView.addSubview(toViewController.view)
            
            menuView.frame.origin.x -= menuWidth
            backgroundView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.x += self.menuWidth
                self.backgroundView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.x -= self.menuWidth
                self.backgroundView.alpha = 0
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





//final class SideMenuViewController: UIViewController {
//    
//    // MARK: - View
//    
//    weak var sideMenuView: SideMenuView? {
//        return self.view as? SideMenuView
//    }
//    
//    // MARK: - Lifecycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//    }
//    
//    override func loadView() {
//        self.view = SideMenuView(frame: UIScreen.main.bounds)
//    }
//    
//    // MARK: - Setup
//    
//    private func setup() {
//        setupActions()
//        setupGesture()
//    }
//    
//    private func setupActions() {
//        sideMenuView?.onSideMenuButtonCloseAction = { [weak self] in self?.sideMenuCloseAction() }
//    }
//    
//    private func setupGesture() {
//        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGesture))
//        swipeRecognizer.direction = .left
//        view.addGestureRecognizer(swipeRecognizer)
//    }
//    
//    @objc private func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
//        sideMenuCloseAction()
//    }
//    
//    // MARK: - Action
//    
//    @objc func sideMenuCloseAction() {
//        presentingViewController?.dismiss(animated: true, completion: nil)
//    }
//}
