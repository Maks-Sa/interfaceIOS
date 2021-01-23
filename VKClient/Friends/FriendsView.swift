//
//  FriendsView.swift
//  VKClient
//
//  Created by Maksim Savin on 27.12.2020.
//

import UIKit

class FriendsView: UIViewController {
    // Готовим данные для таблицы
  
    var friendsData: [userVK] = [
        (userVK(name: "Vash the", surname: "Stampede", avatar: UIImage(named: "trigunicon")!,
                 photo: [photoAlbum(photo: UIImage(named: "trigunimage")!),
                         photoAlbum(photo: UIImage(named: "vash1")!),
                         photoAlbum(photo: UIImage(named: "vash2")!),
                         photoAlbum(photo: UIImage(named: "vash3")!),
                         photoAlbum(photo: UIImage(named: "vash4.jpg")!),
                         photoAlbum(photo: UIImage(named: "vash5.jpg")!)],
                 gender: .male, idGroup: 1, city: "Gunsmoke")),
        (userVK(name: "Alukard", surname: "Lord", avatar: UIImage(named: "alukardicon")!,
                 photo: [.init(photo: UIImage(named: "alukardimage")!),
                         .init(photo: UIImage(named: "alukard1")!),
                         .init(photo: UIImage(named: "alukard2")!),
                         .init(photo: UIImage(named: "alukard3")!),
                         .init(photo: UIImage(named: "alukard4")!)],
                 gender: .male, idGroup: 1, city: "Valahia")),
        (userVK(name: "Nicholas D.", surname: "Wolfwood", avatar: UIImage(named: "wolfwood1")!,
                 photo: [.init(photo: UIImage(named: "wolfwood2")!),
                         .init(photo: UIImage(named: "wolfwood3")!)],
                 gender: .male , idGroup: 1, city: "Evergreen")),
        (userVK(name: "Knives", surname: "Millions", avatar: UIImage(named: "knivesavatar")!,
                 photo: [.init(photo: UIImage(named: "knives1")!),
                         .init(photo: UIImage(named: "knives2")!),
                         .init(photo: UIImage(named: "knives3")!),
                         .init(photo: UIImage(named: "knives4")!)],
                 gender: .male , idGroup: 1, city: "Gunsmoke")),
        (userVK(name: "Meryl", surname: "Stryfe", avatar: UIImage(named: "meryl0")!,
                 photo: [.init(photo: UIImage(named: "meryl1")!),
                         .init(photo: UIImage(named: "meryl2")!),
                         .init(photo: UIImage(named: "meryl3")!)],
                 gender: .female , idGroup: 1, city: "Gunsmoke")),
        (userVK(name: "Milly", surname: "Thompson", avatar: UIImage(named: "milly0")!,
                 photo: [.init(photo: UIImage(named: "milly1")!),
                         .init(photo: UIImage(named: "milly2")!),
                         .init(photo: UIImage(named: "milly3")!)],
                 gender: .female , idGroup: 1, city: "Gunsmoke")),
        (userVK(name: "Kuroneko-sama", surname: "cat", avatar: UIImage(named: "kuroneko0")!,
                 photo: [.init(photo: UIImage(named: "kuroneko1")!),
                         .init(photo: UIImage(named: "kuroneko4")!),
                         .init(photo: UIImage(named: "kuroneko3")!)],
                 gender: .female , idGroup: 1, city: "Gunsmoke")),
        (userVK(name: "Sho", surname: "Cheon", avatar: UIImage(named: "shoavatar")!,
                 photo: [.init(photo: UIImage(named: "sho1")!),
                         .init(photo: UIImage(named: "sho2")!),
                         .init(photo: UIImage(named: "sho3")!)],
                 gender: .female , idGroup: 1, city: "Gunsmoke")),
        (userVK(name: "Ichigo", surname: "Kurosaki", avatar: UIImage(named: "ichiavatar")!,
                 photo: [.init(photo: UIImage(named: "ichi1")!),
                         .init(photo: UIImage(named: "ichi2")!),
                         .init(photo: UIImage(named: "ichi3")!),
                         .init(photo: UIImage(named: "ichi4")!),
                         .init(photo: UIImage(named: "ichi5")!)],
                 gender: .male, idGroup: 1, city: "Karakura")),
        (userVK(name: "Nagisa", surname: "Furukawa", avatar: UIImage(named: "nagisa0")!,
                 photo: [.init(photo: UIImage(named: "nagisa1")!),
                         .init(photo: UIImage(named: "nagisa2")!),
                         .init(photo: UIImage(named: "nagisa3")!),
                         .init(photo: UIImage(named: "nagisa4")!),
                         .init(photo: UIImage(named: "nagisa5")!)],
                 gender: .female, idGroup: 1, city: "Tsukuba")),
        (userVK(name: "Tomoya", surname: "Okazaki", avatar: UIImage(named: "tomoya0")!,
                 photo: [.init(photo: UIImage(named: "tomoya1")!),
                         .init(photo: UIImage(named: "tomoya2")!),
                         .init(photo: UIImage(named: "tomoya3")!),],
                 gender: .male, idGroup: 1, city: "Tsukuba")),
        (userVK(name: "Tomoyo", surname: "Sakagami", avatar: UIImage(named: "sakagami0")!,
                 photo: [.init(photo: UIImage(named: "sakagami1")!),
                         .init(photo: UIImage(named: "sakagami2")!),
                         .init(photo: UIImage(named: "sakagami3")!),],
                 gender: .female, idGroup: 1, city: "Tsukubaa")),
        (userVK(name: "Raizel", surname: "Cadis Etrama", avatar: UIImage(named: "raizel0")!,
                 photo: [.init(photo: UIImage(named: "raizel1")!),
                         .init(photo: UIImage(named: "raizel2")!),
                         .init(photo: UIImage(named: "raizel3")!),
                         .init(photo: UIImage(named: "raizel4")!),],
                 gender: .male, idGroup: 1, city: "Lukedonia")),
        (userVK(name: "Frankenstein", surname: "The chairman", avatar: UIImage(named: "franke0")!,
                 photo: [.init(photo: UIImage(named: "franke1")!),
                         .init(photo: UIImage(named: "franke2")!),
                         .init(photo: UIImage(named: "franke3")!),
                         .init(photo: UIImage(named: "franke4")!),],
                 gender: .male, idGroup: 1, city: "Lukedonia")),
        (userVK(name: "Muzaka", surname: "vervolf", avatar: UIImage(named: "muzaka0")!,
                 photo: [.init(photo: UIImage(named: "muzaka1")!),
                         .init(photo: UIImage(named: "muzaka2")!),
                         .init(photo: UIImage(named: "muzaka3")!),
                         .init(photo: UIImage(named: "muzaka4")!),],
                 gender: .male, idGroup: 1, city: "Lukedonia"))
        
       
      
     
        
    ]
    
