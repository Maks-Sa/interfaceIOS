//
//  SaveToRealmOperation.swift
//  VKClient
//
//  Created by Maksim Savin on 10.04.2021.
//

import Foundation

class SaveToRealmOperation: AsyncOperation {
    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation, let groups = parseDataOperation.outputData else {return}
        
        do{
            // удаляем группы
            let ids = groups.map { $0.idGroup}
            let objectsToDelete = try Database.load(typeOF: Groups.self).filter("NOT id IN %@", ids)
            try Database.delete(object: objectsToDelete)
            //сохранение данных в Realm
            try Database.save(items: groups)
            state = .finished
        }
        catch {
            print("Error")
        }
    }
}
