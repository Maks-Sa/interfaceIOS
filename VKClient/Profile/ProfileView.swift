//
//  ProfileView.swift
//  VKClient
//
//  Created by Maksim Savin on 25.03.2021.
//

import UIKit

class ProfileView: UIViewController {

    private let networkVK = NetworkManager()
    private var userProfile: [User] = []
    let userId: Int = 0
    
    @IBOutlet weak var profileTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        getRealmData()
        profileTableView.register(UINib(nibName: "ProfileUserCell", bundle: nil), forCellReuseIdentifier: "profileCell")
        
        
    }
    
    func getRealmData(){
        networkVK.getUserProfile(for: Session.startSession.userID!, handler: {[weak self] users in
            DispatchQueue.main.async {
                dump("profile = \(users)")
                self?.userProfile = Array (try! Database.load(typeOF: User.self))
                self?.profileTableView.reloadData()
            }
        })
    }
    
}

extension ProfileView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProfile.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Получаем ячейку
        let cellProfile = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileUserCell
        
        self.navigationItem.title = "\(userProfile[0].screenName)"
        // Присваиваем константам значения из массива данных
        let firstName = userProfile[0].firstName
        let lastName = userProfile[0].lastName
        let sex = userProfile[0].sex
        let bDay = userProfile[0].bDateUser
        let aboutUser = userProfile[0].aboutUser
        var avatarUser: UIImage?
//        Получаем картинку
        networkVK.getImage(by: userProfile[0].avatarUserUrl) { (image) in
            avatarUser = image
        }
        cellProfile.setData(sex: sex, bDay: bDay, aboytMyself: aboutUser, lastName: lastName, name: firstName, avatar: avatarUser!)
        
        
        
        return cellProfile
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
