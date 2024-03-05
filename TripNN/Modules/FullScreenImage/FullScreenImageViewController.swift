//
//  FullScreenImageViewController.swift
//  TripNN
//
//  Created by Pavel on 04.03.2024.
//

import UIKit

final class FullScreenImageViewController: UIViewController {
    
    var imageIndex: Int?
    
    // MARK: - View
    
    weak var fullScreenImageView: FullScreenImageView? {
        return self.view as? FullScreenImageView
    }
    
    init(imageIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        self.imageIndex = imageIndex
        
        fullScreenImageView?.configure(index: imageIndex)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = FullScreenImageView(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupActions()
    }
    
    private func setupActions() {
        fullScreenImageView?.onCloseButtonAction = { [weak self] in self?.closeViewController() }
    }
    
    // MARK: - Action
    
    @objc private func closeViewController() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
