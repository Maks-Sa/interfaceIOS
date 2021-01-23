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
    //Замена на передачу экземпляра класса userVK возможно понадобятся другие данные
            /*   //создаем пустой массив картинок для приема из другого контроллера
            var imageFriend: [UIImage]? = []
             */
    //создаем объект класса (профиль) для приема из другого контроллера
    var profileUser: userVK = userVK()


    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        //назначаем заголовок экрана из профиля
        self.navigationItem.title = "\(profileUser.name)  \(profileUser.surname)"

        //регистрируем кастомную ячейку
        photoCollectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "customImgCell")

    }

}
extension PhotoFriendsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //определяем колличство секций
                //let sections = imageFriend?.count //вариант через массив картинок
        let sections = profileUser.photo!.count
        return sections
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Получаем ячейку
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customImgCell", for: indexPath) as! ImageCell
        cell.userVK = profileUser
        cell.indexCell = indexPath.row
        //Замена на передачу экземпляра класса userVK возможно понадобятся другие данные
               /* // Заполняем данные из массива картинок в ячейку через метод ячейки
                // cell.setData(photo: imageFriend![indexPath.row])
                 */

        // создадим константы для передачи в ячейку
        let photo = profileUser.photo![indexPath.row].photo!
        let isLike = profileUser.photo![indexPath.row].isLiked
        let lakeCount = profileUser.photo![indexPath.row].totalCount
        // Заполняем данные из массива фото профиля пользователя(объект класса) в ячейку через метод ячейки
        cell.setData(photo: photo, isLike: isLike, likeCount: lakeCount)

//        cell.setData(photo: profileUser.photo![indexPath.row].photo!)
//        cell.setLikes(countOfLikes: profileUser.photo![indexPath.row].totalCount)
//        cell.setIsLiked(bool: profileUser.photo![indexPath.row].isLiked)
//        cell.setData(photo: profileUser.photo![indexPath.row].photo!, isLike: profileUser.photo![indexPath.row].isLiked, likeCount: profileUser.photo![indexPath.row].totalCount)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32) * 9 / 16
        return CGSize(width: view.frame.width - 16, height: height + 94)

    }




}

