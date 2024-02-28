//
//  SideMenuTransitionAnimation.swift
//  TripNN
//
//  Created by Pavel on 28.02.2024.
//

import UIKit

final class SideMenuTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresent: Bool
    
    init(isPresent: Bool) {
        self.isPresent = isPresent
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let size = CGSize(width: UIScreen.main.bounds.size.width / 1.5, height: UIScreen.main.bounds.size.height)
        let preFrame = CGRect(origin: CGPoint(x: -size.width, y: 0), size: size)
        let finalFrame = CGRect(origin: CGPoint(x: .zero, y: 0), size: size)
        
        guard let mainView = transitionContext.viewController(forKey: .from)?.view,
              let sideMenuView = transitionContext.viewController(forKey: .to)?.view else {
            transitionContext.completeTransition(false)
            return
        }
        
        if isPresent {
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                mainView.frame = preFrame
            }) { (finished) in
                mainView.removeFromSuperview()
                transitionContext.completeTransition(finished)
            }
        } else {
            transitionContext.containerView.addSubview(sideMenuView)
            sideMenuView.frame = preFrame
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                sideMenuView.frame = finalFrame
            }) { (finished) in
                transitionContext.completeTransition(finished)
            }
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}
