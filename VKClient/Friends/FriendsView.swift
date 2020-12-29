//
//  FriendsView.swift
//  VKClient
//
//  Created by Maksim Savin on 27.12.2020.
//

import UIKit

class FriendsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Готовим данные для таблицы
    var friendsData: [userVK] = [
        (userVK(name: "Vash", sername: "the Stampede", avatar: UIImage(named: "trigunicon")!, photo: [UIImage(named: "trigunimage")!, UIImage(named: "vash1")!, UIImage(named: "vash2")!, UIImage(named: "vash3")!, UIImage(named: "vash4.jpg")!, UIImage(named: "vash5.jpg")!], gender: .male, idGroup: 1, city: "Gunsmoke")),
        (userVK(name: "Alukard", sername: "Lord", avatar: UIImage(named: "alukardicon")!, photo: [UIImage(named: "alukardimage")!, UIImage(named: "alukard1")!, UIImage(named: "alukard2")!, UIImage(named: "alukard3")!, UIImage(named: "alukard4")!], gender: .male, idGroup: 1, city: "Valahia")),
        (userVK(name: "Nicholas D.", sername: "Wolfwood", avatar: UIImage(named: "wolfwood1")!, photo: [UIImage(named: "wolfwood2")!, UIImage(named: "wolfwood3")!], gender: .male , idGroup: 1, city: "Evergreen")),
        (userVK(name: "Knives", sername: "Millions", avatar: UIImage(named: "knivesavatar")!, photo: [UIImage(named: "knives1")!, UIImage(named: "knives2")!, UIImage(named: "knives3")!, UIImage(named: "knives4")!], gender: .male , idGroup: 1, city: "Gunsmoke")),
        (userVK(name: "Meryl", sername: "Stryfe", avatar: UIImage(named: "meryl0")!, photo: [UIImage(named: "meryl1")!, UIImage(named: "meryl2")!, UIImage(named: "meryl3")!], gender: .female , idGroup: 1, city: "Gunsmoke")),
        (userVK(name: "Milly", sername: "Thompson", avatar: UIImage(named: "milly0")!, photo: [UIImage(named: "milly1")!, UIImage(named: "milly2")!, UIImage(named: "milly3")!], gender: .female , idGroup: 1, city: "Gunsmoke")),
        (userVK(name: "Kuroneko", sername: "- sama", avatar: UIImage(named: "kuroneko0")!, photo: [UIImage(named: "kuroneko1")!, UIImage(named: "kuroneko4")!, UIImage(named: "kuroneko3")!], gender: .female , idGroup: 1, city: "Gunsmoke")),
        (userVK(name: "Sho", sername: "Cheon", avatar: UIImage(named: "shoavatar")!, photo: [UIImage(named: "sho1")!, UIImage(named: "sho2")!, UIImage(named: "sho3")!], gender: .female , idGroup: 1, city: "Gunsmoke")),
        (userVK(name: "Ichigo", sername: "Kurosaki", avatar: UIImage(named: "ichiavatar")!, photo: [UIImage(named: "ichi1")!, UIImage(named: "ichi2")!, UIImage(named: "ichi3")!, UIImage(named: "ichi4")!, UIImage(named: "ichi5")!], gender: .male, idGroup: 1, city: "Karakura"))
    ]
    
  
    
    @IBOutlet weak var friendsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsTableView.delegate = self
        friendsTableView.dataSource = self

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Получаем ячейку
        let cellFriends = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
        // Присваиваем константам значения из массива данных
        let friendName = friendsData[indexPath.row].name
        let friendSername = friendsData[indexPath.row].sername
        let friendAvatar = friendsData[indexPath.row].avatar
        let friendCity = friendsData[indexPath.row].city
        
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
        let friend = friendsData[indexPath.row]
        
        //присваиваем массив картинок созданному массиву картинок из целевого контроллера
        photoController.imageFriend = friend.photo
        
        //вызываем метод искомого контроллера для отображения
        show(photoController, sender: nil)
    }

}
