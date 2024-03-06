//
//  LanguageSettingsSectionView.swift
//  TripNN
//
//  Created by Pavel on 06.03.2024.
//

import UIKit

final class LanguageSettingsSectionView: UIView {
    
    // MARK: - Closures
    
    var onDismissAction: (() -> Void)?
    
    // MARK: - Constants
    
    private let settingsSectionValues = [
        LanguageSettingsSectionModel(title: "Русский", value: LanguageTypes.rus),
        LanguageSettingsSectionModel(title: "English", value: LanguageTypes.eng),
    ]
    
    // MARK: - View
    
    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = .tripnnDark
        label.text = "Язык"
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "gray-close-icon"), for: .normal)
        return button
    }()
    
    private let settingsSectionsContentTableView: UITableView = {
        let table = UITableView()
        table.addViewShadow()
        table.layer.cornerRadius = 20
        return table
    }()
    
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
        setupConstraints()
        setupActions()
        setupSettingsSectionsContentTableView()
    }
    
    private func setupView() {
        self.backgroundColor = .tripnnWhite
        self.addSubview(sectionTitleLabel)
        self.addSubview(closeButton)
        self.addSubview(settingsSectionsContentTableView)
    }
    
    private func setupConstraints() {
        setupSectionTitleLabelConstraints()
        setupCloseButtonConstraints()
        setupSettingsSectionsContentTableViewConstraints()
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    private func setupSettingsSectionsContentTableView() {
        settingsSectionsContentTableView.register(SettingSectionContentTableViewCell.self, forCellReuseIdentifier: "SettingSectionContentCell")
        settingsSectionsContentTableView.dataSource = self
        settingsSectionsContentTableView.delegate = self
        settingsSectionsContentTableView.separatorStyle = .none
    }
    
    // MARK: - Actions
    
    @objc private func closeButtonAction() {
        onDismissAction?()
    }
    
    // MARK: - Constraints
    
    private func setupSectionTitleLabelConstraints() {
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            sectionTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        ])
    }
    
    private func setupCloseButtonConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: sectionTitleLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupSettingsSectionsContentTableViewConstraints() {
        settingsSectionsContentTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsSectionsContentTableView.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsSectionsContentTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            settingsSectionsContentTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            settingsSectionsContentTableView.heightAnchor.constraint(equalToConstant: CGFloat(settingsSectionValues.count*65))
        ])
    }
}

extension LanguageSettingsSectionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsSectionValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingSectionContentCell", for: indexPath) as? SettingSectionContentTableViewCell else { fatalError() }
        
        let lastSeparatorInsetStyle = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat.greatestFiniteMagnitude/2.0)
        
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        tableView.separatorColor = .tripnnSemiLightGray
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.setFirstCellStyle()
            cell.setSelectCellStyle()
        } else if indexPath.row == settingsSectionValues.count-1 {
            cell.setLastCellStyle()
            cell.separatorInset = lastSeparatorInsetStyle
        }
        
        cell.configure(title: settingsSectionValues[indexPath.row].title)
        
        return cell
    }
}

extension LanguageSettingsSectionView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateSelectedCell(tableView, indexPath)
    }
}

extension LanguageSettingsSectionView {
    private func updateSelectedCell(_ tableView: UITableView, _ indexPath: IndexPath) {
        let cells = tableView.visibleCells as! Array<SettingSectionContentTableViewCell>
        cells.forEach{$0.setUnSelectCellStyle()}
        
        let cell = tableView.cellForRow(at: indexPath) as! SettingSectionContentTableViewCell
        cell.setSelectCellStyle()
    }
}
