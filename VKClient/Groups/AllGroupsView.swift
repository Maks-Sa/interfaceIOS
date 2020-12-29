//
//  AllGroupsView.swift
//  VKClient
//
//  Created by Maksim Savin on 24.12.2020.
//

import UIKit

class AllGroupsView: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    public var cellAllGroups = AllGroupsCell()

    @IBOutlet public weak var tableAllView: UITableView!
    // Готовим данные для таблицы
    var allGroupsData: [groupsVK] = [(groupsVK(nameGroup: "Burger king", iconGroup: UIImage(named: "bk0")!,infoGroup: "Готовим 100% говядину на огне")),
                                     (groupsVK(nameGroup: "GeekBrains", iconGroup: UIImage(named: "gb0")!, infoGroup: "Учись, развивайся, стажируйся, зарабатывай!")),
                                     (groupsVK(nameGroup: "MARVEL/DC", iconGroup: UIImage(named: "md0")!, infoGroup: "Только уникальный контент")),
                                     (groupsVK(nameGroup: "СЛОТ", iconGroup: UIImage(named: "sloticon")!, infoGroup: "Слот» — российская альтернативная рок-группа ")),
                                     (groupsVK(nameGroup: "Федерация регби Санкт-Петербурга", iconGroup: UIImage(named: "rugby")!, infoGroup: "Все о петербургском регби")),
                                     (groupsVK(nameGroup: "Кованые топоры | УРМ «АНИКА»", iconGroup: UIImage(named: "anika")!, infoGroup: "Топоры")),
                                     (groupsVK(nameGroup: "BIG GEEK»", iconGroup: UIImage(named: "biggeek")!, infoGroup: "Гаджеты, фильмы, сериалы, игры. Без ерунды."))
    ]
 
    
   
    @IBOutlet weak var allGroupsView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allGroupsView.delegate = self
        allGroupsView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroupsData.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // Получаем ячейку
        cellAllGroups = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupsCell
     // Присваиваем константам значения из массива данных
        let groupName = allGroupsData[indexPath.row].nameGroup
        let groupInfo = allGroupsData[indexPath.row].infoGroup
        let groupIcon = allGroupsData[indexPath.row].iconGroup
        
        // Заполняем данные в ячейку через метод ячейки
        cellAllGroups.setData(groupName: groupName, groupInfo: groupInfo, groupIcon: groupIcon)
 
     
        return cellAllGroups
        
        
    }



}
