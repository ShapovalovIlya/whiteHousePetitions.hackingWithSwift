//
//  ViewController.swift
//  WhiteHousePetitions.hackingWithSwift
//
//  Created by Илья Шаповалов on 27.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Private properties
    private let cell = TableCell()
    private var petitions = [Petition]()
    private var filtered = [Petition]()
    private var searchActive: Bool = false
    private var urlString: String = ""
    
    private lazy var creditsButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Credits"
        button.style = .plain
        button.target = self
        button.action = #selector(creditsTapped)
        return button
    }()
    
    private var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search..."
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
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
    }
    
    //MARK: - Private methods
    @objc private func creditsTapped () {
        let alertController = UIAlertController(title: "Data come's from:", message: urlString, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
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
        view.addSubview(searchBar)
        tableView.register(TableCell.self, forCellReuseIdentifier: cell.cellIdentifier)
        navigationItem.rightBarButtonItem = creditsButton
        
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            self.parse(json: data)
        }
    }
    
    //MARK: - Set Delegates
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }

}

//MARK: - Table View Data Source
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filtered.count
        } else {
            return petitions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell.cellIdentifier, for: indexPath) as! TableCell
        
        if searchActive {
            cell.label.text = filtered[indexPath.row].title
            cell.detail.text = filtered[indexPath.row].body
        } else {
            cell.label.text = petitions[indexPath.row].title
            cell.detail.text = petitions[indexPath.row].body
        }
        return cell
    }
}

//MARK: - Table View Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = WebViewController()
        destinationVC.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(destinationVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Search Bar Delegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = petitions.filter{ $0.title.contains(searchText) }
        
        if filtered.count == 0 {
            searchActive = false
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            searchActive = true
        }
        tableView.reloadData()
    }
}

//MARK: - Add constraints
extension MainViewController {
    private func addConstraints() {
        // Add constraints for search bar
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        // Add constraints for table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
}
