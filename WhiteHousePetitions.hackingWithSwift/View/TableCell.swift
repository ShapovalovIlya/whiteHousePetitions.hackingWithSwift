//
//  TableCell.swift
//  WhiteHousePetitions.hackingWithSwift
//
//  Created by Илья Шаповалов on 28.06.2022.
//

import UIKit

class TableCell: UITableViewCell {
    
    //MARK: - Public properties
    let cellIdentifier = "tableCell"
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "label"
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var detail: UILabel = {
        let label = UILabel()
        label.text = "detail"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private method
    private func setupViews() {
        
        addSubview(label)
        addSubview(detail)
    }
    
    private func setConstraints() {
        // Set label constraints
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
        // Set detail constraints
        NSLayoutConstraint.activate([
            detail.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            detail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            detail.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            detail.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
}
