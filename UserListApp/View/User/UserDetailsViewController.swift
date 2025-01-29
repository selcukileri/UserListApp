//
//  UserDetailsViewController.swift
//  UserListApp
//
//  Created by Selçuk İleri on 29.01.2025.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    var choosenUser: User?
    
    private lazy var nameLabel = makeLabel()
    private lazy var emailLabel = makeLabel()
    private lazy var phoneLabel = makeLabel()
    private lazy var websiteLabel = makeLabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
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
            make.horizontalEdges.equalTo(nameLabel.snp.horizontalEdges)
            make.height.equalTo(30)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(nameLabel.snp.horizontalEdges)
            make.height.equalTo(30)
        }
        
        websiteLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(nameLabel.snp.horizontalEdges)
            make.height.equalTo(30)
        }
    }
    
    /// Kullanıcı Detayları için.
    func configureDetailPage(user: User){
        nameLabel.attributedText = formatText(bold: "Name: ", normal: user.name)
        emailLabel.attributedText = formatText(bold: "Email: ", normal: user.email)
        phoneLabel.attributedText = formatText(bold: "Phone: ", normal: user.phone)
        websiteLabel.attributedText = formatText(bold: "Website: ", normal: user.website)
    }
    
    /// Bir metnin ilk kısmını kalın (bold), geri kalanını orta kalınlıkta (medium) göstermek için kullandım
    private func formatText(bold: String, normal: String) -> NSAttributedString {
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.secondaryLabel,
            .font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
        
        let boldText = NSAttributedString(string: bold, attributes: boldAttributes)
        let normalText = NSAttributedString(string: normal, attributes: normalAttributes)
        
        let combinedText = NSMutableAttributedString()
        combinedText.append(boldText)
        combinedText.append(normalText)
        
        return combinedText
    }
    

}
