//
//  SettingsScreenView.swift
//  TripNN
//
//  Created by Pavel on 29.02.2024.
//

import UIKit

final class SettingsScreenView: UIView {
    
    // MARK: - Closures
    
    var onSettingsSectionAction: (() -> Void)?
    
    // MARK: - Constants
    
    private let settingSectionTable: [SettingSectionModel] = [
        SettingSectionModel(title: "Тема", status: "Системная"),
        SettingSectionModel(title: "Язык", status: "Русский")
    ]
    
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
}

extension SettingsScreenView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingSectionTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingSectionCell", for: indexPath) as? SettingSectionTableViewCell else { fatalError() }
        
        let content: SettingSectionModel  = settingSectionTable[indexPath.row]
        cell.configure(settingSectionModel: content)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                onSettingsSectionAction?()
            default:
                return
        }
    }
}


