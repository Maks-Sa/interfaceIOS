//
//  AllGroupsView.swift
//  VKClient
//
//  Created by Maksim Savin on 24.12.2020.
//

import UIKit

class AllGroupsView: UIViewController {
   
    
   
    @IBOutlet weak var allGroupsView: UITableView!
    @IBOutlet weak var allGroupsSearch: UISearchBar!
    
    public var cellAllGroups = AllGroupsCell()
    var allGroupsData: [Groups] = []
    private let networkVK = NetworkManager()
    //ключ для словаря
    var keys: [String] = []
    //словарь для индексации таблицы
    private var groupsDict = [String: [Groups]]()
    //словарь для поиска
    var filteredGroupsDict = [String: [Groups]]()
    private var srchGroup: [SrchGroups] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allGroupsView.delegate = self
        allGroupsView.dataSource = self
        allGroupsSearch.delegate = self
        

        
    }
 
    func getData(searchText: String) {
        clearTables()
        networkVK.searchGroup(request: searchText, handler: {[weak self] groups in
            DispatchQueue.main.async {
                groups.forEach({self?.allGroupsData.append($0.toGroups())})
               // self?.allGroupsData = groups.forEach({srchGroup.append($0.toGroups())})
                
                (self!.keys, self!.filteredGroupsDict) = self!.prepareForSections(for: self?.allGroupsData ?? [Groups]())
                self?.groupsDict = self!.filteredGroupsDict
                self?.allGroupsView.reloadData()
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
  
    private func clearTables(){
        allGroupsData.removeAll()
        groupsDict.removeAll()
        filteredGroupsDict.removeAll()
    }
    
}
    
extension AllGroupsView: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredGroupsDict.count
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
        let count = filteredGroupsDict[key]!.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Получаем ячейку
          cellAllGroups = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupsCell
        let key = keys[indexPath.section]
        let group = filteredGroupsDict[key]![indexPath.row]
        
       // Присваиваем константам значения из массива данных
//          let groupName = allGroupsData[indexPath.row].nameGroup
//          let groupInfo = allGroupsData[indexPath.row].infoGroup
//          let groupIcon = allGroupsData[indexPath.row].iconGroup
          
        let groupName = group.nameGroup
        let groupInfo = group.descrGroup
        var groupIcon: UIImage?
        networkVK.getImage(by: group.avatarURLGroup) { (image) in
            groupIcon = image
        }
          // Заполняем данные в ячейку через метод ячейки
          cellAllGroups.setData(groupName: groupName, groupInfo: groupInfo, groupIcon: groupIcon!)
   
       
          return cellAllGroups
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    //Реализация поиска
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard (searchText != "" && searchText != nil) else {
            clearTables()
            filteredGroupsDict = groupsDict
            keys = [String] (filteredGroupsDict.keys).sorted(by: <)
            allGroupsView.reloadData()
            return
        }
//        dump(searchText)
        getData(searchText: searchText)
            filteredGroupsDict = groupsDict.mapValues{
                $0.filter{
                    $0.nameGroup.lowercased().contains(searchText.lowercased()) ||
                        $0.screenNameGroup.lowercased().contains(searchText.lowercased())
                }
            }.filter {!$0.value.isEmpty}
        keys = [String] (filteredGroupsDict.keys).sorted(by: <)
        allGroupsView.reloadData()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        allGroupsSearch.endEditing(true)
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        allGroupsSearch.endEditing(true)
    }
}
