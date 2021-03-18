//
//  MyGroupsView.swift
//  VKClient
//
//  Created by Maksim Savin on 25.12.2020.
//

import UIKit

class MyGroupsView: UIViewController {
    
    @IBOutlet weak var myGroupsView: UITableView!
    @IBOutlet weak var myGroupsSearch: UISearchBar!
    //    var myGroupsData: [groupsVK] = [groupsVK]()
    //var myGroupsData: [groupsVK] = [(groupsVK(nameGroup: "Burger king", iconGroup: UIImage(named: "bk0")!,infoGroup: "Готовим 100% говядину на огне"))]
    var myGroupsData: [Groups] = []
    private let networkVK = NetworkManager()
    //ключ для словаря
    var keys: [String] = []
    //словарь для индексации таблицы
    var groupsDict = [String: [Groups]]()
    //словарь для поиска
    var filteredGroupsDict = [String: [Groups]]()
   
//    MARK  добавление групп
//    @IBAction func addGroup(segue: UIStoryboardSegue) {
//        // Проверяем идентификатор, чтобы убедиться, что это нужный переход
//        if segue.identifier == "addGroup" {
//            // Получаем ссылку на контроллер, с которого осуществлен переход
//            let allGroupsView = segue.source as! AllGroupsView
//            // Получаем индекс выделенной ячейки
//
//            if let indexPath = allGroupsView.allGroupsView.indexPathForSelectedRow  {
//                // Получаем группу по индексу
//
//                let key = allGroupsView.keys[indexPath.section]
//                let contact = allGroupsView.dictSearch[key]![indexPath.row]
//                //let group = allGroupsView.allGroupsData[indexPath.row]
//
//                // Проверяем, что такой группы нет в списке
//                //                if !self.myGroupsData.contains(group) {
//                //                    // Добавляем группу в список выбранных
//                //                    myGroupsData.append(group)
//                //                    // Обновляем таблицу
//                //                    myGroupsView.reloadData()
//                //                   }
//                //                    if !self.myGroupsData.contains(contact) {
//                //                    // Добавляем группу в список выбранных
//                //                    myGroupsData.append(contact)
//                // Обновляем таблицу
//                //                    myGroupsView.reloadData()
//                //                   }
//            }
//        }
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myGroupsView.delegate = self
        myGroupsView.dataSource = self
        myGroupsSearch.delegate = self
        getData()
        
    }
    
    func getData() {
        networkVK.getGroups(for: Session.startSession.userID!, handler: {[weak self] groups in
            DispatchQueue.main.async {
                self?.myGroupsData = groups
                (self!.keys, self!.filteredGroupsDict) = self!.prepareForSections(for: groups)
                self?.groupsDict = self!.filteredGroupsDict
                try? Database.save(items: groups)
                self?.myGroupsView.reloadData()
      
                
//                dump("view= \(self?.myGroupsData)")
//                dump("view2= \(self?.filteredGroupsDict)")
//                dump("view3= \(self?.keys)")
            }
        })
    }
    
    private func prepareForSections(for inputArray: [Groups]) -> ([String], [String: [Groups]]) {
        var sectionsTitle = [String]()
        var sectionData = [String: [Groups]]()
        
        //разбираем исходный массив в словарь для индексации таблицы
        for group in inputArray {
            let groupNameKey = String(group.nameGroup.prefix(1))
            if var groupValues = sectionData[groupNameKey] {
                groupValues.append(group)
                sectionData[groupNameKey] = groupValues
            } else {
                sectionData[groupNameKey] = [group]
            }
        }
        //сортируем по алфавиту
        sectionsTitle = [String](sectionData.keys).sorted(by: <)
        return (sectionsTitle, sectionData)
        
    }
    
}
extension MyGroupsView: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        dump("для поиска= \(filteredGroupsDict)")
        return filteredGroupsDict.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Определяем кол-во секций
        let key = keys[section]
        let count = filteredGroupsDict[key]!.count
        return count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Определяем ячейку
        let cellMyGroups = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsCell
        let key = keys[indexPath.section]
        let group = filteredGroupsDict[key]![indexPath.row]
//        dump("key= \(key)")
//        dump("indexpath.row= \(indexPath.row)")
//        dump("group= \(group)")
        //Присваиваем данные из массива
        
        let groupName = group.nameGroup
        let groupInfo = group.descrGroup
        var groupIcon: UIImage?
        networkVK.getImage(by: group.avatarURLGroup) { (image) in
            groupIcon = image
        }
        
        // Заполняем данные в ячейку через метод ячейки
        cellMyGroups.setData(groupName: groupName, groupInfo: groupInfo, groupIcon: groupIcon!)
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText != "" else {
            filteredGroupsDict = groupsDict
            keys = [String] (filteredGroupsDict.keys).sorted(by: <)
            myGroupsView.reloadData()
            return
        }
        filteredGroupsDict = groupsDict.mapValues{
            $0.filter{
                $0.nameGroup.lowercased().contains(searchText.lowercased()) ||
                    $0.screenNameGroup.lowercased().contains(searchText.lowercased())
            }
        }.filter {!$0.value.isEmpty}
        keys = [String] (filteredGroupsDict.keys).sorted(by: <)
        myGroupsView.reloadData()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        myGroupsSearch.endEditing(true)
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        myGroupsSearch.endEditing(true)
    }
}


