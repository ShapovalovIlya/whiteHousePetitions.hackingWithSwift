//
//  DetailViewController.swift
//  WhiteHousePetitions.hackingWithSwift
//
//  Created by Илья Шаповалов on 28.06.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    //MARK: - Public properties
    var detailItem: Petition?
    
    //MARK: - Private properties
    private var webView: WKWebView!
    private lazy var creditsButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Credits"
        button.style = .plain
        button.target = self
        button.action = #selector(creditsTapped)
        return button
    }()
    
    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupHTML()
    }
    
    //MARK: - Private methods
    private func setupViews() {
        navigationItem.rightBarButtonItem = creditsButton
    }
    
    private func setupHTML() {
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        <title>\(detailItem.title)</title>
        </head>
        <body>\(detailItem.body)</body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    @objc private func creditsTapped () {
        let alertController = UIAlertController(title: "Data come's from:", message: detailItem?.title, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
}
