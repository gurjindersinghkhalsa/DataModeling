//
//  EpisodeViewModel.swift
//  DataModelingUsingStruct
//
//  Created by Gurjinder Singh on 03/06/21.
//

import Foundation

class EpisodeViewModel: BaseNetwork {
   
   // var bindEpisodeViewModelToController: (()->()) = {}
    var data: (Result<[EpisodeModel], NetworkError>)?
    func callAPI(callBack: @escaping (Result<[EpisodeModel],NetworkError>)->Void) {
        self.apiManagerSharedInstance()?.callService(completionHandler: { (result) in
            callBack(result)
        })
    }
    
//    func callApi() {
//        self.apiManagerSharedInstance()?.callService(completionHandler: { (result) in
//            self.data = result
//            self.bindEpisodeViewModelToController()
//        })
//    }
}
