//
//  ViewController.swift
//  WhiteHousePetitions.hackingWithSwift
//
//  Created by Илья Шаповалов on 27.06.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    //MARK: - Private properties
    private let cell = TableCell()
    private var petitions = [Petition]()
    private let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        addConstraints()
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            self.parse(json: data)
        }
        
    }
    
    private func parse(json: Data) {
        let decoder = JSONDecoder()
        
        guard let jsonPetitions = try? decoder.decode(Petitions.self, from: json) else { return }
        petitions = jsonPetitions.results
        tableView.reloadData()
    }
    
    //MARK: - SetupViews
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.register(TableCell.self, forCellReuseIdentifier: cell.cellIdentifier)
    }
    
    //MARK: - Set Delegates
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell.cellIdentifier, for: indexPath) as! TableCell
        cell.label.text = petitions[indexPath.row].title
        cell.detail.text = petitions[indexPath.row].body
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    
}

//MARK: - Add constraints
extension FeedViewController {
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
