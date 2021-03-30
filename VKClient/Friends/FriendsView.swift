//
//  FriendsView.swift
//  VKClient
//
//  Created by Maksim Savin on 27.12.2020.
//

import UIKit

class FriendsView: UIViewController {
    private let networkVK = NetworkManager()
    private var friendsData: [User] = []
    
    //ключ для словаря
    var keys: [String] = []
    //словарь для индексации таблицы
    var friendsDict = [String: [User]]()
    //словарь для поиска
    var filteredFriendsDict = [String: [User]]()
    
    
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        searchBar.delegate = self
        getData()
    }
    
    func getData() {
        networkVK.getUserFriends(for: Session.startSession.userID!, handler: {[weak self] users in
            DispatchQueue.main.async {
                self?.friendsData = users
                (self!.keys, self!.filteredFriendsDict) = self!.prepareForSections(for: users)
                self?.friendsDict = self!.filteredFriendsDict
                self?.friendsTableView.reloadData()
            }
        })
    }
    
    private func prepareForSections(for inputArray: [User]) -> ([String], [String: [User]]) {
        var sectionsTitle = [String]()
        var sectionData = [String: [User]]()
        
        //разбираем исходный массив в словарь для индексации таблицы
        for user in inputArray {
            let lastNameKey = String(user.lastName.prefix(1))
            if var userValues = sectionData[lastNameKey] {
                userValues.append(user)
                sectionData[lastNameKey] = userValues
            } else {
                sectionData[lastNameKey] = [user]
            }
        }
        //сортируем по алфавиту
        sectionsTitle = [String](sectionData.keys).sorted(by: <)
        return (sectionsTitle, sectionData)
        
    }
    
}
extension FriendsView:  UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredFriendsDict.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        let count = filteredFriendsDict[key]!.count
        return count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    //заполнение ячеек таблицы данными
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Получаем ячейку
        let cellFriends = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        //Получаем экземпляр класса из словаря по секции и строке
        let key = keys[indexPath.section]
        let contact = filteredFriendsDict[key]![indexPath.row]
        
        //        dump("key cont= \(key)")
        //        dump("contact indexpath.row= \(indexPath.row)")
        //        dump("contact= \(contact)")
        
        // Присваиваем константам значения из массива данных
        let friendName = contact.firstName
        let friendSername = contact.lastName
        var friendAvatar: UIImage?
        let friendCity = "City"
        //Получаем картинку
        networkVK.getImage(by: contact.avatarURL) { (image) in
            friendAvatar = image
        }
        
        // Заполняем данные в ячейку через метод ячейки
        cellFriends.setData(city: friendCity, name: friendName, sername: friendSername, avatar: friendAvatar!)
        return cellFriends
    }
    
    //передаем данные из нажатой ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //получаем текущий сториборд
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        
        // получаем контроллер с нужным идентификатором
        let photoController = storybord.instantiateViewController(identifier: "PhotoController") as! PhotoFriendsView
        
        //получаем элемент массива данных из нажатой ячейки.
        // получаем ключ
        let key = keys[indexPath.section]
        // получаем экземпляр класса по ключу и номеру контакта
        let friend = filteredFriendsDict[key]![indexPath.row]
        
        //передаем экземпляр класса в целевой контроллер
        photoController.profileUser = friend
        //вызываем метод искомого контроллера для отображения
        show(photoController, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //Реализация поиска
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText != "" else {
            filteredFriendsDict = friendsDict
            keys = [String] (filteredFriendsDict.keys).sorted(by: <)
            friendsTableView.reloadData()
            return
        }
        filteredFriendsDict = friendsDict.mapValues{
            $0.filter{
                $0.firstName.lowercased().contains(searchText.lowercased()) ||
                    $0.lastName.lowercased().contains(searchText.lowercased())
            }
        }.filter {!$0.value.isEmpty}
        keys = [String] (filteredFriendsDict.keys).sorted(by: <)
        friendsTableView.reloadData()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
    
    
