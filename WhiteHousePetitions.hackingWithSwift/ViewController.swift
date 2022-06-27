//
//  ViewController.swift
//  WhiteHousePetitions.hackingWithSwift
//
//  Created by Илья Шаповалов on 27.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Private properties
    private var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .red
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        addConstraints()
    }
    
    //MARK: - SetupViews
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    //MARK: - Set Delegates
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "test"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}

//MARK: - Add constraints
extension ViewController {
        private func addConstraints() {
        // Add constraints for table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
}
