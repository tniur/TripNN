////
////  SideMenuTableViewCell.swift
////  TripNN
////
////  Created by Pavel on 29.02.2024.
////
//
//import UIKit
//
//final class SideMenuSectionTableViewCell: UITableViewCell {
//    
//    // MARK: - View
//    
//    private let containerView: UIView = {
//        let view = UIView()
//        return view
//    }()
//    
//    private let sectionButton: UIButton = {
//        let button = UIButton()
//        button.setTitleColor(.tripnnDark, for: .normal)
//        button.titleLabel?.font =  UIFont(name: "Montserrat-Regular", size: 16)
//        return button
//    }()
//    
//    // MARK: - Init
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        setup()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure(title: String) {
//        sectionButton.setTitle(title, for: .normal)
//    }
//    
//    // MARK: - Setup
//    
//    private func setup() {
//        setupView()
//        setupConstraints()
//    }
//    
//    private func setupView() {
//        contentView.addSubview(containerView)
//        containerView.addSubview(sectionButton)
//    }
//    
//    private func setupConstraints() {
//        setupContainerViewConstraints()
//        setupLabelsContainerViewConstraints()
//    }
//    
//    private func setupContainerViewConstraints() {
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        let heightConstraint = containerView.heightAnchor.constraint(equalToConstant: 70)
//        heightConstraint.priority = UILayoutPriority(999)
//        NSLayoutConstraint.activate([
//            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            heightConstraint
//        ])
//    }
//    
//    private func setupLabelsContainerViewConstraints() {
//        labelsContainerStack.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            labelsContainerStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            labelsContainerStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            labelsContainerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
//            labelsContainerStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 17),
//        ])
//    }
//}
