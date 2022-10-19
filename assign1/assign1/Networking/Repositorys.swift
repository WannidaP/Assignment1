import Foundation

struct Repositorys: Decodable {
    let totalCount: Int
    let all: [Repository]
  
    enum CodingKeys: String, CodingKey {
      case totalCount = "total_count"
      case all = "items"
  }
}
