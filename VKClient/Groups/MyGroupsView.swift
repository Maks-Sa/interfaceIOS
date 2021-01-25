//
//  MyGroupsView.swift
//  VKClient
//
//  Created by Maksim Savin on 25.12.2020.
//

import UIKit

class MyGroupsView: UIViewController {
   
    @IBOutlet weak var myGroupsView: UITableView!
    var myGroupsData: [groupsVK] = [groupsVK]()

    
  @IBAction func addGroup(segue: UIStoryboardSegue) {
        // Проверяем идентификатор, чтобы убедиться, что это нужный переход
        if segue.identifier == "addGroup" {
            // Получаем ссылку на контроллер, с которого осуществлен переход
            let allGroupsView = segue.source as! AllGroupsView
            // Получаем индекс выделенной ячейки
            
            if let indexPath = allGroupsView.allGroupsView.indexPathForSelectedRow  {
                // Получаем группу по индексу
                
                let key = allGroupsView.keys[indexPath.section]
                let contact = allGroupsView.dictSearch[key]![indexPath.row]
                //let group = allGroupsView.allGroupsData[indexPath.row]
              
                // Проверяем, что такой группы нет в списке
//                if !self.myGroupsData.contains(group) {
//                    // Добавляем группу в список выбранных
//                    myGroupsData.append(group)
//                    // Обновляем таблицу
//                    myGroupsView.reloadData()
//                   }
                    if !self.myGroupsData.contains(contact) {
                    // Добавляем группу в список выбранных
                    myGroupsData.append(contact)
                    // Обновляем таблицу
                    myGroupsView.reloadData()
                   }
                }
            }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myGroupsView.delegate = self
        myGroupsView.dataSource = self
    }
}
extension MyGroupsView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Определяем кол-во секций
        return myGroupsData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Определяем ячейку
        let cellMyGroups = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsCell
        
        //Присваиваем данные из массива
        let groupName = myGroupsData[indexPath.row].nameGroup
        let groupInfo = myGroupsData[indexPath.row].infoGroup
        let groupIcon = myGroupsData[indexPath.row].iconGroup
        
        // Заполняем данные в ячейку через метод ячейки
        cellMyGroups.setData(groupName: groupName, groupInfo: groupInfo, groupIcon: groupIcon)
        return cellMyGroups
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Если была нажата кнопка «Удалить»
        if editingStyle == .delete {
            
            // Удаляем группу из массива
            myGroupsData.remove(at: indexPath.row)
            
            // И удаляем строку из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
           
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 60
    }
}
