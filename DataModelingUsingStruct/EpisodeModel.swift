//
//  Model.swift
//  DataModelingUsingStruct
//
//  Created by Gurjinder Singh on 16/05/21.
//

import Foundation
struct EpisodeModel: Codable {
    let id:Int?
    let title: String?
    let episode: String?
    let serires: String?
    
    //Coding Key, which is a key that allows us to redefine the data received from the web service.
    enum NewKeys: String, CodingKey {
        case id = "episode_id"
        case title = "title"
        case episode = "air_date"
        case serires = "series"
    }
    
    init(from decoder: Decoder) throws  {
        let data = try decoder.container(keyedBy: NewKeys.self)
        id = try data.decodeIfPresent(Int.self, forKey: .id)
        episode = try data.decodeIfPresent(String.self, forKey: .episode)
        title = try data.decodeIfPresent(String.self, forKey: .title)
        serires = try data.decodeIfPresent(String.self, forKey: .serires)
    }
}
