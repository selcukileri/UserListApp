//
//  UserManager.swift
//  UserListApp
//
//  Created by Selçuk İleri on 29.01.2025.
//

import Foundation

/// Hata mesajlarının daha açıklayıcı hale getiren bir property
enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid endpoint URL"
        case .requestFailed(let error): return "Request failed: \(error.localizedDescription)"
        case .invalidResponse: return "Invalid Response"
        case .decodingFailed(let error): return "Failed to decode data: \(error.localizedDescription)"
        case .unknown: return "An unknown error"
        }
    }
}

class UserManager {
    static let shared = UserManager()
    private init(){}
    
    /// init methodunu private yaparak dışarıdan yeni bir instance oluşturulmasını engelledim.
    /// Singleton Pattern kullanmamın sebebi tek bir merkez kullanarak gereksiz instance oluşumunu önlemek
    /// Daha az bellek tüketimi
    
    private let userEndpoint = "https://jsonplaceholder.typicode.com/users"
    
    func fetchUser(completion: @escaping (Result<[User], NetworkError>) -> ()){
        
        guard let url = URL(string: userEndpoint) else {
            completion(.failure(.invalidURL)) // URL yanlışsa error verir
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error))) // Başarısız ağ isteği
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse)) // Geçerli bir yanıt alınamadı
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data) // JSON'ı user modeline çevirir
                completion(.success(users))
            } catch {
                completion(.failure(.decodingFailed(error))) // Parse edilemedi
            }
        }.resume()
        
    }
    
}
