//
//  PhotoFriendsView.swift
//  VKClient
//
//  Created by Maksim Savin on 28.12.2020.
//

import UIKit

class PhotoFriendsView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

    @IBOutlet weak var photoCollectionView: UICollectionView!
    //создаем пустой массив картинок для приема из другого контроллера
    var imageFriend: [UIImage]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //определяем колличство секций
        let sections = imageFriend?.count
        return sections!
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Получаем ячейку
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoFriendsCell
        
        // Заполняем данные из массива картинок в ячейку через метод ячейки
        cell.setData(photo: imageFriend![indexPath.row])

        return cell
    }

   
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32) * 9 / 16
       
        return CGSize(width: view.frame.width - 16, height: height + 94)
       
    }

    

   
}

