import Foundation

struct Repository: Decodable {
    let id: Int
    let fullname: String
    let owner: Owner
  
    enum CodingKeys: String, CodingKey {
      case id
      case fullname = "full_name"
      case owner
  }
}

struct Owner: Decodable {
    let avatar: URL
    
    enum CodingKeys: String, CodingKey {
        case avatar = "avatar_url"
    }
}

