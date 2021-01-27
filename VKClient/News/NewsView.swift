//
//  NewsView.swift
//  VKClient
//
//  Created by Maksim Savin on 27.01.2021.
//

import UIKit

class NewsView: UIViewController {
    

    @IBOutlet weak var newsTableView: UITableView!

    //готовим данные для таблицы
    
    var newsData: [News] = [
        
        News(title: "First News", timeNews: "10 min ago", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "vash1")!)),
        News(title: "Second News", timeNews: "28 Jan 2021, 02:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "alukard1")!)),
        News(title: "Third News", timeNews: "27 Jan 2021, 22:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "wolfwood1")!)),
        News(title: "Fourth News", timeNews: "27 Jan 2021, 20:14", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "knives3")!)),
        News(title: "Fifth News", timeNews: "27 Jan 2021, 12:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "meryl2")!)),
        News(title: "Sixth News", timeNews: "27 Jan 2021, 10:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "milly2")!)),
        News(title: "Seventh News", timeNews: "27 Jan 2021, 09:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "kuroneko4")!)),
        News(title: "Eighth News", timeNews: "27 Jan 2021, 02:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "sho2")!)),
        News(title: "Ninth News", timeNews: "25 Jan 2021, 22:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "nagisa2")!)),
        News(title: "Tenth News", timeNews: "25 Jan 2021, 12:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "tomoya1")!)),
        News(title: "Eleventh News", timeNews: "25 Jan 2021, 09:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "sakagami1")!)),
        News(title: "Twelfth News", timeNews: "24 Jan 2021, 22:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "raizel2")!)),
        News(title: "Thirteenth News", timeNews: "23 Jan 2021, 22:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "franke2")!)),
        News(title: "Fourteenth News", timeNews: "22 Jan 2021, 22:11", info: "Cъешь ещё этих мягких французских булок, да выпей чаю.", photo: PhotoAlbum(photo: UIImage(named: "muzaka2")!))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self


        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "customNewsCell")
    }

}

extension NewsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNews = tableView.dequeueReusableCell(withIdentifier: "customNewsCell", for: indexPath ) as! NewsCell
        let news = newsData[indexPath.row]
        let titleNews = news.title
        let timeNews = news.timeNews
        let infoNews = news.info
        let photoNews = news.photo.photo
        
        cellNews.setData(titleNews: titleNews, timeNews: timeNews, infoNews: infoNews, photo: photoNews!, isLike: news.photo.isLiked, likeCount: news.photo.totalCount, commCount: news.commentCount, shareCount: news.share, viewCount: news.view)
        
        return cellNews
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    

    
    
    
}
