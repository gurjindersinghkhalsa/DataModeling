//
//  ViewController.swift
//  DataModelingUsingStruct
//
//  Created by Gurjinder Singh on 16/05/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        callService { (result) in
            DispatchQueue.main.async {
                if let firObj = result.first {
                    let width = UIScreen.main.bounds.size.width
                    let stackView = UIStackView.init(frame: CGRect.init(x: 12, y: 50, width: width-24, height: 130))
                    stackView.alignment = .leading
                    stackView.axis = .vertical
                    stackView.distribution = .fillEqually
                    
                    let lblId = UILabel.init(frame: CGRect.init(x: 12, y: 10, width: width - 24, height: 30))
                    lblId.text = "Id = \(String(describing: firObj.id))"
                    
                    let lblTitle = UILabel.init(frame: CGRect.init(x: 12, y: 40, width: width - 24, height: 30))
                    lblTitle.text = "Title = \(String(describing: firObj.title))"
                    
                    let lblEpisodeNo = UILabel.init(frame: CGRect.init(x: 12, y: 40, width: width - 24, height: 30))
                    lblEpisodeNo.text = "Episode = \(String(describing: firObj.episode))"
                    
                    let lblSeries = UILabel.init(frame: CGRect.init(x: 12, y: 40, width: width - 24, height: 30))
                    lblSeries.text = "Series = \(String(describing: firObj.serires))"
                    
                    stackView.addArrangedSubview(lblId)
                    stackView.addArrangedSubview(lblTitle)
                    stackView.addArrangedSubview(lblEpisodeNo)
                    stackView.addArrangedSubview(lblSeries)
                    self.view.addSubview(stackView)
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func callService(completionHandler: @escaping((_ model: [EpisodeModel])-> Void)) {
        var urlReq = URLRequest.init(url: URL(string: "https://breakingbadapi.com/api/episodes")!)
        urlReq.httpMethod = "Get"
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: urlReq) { (data, response, error) in
            if let error = error {
              print("Error with fetching films: \(error)")
              return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
              return
            }
            if let data = data,
               let episodeModel = try? JSONDecoder().decode([EpisodeModel].self, from: data) {
                completionHandler(episodeModel)
            }
        }.resume()
    }

}

