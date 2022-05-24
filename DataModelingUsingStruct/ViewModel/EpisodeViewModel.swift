//
//  EpisodeViewModel.swift
//  DataModelingUsingStruct
//
//  Created by Gurjinder Singh on 03/06/21.
//

import Foundation

class EpisodeViewModel: BaseNetwork {
    
    var items: Observable<[EpisodeModel]> = Observable([])
    func callAPI() {
        self.apiManagerSharedInstance()?.callService(completionHandler: { (result) in
            switch result {
            case .success(let model):
                self.items.value = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    /*
    var bindEpisodeViewModelToController: (()->()) = {}
    var data: (Result<[EpisodeModel], NetworkError>)?
    func callApi() {
        self.apiManagerSharedInstance()?.callService(completionHandler: { (result) in
            self.data = result
            self.bindEpisodeViewModelToController()
        })
    } */
}
