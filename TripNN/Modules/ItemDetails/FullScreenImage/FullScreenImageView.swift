//
//  FullScreenImageView.swift
//  TripNN
//
//  Created by Pavel on 04.03.2024.
//

import UIKit

final class FullScreenImageView: UIView {
    
    // MARK: - Constants
    
    var currentImageIndex: Int = 0
    let placeImages = [UIImage(named: "place_1"), UIImage(named: "place_2"), UIImage(named: "place_3"), UIImage(named: "place_4"), UIImage(named: "place_5")]
    
    // MARK: - Closures
    
    var onCloseButtonAction: (() -> Void)?
    
    // MARK: - View
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Montserrat-Medium", size: 16)
        return button
    }()
    
    private let imageCounterLabel: UILabel = {
        let label = Title(text: "0", font: .semiBold, size: 16, color: .tripnnWhite)
        label.textAlignment = .center
        return label
    }()
    
    private let imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentMode = .scaleAspectFit
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 6
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    // MARK: - Gesture
    
    let downSwipeGesture: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .down
        return gesture
    }()
    
    let leftSwipeGesture: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .left
        return gesture
    }()
    
    let rightSwipeGesture: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .right
        return gesture
    }()
    
    let singleTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        return gesture
    }()
    
    let doubleTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 2
        return gesture
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    
    func configure(index: Int) {
        currentImageIndex = index
        imageView.image = placeImages[index]
        imageCounterLabel.text = String(format: "%ld из %ld", index+1, placeImages.count)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupView()
        setupConstraints()
        setupFrame()
        setupAction()
        setupScrollView()
        setupGesture()
        setupGestureRecognizer()
    }
    
    private func setupView() {
        self.backgroundColor = .black
        self.addSubview(imageScrollView)
        imageScrollView.addSubview(imageView)
        self.addSubview(headerView)
        self.addSubview(closeButton)
        self.addSubview(imageCounterLabel)
    }
    
    private func setupScrollView() {
        imageScrollView.delegate = self
    }
    
    private func setupConstraints() {
        setupHeaderBackgroundConstraints()
        setupCloseButtonConstraints()
        setupImageCounterLabelConstraints()
    }
    
    private func setupFrame() {
        imageScrollView.frame = self.bounds
        imageView.frame = imageScrollView.bounds
    }
    
    private func setupAction() {
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    private func setupGesture() {
        doubleTapGesture.addTarget(self, action: #selector(handleDoubleTapOnScrollView))
        singleTapGesture.addTarget(self, action: #selector(handleSingleTapOnScrollView))
        downSwipeGesture.addTarget(self, action: #selector(handleSwipeFrom))
        leftSwipeGesture.addTarget(self, action: #selector(handleSwipeFrom))
        rightSwipeGesture.addTarget(self, action: #selector(handleSwipeFrom))
    }
    
    private func setupGestureRecognizer() {
        imageScrollView.addGestureRecognizer(singleTapGesture)
        imageScrollView.addGestureRecognizer(doubleTapGesture)
        imageScrollView.addGestureRecognizer(rightSwipeGesture)
        imageScrollView.addGestureRecognizer(leftSwipeGesture)
        self.addGestureRecognizer(downSwipeGesture)
        singleTapGesture.require(toFail: doubleTapGesture)
    }
    
    // MARK: - Action
    
    @objc private func closeButtonAction() {
        onCloseButtonAction?()
    }
    
    @objc private func handleSwipeFrom(recognizer: UISwipeGestureRecognizer) {
        
        let direction: UISwipeGestureRecognizer.Direction = recognizer.direction
        
        switch direction {
            case UISwipeGestureRecognizer.Direction.right:
                if (currentImageIndex - 1 >= 0) {
                    self.configure(index: currentImageIndex - 1)
                }
            case UISwipeGestureRecognizer.Direction.left:
                if (currentImageIndex + 1 <= placeImages.count-1) {
                    self.configure(index: currentImageIndex + 1)
                }
            case UISwipeGestureRecognizer.Direction.down:
                onCloseButtonAction?()
            default:
                break
        }
    }
    
    @objc private func handleSingleTapOnScrollView(recognizer: UITapGestureRecognizer) {
        if closeButton.isHidden {
            revealHeader()
        } else {
            hideHeader()
        }
    }
    
    @objc private func handleDoubleTapOnScrollView(recognizer: UITapGestureRecognizer) {
        if imageScrollView.zoomScale == 1 {
            hideHeader()
            imageScrollView.zoom(to: zoomRectForScale(scale: imageScrollView.maximumZoomScale, centre: recognizer.location(in: recognizer.self.view)), animated: true)
        } else {
            revealHeader()
            imageScrollView.setZoomScale(1, animated: true)
        }
    }
    
    private func zoomRectForScale(scale: CGFloat, centre: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width = imageView.frame.size.width / scale
        
        let newCentre = imageView.convert(centre, from: imageScrollView)
        zoomRect.origin.x = newCentre.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCentre.y - (zoomRect.size.height / 2.0)
        
        return zoomRect
    }
    
    private func hideHeader() {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
            self.headerView.alpha = 0
            self.closeButton.alpha = 0
            self.imageCounterLabel.alpha = 0
        }, completion: { finished in
            self.headerView.isHidden = true
            self.closeButton.isHidden = true
            self.imageCounterLabel.isHidden = true
        })
    }
    
    private func revealHeader() {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
            
            self.headerView.isHidden = false
            self.closeButton.isHidden = false
            self.imageCounterLabel.isHidden = false
            
            self.headerView.alpha = 0.7
            self.closeButton.alpha = 1
            self.imageCounterLabel.alpha = 1
        })
    }
    
    // MARK: - Constraints
    
    private func setupHeaderBackgroundConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    private func setupCloseButtonConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 55),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    private func setupImageCounterLabelConstraints() {
        imageCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageCounterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageCounterLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor)
        ])
    }
}

extension FullScreenImageView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageView.image {
                let ratioWidth = imageView.frame.width / image.size.width
                let ratioHeight = imageView.frame.width / image.size.height
                
                let ratio = ratioWidth < ratioHeight ? ratioWidth : ratioHeight
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                
                let left = 0.5 * (newWidth * scrollView.zoomScale > imageView.frame.width ? (newWidth - imageView.frame.width) : (scrollView.frame.width - scrollView.contentSize.width))
                let top = 0.5 * (newHeight * scrollView.zoomScale > imageView.frame.height ? (newHeight - imageView.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top-60, left: left, bottom: top-35, right: left)
            }
        } else {
            scrollView.contentInset = UIEdgeInsets.zero
        }
    }
}
