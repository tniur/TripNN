//
//  PlaceDetailsViewController.swift
//  TripNN
//
//  Created by Pavel on 23.02.2024.
//

import UIKit

final class PlaceDetailsViewController: UIViewController {
    
    // MARK: - View
    
    weak var placeDetailsView: PlaceDetailsView? {
        return self.view as? PlaceDetailsView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = PlaceDetailsView(frame: UIScreen.main.bounds)
    }
    
    // MARK: Setup
    
    private func setup() {
        setupActions()
    }
    
    private func setupActions() {
        placeDetailsView?.onOpenFullScreenImageAction = { [weak self] in self?.openFullScreenImage() }
    }
    
    // MARK: - Action
    
    @objc private func openFullScreenImage() {
        let fullScreenImageViewController = FullScreenImageViewController()
        fullScreenImageViewController.modalPresentationStyle = .overFullScreen
        present(fullScreenImageViewController, animated: true, completion: nil)
    }
}
