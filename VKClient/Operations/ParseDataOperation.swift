//
//  ParseDataOperation.swift
//  VKClient
//
//  Created by Maksim Savin on 10.04.2021.
//

import Foundation
import UIKit
class ParseDataOperation: Operation {
    var outputData: [Groups]?
    var decoder = JSONDecoder()
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else {return}
        guard let groupResponse = try? decoder.decode(APIGroupsResponce.self, from: data).response.items else {return}
        outputData = groupResponse
    }
}
