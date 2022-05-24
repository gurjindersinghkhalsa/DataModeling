//
//  ViewController.swift
//  DataModelingUsingStruct
//
//  Created by Gurjinder Singh on 16/05/21.
//

import UIKit


class ViewController: UIViewController {
    
    private var viewModel: EpisodeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callAPIUpdate()
    }
    

    fileprivate func callAPIUpdate() {
        // firstway
        self.viewModel = EpisodeViewModel()
        self.viewModel.callAPI()
        viewModel.items.observe { [weak self] episodeModel in
            if let firObj = episodeModel.first, let wself = self {
                DispatchQueue.main.async {
                    wself.updateViews(firObj: firObj)
                }
            }
        }
        
        /* Second way to call API
         self.viewModel.callApi()
         self.viewModel.bindEpisodeViewModelToController = {
            self.updateUI(result: self.viewModel.data!)
         }*/
    }
    
    fileprivate func updateUI(result: Result<[EpisodeModel],NetworkError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let result):
                if let firObj = result.first {
                    self.updateViews(firObj: firObj)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func updateViews(firObj: EpisodeModel) {
        let width = UIScreen.main.bounds.size.width
        let stackView = UIStackView.init(frame: CGRect.init(x: 12, y: 50, width: width-24, height: 130))
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        let lblId = UILabel.init(frame: CGRect.init(x: 12, y: 10, width: width - 24, height: 30))
        lblId.text = "Id = \(String(describing: firObj.id ?? 0))"
        
        let lblTitle = UILabel.init(frame: CGRect.init(x: 12, y: 40, width: width - 24, height: 30))
        lblTitle.text = "Title = \(String(describing: firObj.title ?? ""))"
        
        let lblEpisodeNo = UILabel.init(frame: CGRect.init(x: 12, y: 40, width: width - 24, height: 30))
        lblEpisodeNo.text = "Episode = \(String(describing: firObj.episode ?? ""))"
        
        let lblSeries = UILabel.init(frame: CGRect.init(x: 12, y: 40, width: width - 24, height: 30))
        lblSeries.text = "Series = \(String(describing: firObj.serires ?? ""))"
        
        let lblChars = UILabel.init(frame: CGRect.init(x: 12, y: 40, width: width - 24, height: 30))
        lblChars.text = "Characters = \(String(describing: firObj.Characters?.joined(separator: ",") ?? ""))"
        
        stackView.addArrangedSubview(lblId)
        stackView.addArrangedSubview(lblTitle)
        stackView.addArrangedSubview(lblEpisodeNo)
        stackView.addArrangedSubview(lblSeries)
        stackView.addArrangedSubview(lblChars)
        self.view.addSubview(stackView)
    }
}

