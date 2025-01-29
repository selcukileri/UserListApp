//
//  ViewController.swift
//  UserListApp
//
//  Created by Selçuk İleri on 29.01.2025.
//

import UIKit
import SnapKit

class UserVC: UIViewController {
    
    private let viewModel = UserViewModel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private lazy var userTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .systemBackground
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureTableView()
        setupUI()
        activityIndicator.startAnimating() // Verileri indirirken aktif ediyorum
        viewModel.fetchUsers()
    }
    
    // ViewModel ile UI arasındaki bağlantı
    private func configureViewModel(){
        viewModel.onUsersFetched = { [weak self] in
            guard let self = self else { return }
            self.userTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
        
        viewModel.onError = { [weak self] error in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.showErrorAlert(message: error)
        }
    }
    
    private func setupUI(){
        view.backgroundColor = .systemBackground
        
        title = "Users"
        
        activityIndicator.center = view.center

        view.addSubviews(activityIndicator,userTableView)
        
        userTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView(){
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.register(UserCell.self, forCellReuseIdentifier: UserCell.userReuseID)
    }
    
    private func showErrorAlert(message: String){
        /// Normalde farklı bir viewController olarak oluşturulur ancak uygulama küçük olduğu için gereksiz olur diye düşündüm.
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension UserVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.userReuseID, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        let user = viewModel.getUser(at: indexPath.row)
        cell.configure(user: user) // Cell'imdeki configure methoduyla user'ı dolduruyorum
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = viewModel.getUser(at: indexPath.row)
        let detailVC = UserDetailsViewController()
        detailVC.title = "Details" // Detay sayfamızın title'ını ayarlıyorum.
        detailVC.configureDetailPage(user: selectedUser) // Detay sayfamdaki configureDetailPage fonksiyonumu çağırıyorum.
        /// Daha okunaklı olduğu için bu şekilde veri aktarmayı tercih ettim.
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
