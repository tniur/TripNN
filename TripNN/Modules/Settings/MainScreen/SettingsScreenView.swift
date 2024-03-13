//
//  SettingsScreenView.swift
//  TripNN
//
//  Created by Pavel on 29.02.2024.
//

import UIKit

final class SettingsScreenView: UIView {
    
    // MARK: - Closures
    
    var onThemeSectionAction: (() -> Void)?
    var onLanguageSectionAction: (() -> Void)?
    
    // MARK: - Constants
    
    private let settingSectionCount = 2
    
    // MARK: - View
    
    private let settingsSectionsTableView = UITableView()
    
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
        self.backgroundColor = .tripnnWhite
        setupView()
        setupConstraints()
        setupSettingsSectionsTableView()
    }
    
    private func setupView() {
        self.addSubview(settingsSectionsTableView)
    }
    
    private func setupConstraints() {
        setupSettingsSectionsTableViewConstraints()
    }
    
    private func setupSettingsSectionsTableView() {
        settingsSectionsTableView.register(SettingSectionTableViewCell.self, forCellReuseIdentifier: "SettingSectionCell")
        settingsSectionsTableView.dataSource = self
        settingsSectionsTableView.delegate = self
        settingsSectionsTableView.separatorStyle = .none
    }
    
    // MARK: - Constraints
    
    private func setupSettingsSectionsTableViewConstraints() {
        settingsSectionsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsSectionsTableView.topAnchor.constraint(equalTo: topAnchor),
            settingsSectionsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            settingsSectionsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            settingsSectionsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Support
    
    private func getLanguageStatus() -> String {
        let locale = Locale.current
        
        if locale.languageCode == "ru" {
            return String(localized: "russian_language")
        } else {
            return String(localized: "english_language")
        }
    }
    
    private func getTheme() -> String {
        let theme = UserDefaults.standard.integer(forKey: "selectedTheme")
        
        switch theme {
        case Theme.device.rawValue:
            return String(localized: "system_theme")
        case Theme.light.rawValue:
            return String(localized: "light_theme")
        case Theme.dark.rawValue:
            return String(localized: "dark_theme")
        default:
            return String(localized: "system_theme")
        }
    }
}

extension SettingsScreenView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingSectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingSectionCell", for: indexPath) as? SettingSectionTableViewCell else { fatalError() }
        
        let content: SettingSectionModel
        
        switch indexPath.row {
        case 0:
            content = SettingSectionModel(title: String(localized: "theme"), status: getTheme())
            cell.configure(settingSectionModel: content)
        case 1:
            content = SettingSectionModel(title: String(localized: "language"), status: getLanguageStatus())
            cell.configure(settingSectionModel: content)
        default:
            break
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            onThemeSectionAction?()
        case 1:
            onLanguageSectionAction?()
        default:
            return
        }
    }
}
