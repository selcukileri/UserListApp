//
//  UserVM.swift
//  UserListApp
//
//  Created by Selçuk İleri on 29.01.2025.
//

import Foundation

class UserViewModel {
    
    private(set) var users: [User] = []
    
    var onUsersFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    
    // Data değiştiğinde veya error'de UI'ı güncellemek için closureları kullandım.
    // Neden reactive programlama kullanmadım? Çünkü karmaşık bir yapı olmadığı için closure'lar yeterli olur diye düşündüm.
    // Ek olarak, projeye gerekmediği sürece dependency eklemeyi doğru bulmuyorum.
    
    func fetchUsers(){
        UserManager.shared.fetchUser { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.users = users
                    self.onUsersFetched?()
                case .failure(let error):
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func numberOfUsers() -> Int{
        return users.count
    }
    
    func getUser(at index: Int) -> User {
        return users[index]
    }
}