    var sections: [String: [userVK]] = [:]
    var keys: [String] = []
    
    @IBOutlet weak var friendsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        
        //взял твой код) спасибо
        friendsData.forEach { contact in
            let firstLetter = String(contact.surname.first!)
            if sections[firstLetter] != nil {
                sections[firstLetter]!.append(contact)
            } else {
                sections[firstLetter] = [contact]
            }
        }
        keys = Array(sections.keys).sorted(by: <)

    }
    
}
    extension FriendsView:  UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return friendsData1.count
        let key = keys[section]
        let count = sections[key]!.count
        return count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
   
    //заполнение ячеек данными
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Получаем ячейку
        let cellFriends = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
        let key = keys[indexPath.section]
        let contact = sections[key]![indexPath.row]
        
        // Присваиваем константам значения из массива данных
//        let friendName = friendsData1[indexPath.row].name
//        let friendSername = friendsData1[indexPath.row].surname
//        let friendAvatar = friendsData1[indexPath.row].avatar
//        let friendCity = friendsData1[indexPath.row].city
        let friendName = contact.name
        let friendSername = contact.surname
        let friendAvatar = contact.avatar
        let friendCity = contact.city
        
        // Заполняем данные в ячейку через метод ячейки
        cellFriends.setData(city: friendCity, name: friendName, sername: friendSername, avatar: friendAvatar)
        
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
        let friend = sections[key]![indexPath.row]
        
        //Замена на передачу экземпляра класса userVK
                        /* print(indexPath.row)
                        //присваиваем массив картинок созданному массиву картинок из целевого контроллера
                        //photoController.imageFriend = friend.photo
                         */
        //передаем экземпляр класса в целевой контроллер
        photoController.profileUser = friend

        
        //вызываем метод искомого контроллера для отображения
        show(photoController, sender: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 60
    }
}
