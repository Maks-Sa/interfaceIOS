//
//  GetDataOperation.swift
//  VKClient
//
//  Created by Maksim Savin on 09.04.2021.
//

import Foundation

class GetDataOperation: AsyncOperation {
    private var url: URL
    private var dataTask: URLSessionDataTask?
    var data: Data?
    
    override func cancel() {
        dataTask?.cancel()
        super.cancel()
    }
 
    init(url: URL) {
        self.url = url
        super.init()
    }
    
    override func main() {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if data != nil && error != nil {
                self?.data = data
                self?.state = .finished
            } else {
                print("Network error")
            }
        }.resume()
    }
}

