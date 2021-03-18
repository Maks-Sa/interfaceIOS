//
//  PhotoFriendsView.swift
//  VKClient
//
//  Created by Maksim Savin on 28.12.2020.
//

import UIKit

class PhotoFriendsView: UIViewController {

//   let width = UIScreen.main.bounds.size.width


    @IBOutlet weak var photoCollectionView: UICollectionView!
    //создаем объект класса (профиль) для приема из другого контроллера
    var profileUser = User()
    private var userPhoto: [UserPhoto] = []
    private let networkVK = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        //назначаем заголовок экрана из профиля
        self.navigationItem.title = "\(profileUser.firstName)  \(profileUser.lastName)"

        //регистрируем кастомную ячейку
        photoCollectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "customImgCell")
        
        // получение данных через API
        getData()
        
    }

    func getData() {
        networkVK.getUserPhoto(for: profileUser.id, handler: { [weak self] userPhoto in
            DispatchQueue.main.async {
                self?.userPhoto = userPhoto
//                dump("view = \(self?.userPhoto)")
                try? Database.save(items: userPhoto)
                self?.photoCollectionView.reloadData()
            }
        })
    }
}
extension PhotoFriendsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //определяем колличство секций
        let sections = userPhoto.count
//        dump("sections from view \(sections)")
        return sections
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Получаем ячейку
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customImgCell", for: indexPath) as! ImageCell
        cell.userPhoto = userPhoto[indexPath.row]

        // создадим константы для передачи в ячейку
// MARK реализовать выбор фото с необходимым разрешением.
//        let photoURL = userPhoto[indexPath.row].sizesPhoto[3].urlPhoto
//
        let photoURL = userPhoto[indexPath.row].sizesPhoto[0].urlPhoto
        var photo: UIImage?
        //Получаем картинку
        networkVK.getImage(by: photoURL) { (image) in
            photo = image
        }
        let isLike = userPhoto[indexPath.row].likesPhoto!.isLiked
        let likesCount = userPhoto[indexPath.row].likesPhoto!.likesCount

        // Заполняем данные из массива фото профиля пользователя(объект класса) в ячейку через метод ячейки
        cell.setData(photo: photo!, isLike: isLike, likesCount: likesCount)


        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32) * 9 / 16
        return CGSize(width: view.frame.width - 16, height: height + 94)

    }




}

