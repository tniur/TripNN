//
//  SideMenuViewController.swift
//  TripNN
//
//  Created by Pavel on 26.02.2024.
//

import UIKit

final class SideMenuView: UIView {
    
    // MARK: - Closures
    
    var onSideMenuButtonCloseAction: (() -> Void)?
    var onSideMenuSettingsButtonAction: (() -> Void)?
    
    // MARK: - Constants
    
    let sideMenuWidth = UIScreen.main.bounds.width / 1.5
    
    // MARK: - View
    
    let sideMenuBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    let sideMenuСontentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let sideMenuCloseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close-icon"), for: .normal)
        return button
    }()
    
    private let sideMenuSectionsTableView = UITableView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupView()
        setupConstrains()
        addActions()
        setupSideMenuSectionsTableView()
    }
    
    private func setupSideMenuSectionsTableView() {
        sideMenuSectionsTableView.register(SideMenuSectionTableViewCell.self, forCellReuseIdentifier: "SideMenuSectionCell")
        sideMenuSectionsTableView.dataSource = self
        sideMenuSectionsTableView.delegate = self
        sideMenuSectionsTableView.separatorStyle = .none
    }
    
    private func setupView() {
        self.addSubview(sideMenuBackgroundView)
        self.addSubview(sideMenuСontentView)
        sideMenuСontentView.addSubview(sideMenuCloseButton)
        sideMenuСontentView.addSubview(sideMenuSectionsTableView)
    }
    
    private func setupConstrains() {
        setupSideMenuBackgroundViewConstraints()
        setupSideMenuViewConstraints()
        setupSideMenuCloseButtonConstraints()
        setupSideMenuSectionsTableViewConstraints()
    }
    
    // MARK: - Actions
    
    private func addActions() {
        sideMenuCloseButton.addTarget(self, action: #selector(closeSideMenu), for: .touchUpInside)
    }
    
    @objc private func closeSideMenu() {
        onSideMenuButtonCloseAction?()
    }
    
    @objc private func openSettingScreen() {
        onSideMenuSettingsButtonAction?()
    }
    
    // MARK: - Constrains
    
    private func setupSideMenuBackgroundViewConstraints() {
        sideMenuBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            sideMenuBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sideMenuBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sideMenuBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupSideMenuViewConstraints() {
        sideMenuСontentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuСontentView.widthAnchor.constraint(equalToConstant: sideMenuWidth),
            sideMenuСontentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sideMenuСontentView.topAnchor.constraint(equalTo: topAnchor),
            sideMenuСontentView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func setupSideMenuCloseButtonConstraints() {
        sideMenuCloseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuCloseButton.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            sideMenuCloseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            sideMenuCloseButton.widthAnchor.constraint(equalToConstant: 44),
            sideMenuCloseButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupSideMenuSectionsTableViewConstraints() {
        sideMenuSectionsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuSectionsTableView.topAnchor.constraint(equalTo: sideMenuCloseButton.bottomAnchor, constant: 10),
            sideMenuSectionsTableView.trailingAnchor.constraint(equalTo: sideMenuСontentView.trailingAnchor),
            sideMenuSectionsTableView.leadingAnchor.constraint(equalTo: sideMenuСontentView.leadingAnchor),
            sideMenuSectionsTableView.bottomAnchor.constraint(equalTo: sideMenuСontentView.bottomAnchor)
        ])
    }
}

enum SideMenuSection: Int {
    case account
    case history
    case favourites
    case settings
}

extension SideMenuView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuSectionCell", for: indexPath) as? SideMenuSectionTableViewCell else { fatalError() }
        
        let value: String
        
        switch indexPath.row {
            case SideMenuSection.account.rawValue:
                value = "Аккаунт"
            case SideMenuSection.history.rawValue:
                value = "История"
            case SideMenuSection.favourites.rawValue:
                value = "Избранные"
            case SideMenuSection.settings.rawValue:
                value = "Настройки"
            default:
                value = ""
        }
        
        cell.configure(title: value)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case SideMenuSection.settings.rawValue:
            onSideMenuSettingsButtonAction?()
        default:
            return
        }
    }
}
