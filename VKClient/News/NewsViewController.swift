//
//  NewsView.swift
//  VKClient
//
//  Created by Maksim Savin on 27.01.2021.
//

import UIKit

class NewsViewController: UIViewController {
    

    @IBOutlet weak var newsTableView: UITableView!
    var newsPostsData = [NewsPost]()
    private let networkVK = NetworkManager()
    var nextFrom = ""
 
    //Предыдуща реализация. готовим данные для таблицы

//    var newsData: [News] = [
//
//        News(icon: UIImage(named: "trigunicon")!, title: "First News", timeNews: "10 min ago", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "vash1")!)),
//        News(icon: UIImage(named: "alukardicon")!, title: "Second News", timeNews: "28 Jan 2021, 02:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "alukard1")!)),
//        News(icon: UIImage(named: "wolfwood2")!, title: "Third News", timeNews: "27 Jan 2021, 22:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "wolfwood1")!)),
//        News(icon: UIImage(named: "trigunicon")!, title: "Fourth News", timeNews: "27 Jan 2021, 20:14", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "knives3")!)),
//        News(icon: UIImage(named: "meryl0")!, title: "Fifth News", timeNews: "27 Jan 2021, 12:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "meryl2")!)),
//        News(icon: UIImage(named: "milly0")!, title: "Sixth News", timeNews: "27 Jan 2021, 10:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "milly2")!)),
//        News(icon: UIImage(named: "kuroneko0")!, title: "Seventh News", timeNews: "27 Jan 2021, 09:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "kuroneko4")!)),
//        News(icon: UIImage(named: "shoavatar")!, title: "Eighth News", timeNews: "27 Jan 2021, 02:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "sho2")!)),
//        News(icon: UIImage(named: "nagisa0")!, title: "Ninth News", timeNews: "25 Jan 2021, 22:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "nagisa2")!)),
//        News(icon: UIImage(named: "tomoya0")!, title: "Tenth News", timeNews: "25 Jan 2021, 12:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "tomoya1")!)),
//        News(icon: UIImage(named: "sakagami0")!, title: "Eleventh News", timeNews: "25 Jan 2021, 09:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "sakagami1")!)),
//        News(icon: UIImage(named: "raizel0")!, title: "Twelfth News", timeNews: "24 Jan 2021, 22:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "raizel2")!)),
//        News(icon: UIImage(named: "franke0")!, title: "Thirteenth News", timeNews: "23 Jan 2021, 22:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "franke2")!)),
//        News(icon: UIImage(named: "muzaka0")!, title: "Fourteenth News", timeNews: "22 Jan 2021, 22:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "muzaka2")!)),
//        News(icon: UIImage(named: "ichiavatar")!, title: "Fifteenth News", timeNews: "22 Jan 2021, 12:11", info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", photo: PhotoAlbum(photo: UIImage(named: "ichi3")!))
//
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        //регистрируем кастомную ячейку
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "customNewsCell")
        newsTableView.register(UINib(nibName: "NewsPostCell", bundle: nil), forCellReuseIdentifier: "newsPostCell")
        
        //вызов функции загрузки ленты новостей
        getNews()
        
    }

    //загрузка ленты новостей, тип Post
    func getNews() {
        networkVK.getNewsFeed(type: .post) { [weak self] (news) in
            DispatchQueue.main.async {
                self?.newsPostsData = news
                self?.newsTableView.reloadData()
            }
        }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsPostsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //Получаем ячейку
        let cellNews = tableView.dequeueReusableCell(withIdentifier: "customNewsCell", for: indexPath ) as! NewsCell
        let news = newsPostsData[indexPath.row]
        

        cellNews.news = news
        cellNews.indexCell = indexPath.row
        networkVK.getImage(by: news.avatarUrl) { (image) in
            cellNews.iconNews.imageView.image = image
        }
        cellNews.titleNews.text = news.name
        cellNews.timeNews.text = cellNews.dateToString(date: news.date)
        cellNews.postNews.text = news.text
        
        //проверяем, есть ли картинка в новости
        if let imageUrl = news.attachments?.first?.url{
            networkVK.getImage(by: imageUrl) { (image) in
                cellNews.imageNews.image = image
            }
        }
        cellNews.isLiked = news.isLiked
        cellNews.setLikes(likesCount: news.likesCount)
        cellNews.setShareCount(shareCount: news.repostsCount)
        cellNews.setCommCount(commCount: news.commentsCount)
        if let count = news.viewsCount {
            cellNews.setViewCount(viewCount: count)
        }
        return cellNews
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}
