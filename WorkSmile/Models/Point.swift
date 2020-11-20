import Foundation

final class Point: Decodable {
    
    let latitude: String
    let longitude: String
    let altitude: String
    let timestamp: String
    let accuracy: String
    let distance: String
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case altitude
        case timestamp
        case accuracy
        case distance
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decode(String.self, forKey: CodingKeys.latitude)
        longitude = try container.decode(String.self, forKey: CodingKeys.longitude)
        altitude = try container.decode(String.self, forKey: CodingKeys.altitude)
        timestamp = try container.decode(String.self, forKey: CodingKeys.timestamp)
        accuracy = try container.decode(String.self, forKey: CodingKeys.accuracy)
        distance = try container.decode(String.self, forKey: CodingKeys.distance)
    }
}
