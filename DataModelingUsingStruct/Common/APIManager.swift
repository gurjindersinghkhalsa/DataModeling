//
//  APIManager.swift
//  DataModelingUsingStruct
//
//  Created by Gurjinder Singh on 03/06/21.
//

import Foundation

protocol BaseNetwork {
    func apiManagerSharedInstance()-> APIService?
}
extension BaseNetwork {
    func apiManagerSharedInstance()-> APIService? {
        return APIService.sharedInstance
    }
}


