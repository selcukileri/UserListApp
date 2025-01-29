//
//  UserDetailsViewController.swift
//  UserListApp
//
//  Created by Selçuk İleri on 29.01.2025.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    var choosenUser: User?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .systemBackground
        view.addSubviews(nameLabel,emailLabel,phoneLabel,websiteLabel)
        
        /// Neden snapkit kullandım?
        /// Çünkü snapkit sektörde çok yaygın kullanılan bir kütüphane, auto layout yönetimini kolaylaştırmak için kullanılıyor.
        /// Okunabilirliği arttırıyor.
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        websiteLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
    }
    
    /// Kullanıcı Detayları için.
    func configureDetailPage(user: User){
        nameLabel.text      = "Name: \(user.name)"
        emailLabel.text     = "Email: \(user.email)"
        phoneLabel.text     = "Phone: \(user.phone)"
        websiteLabel.text   = "Website: \(user.website)"
    }
    

}
