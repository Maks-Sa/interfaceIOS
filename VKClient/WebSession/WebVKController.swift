//
//  WebVKController.swift
//  VKClient
//
//  Created by Maksim Savin on 09.02.2021.
//

import UIKit

class WebVKController: UIViewController {

    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var startRequestButton: UIButton!
    @IBOutlet weak var searchGroup: UITextField!
    
    var searchGr: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIDLabel.text = String(Session.startSession.userID!)
        //tokenLabel.lineBreakMode
        tokenLabel.text = Session.startSession.token
       
     
    }
    
    @IBAction func startRequest(_ sender: Any) {
       // searchGr = searchGroup.text!
        //запуск запросов
        if chekStart(){
            let networkSession = NetworkVK()
            networkSession.getUserFriends()
            networkSession.getPhotos(userID: String(Session.startSession.userID!))
            networkSession.getGroups(user: String(Session.startSession.userID!))
            networkSession.searchGroup(request: searchGr)
        }
        print("button pressed")
      
    }
    //проверка ввода для поиска групп
    func chekStart() ->Bool {
        searchGr = searchGroup.text!
        if searchGr == ""{
            showSearchError()
        }
        return true
    }
    //создаем контроллер
    func showSearchError() {
                // Создаем контроллер
                let alter = UIAlertController(title: "Ошибка", message: "НЕ введениы данные для поиска групп", preferredStyle: .alert)
                // Создаем кнопку для UIAlertController
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                // Добавляем кнопку на UIAlertController
                alter.addAction(action)
                // Показываем UIAlertController
                present(alter, animated: true, completion: nil)
            }
    

}
