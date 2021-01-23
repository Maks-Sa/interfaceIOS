//
//  AllGroupsView.swift
//  VKClient
//
//  Created by Maksim Savin on 24.12.2020.
//

import UIKit

class AllGroupsView: UIViewController {
   
    public var cellAllGroups = AllGroupsCell()

    @IBOutlet public weak var tableAllView: UITableView!
    // Готовим данные для таблицы
    var allGroupsData: [groupsVK] = [(groupsVK(nameGroup: "Burger king", iconGroup: UIImage(named: "bk0")!,infoGroup: "Готовим 100% говядину на огне")),
                                     (groupsVK(nameGroup: "GeekBrains", iconGroup: UIImage(named: "gb0")!, infoGroup: "Учись, развивайся, стажируйся, зарабатывай!")),
                                     (groupsVK(nameGroup: "MARVEL/DC", iconGroup: UIImage(named: "md0")!, infoGroup: "Только уникальный контент")),
                                     (groupsVK(nameGroup: "СЛОТ", iconGroup: UIImage(named: "slot")!, infoGroup: "Слот» — российская альтернативная рок-группа ")),
                                     (groupsVK(nameGroup: "Федерация регби Санкт-Петербурга", iconGroup: UIImage(named: "rugby")!, infoGroup: "Все о петербургском регби")),
                                     (groupsVK(nameGroup: "Кованые топоры | УРМ «АНИКА»", iconGroup: UIImage(named: "anika")!, infoGroup: "Топоры")),
                                     (groupsVK(nameGroup: "BIG GEEK", iconGroup: UIImage(named: "biggeek")!, infoGroup: "Гаджеты, фильмы, сериалы, игры. Без ерунды.")),
                                     (groupsVK(nameGroup: "ДТП и ЧП | Санкт-Петербург | Питер Онлайн | СПб ", iconGroup: UIImage(named: "dtp")!, infoGroup: "Происшествия Санкт-Петербурга 24 часа в сутки, 7 дней в неделю, 365 дней в году.")),
                                     (groupsVK(nameGroup: "Мир Discovery", iconGroup: UIImage(named: "discovery")!, infoGroup: "Весь мир как на ладони")),
                                     (groupsVK(nameGroup: "HookahMarket»", iconGroup: UIImage(named: "hokahmarket")!, infoGroup: "")),
                                     (groupsVK(nameGroup: "E.squirе»", iconGroup: UIImage(named: "esquire")!, infoGroup: "Умный журнал для успешных людей!")),
                                     (groupsVK(nameGroup: "AUTO»", iconGroup: UIImage(named: "auto")!, infoGroup: "1 500 000 Автомобилистов уже с нами ;)")),
                                     (groupsVK(nameGroup: "Wylsacom", iconGroup: UIImage(named: "wylsa")!, infoGroup: "Смотрите новый видос!"))
                                   
                                    
                            
    ]
 
    
   
    @IBOutlet weak var allGroupsView: UITableView!
    
    var sections: [String: [groupsVK]] = [:]
    var keys: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allGroupsView.delegate = self
        allGroupsView.dataSource = self
        
        allGroupsData.forEach { contact in
            let firstLetter = String(contact.nameGroup.first!)
            if sections[firstLetter] != nil {
                sections[firstLetter]!.append(contact)
            } else {
                sections[firstLetter] = [contact]
            }
        }
        keys = Array(sections.keys).sorted(by: <)
    }
}
    
extension AllGroupsView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    return allGroupsData.count
        let key = keys[section]
        let count = sections[key]!.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Получаем ячейку
          cellAllGroups = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupsCell
        let key = keys[indexPath.section]
        let contact = sections[key]![indexPath.row]
        
       // Присваиваем константам значения из массива данных
//          let groupName = allGroupsData[indexPath.row].nameGroup
//          let groupInfo = allGroupsData[indexPath.row].infoGroup
//          let groupIcon = allGroupsData[indexPath.row].iconGroup
          
        let groupName = contact.nameGroup
        let groupInfo = contact.infoGroup
        let groupIcon = contact.iconGroup
          // Заполняем данные в ячейку через метод ячейки
          cellAllGroups.setData(groupName: groupName, groupInfo: groupInfo, groupIcon: groupIcon)
   
       
          return cellAllGroups
    }
    
        
   
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
