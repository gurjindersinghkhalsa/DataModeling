//
//  Model.swift
//  DataModelingUsingStruct
//
//  Created by Gurjinder Singh on 16/05/21.
//

import Foundation

// MARK: - Episode

struct EpisodeModel: Codable {
    let id:Int?
    let title: String?
    let episode: String?
    let serires: String?
    let Characters: [String]?

    //Coding Key, which is a key that allows us to redefine the data received from the web service.
    enum NewKeys: String, CodingKey {
        case id = "episode_id"
        case title = "title"
        case episode = "air_date"
        case serires = "series"
        case characters = "characters"
    }

    init(from decoder: Decoder) throws  {
        let data = try decoder.container(keyedBy: NewKeys.self)
        id = try data.decodeIfPresent(Int.self, forKey: .id)
        episode = try data.decodeIfPresent(String.self, forKey: .episode)
        title = try data.decodeIfPresent(String.self, forKey: .title)
        serires = try data.decodeIfPresent(String.self, forKey: .serires)
        Characters = try data.decodeIfPresent([String].self, forKey: .characters)
    }
}

struct Characters {}









let jsonString = """
{
    "id": 1,
    "user": {
        "user_name": "Tester",
        "real_info": {
            "full_name":"Jon Doe"
        }
    },
    "reviews_count": [
    {
    "count": 4
    }
    ]
}
"""
struct RawResponse {
    enum RootKeys: String, CodingKey {
        case id, user, reviewCount = "reviews_count"
    }
    enum UserKey: String, CodingKey {
        case userName = "user_name", realInfo = "real_info"
    }
    enum RealInfoKey: String, CodingKey {
        case fullName = "full_name"
    }
    enum ReviewCountKeys: String, CodingKey {
        case count
    }
    let id: Int
    let userName: String
    let fullName: String
    let reviewCount: Int

}

extension RawResponse: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        id  = try container.decode(Int.self, forKey: .id)
        
        let userContainer = try container.nestedContainer(keyedBy: UserKey.self, forKey: .user)
        userName = try userContainer.decode(String.self, forKey: .userName)
        
        let realInfoKeysContainer = try userContainer.nestedContainer(keyedBy: RealInfoKey.self, forKey: .realInfo)
        fullName = try realInfoKeysContainer.decode(String.self, forKey: .fullName)
        
        var reviewUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .reviewCount)
        var reviewCountArray = [Int]()
        
        while !reviewUnkeyedContainer.isAtEnd {
            let reviewCountContainer = try reviewUnkeyedContainer.nestedContainer(keyedBy: ReviewCountKeys.self)
            reviewCountArray.append(try reviewCountContainer.decode(Int.self, forKey: .count))
        }
        guard let reviewCount = reviewCountArray.first else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath + [RootKeys.reviewCount], debugDescription: "reviews_count cannot be empty"))
        }
        self.reviewCount = reviewCount
    }
}
