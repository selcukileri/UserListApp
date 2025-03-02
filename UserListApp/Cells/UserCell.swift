//
//  UserCell.swift
//  UserListApp
//
//  Created by Selçuk İleri on 29.01.2025.
//

import UIKit

class UserCell: UITableViewCell {
    
    static let userReuseID = "UserCell"
    
    private lazy var nameLabel = makeNameLabel()
    private lazy var emailLabel = makeEmailLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeNameLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }
    
    private func makeEmailLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }
    
    private func setupUI(){
        contentView.addSubviews(nameLabel,emailLabel)
        
        /// Neden snapkit kullandım?
        /// Çünkü snapkit sektörde çok yaygın kullanılan bir kütüphane, auto layout yönetimini kolaylaştırmak için kullanılıyor.
        /// Okunabilirliği arttırıyor.
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.height.equalTo(20)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel.snp.leading)
            make.height.equalTo(16)
        }
    }
    
    func configure(user: User){
        nameLabel.text = user.name
        emailLabel.text = user.email
    }

}
