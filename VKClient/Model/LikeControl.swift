//
//  LikeControl.swift
//  VKClient
//
//  Created by Maksim Savin on 14.01.2021.
//

import UIKit

@IBDesignable class LikeControl: UIControl {

    var totalCount: Int = 0 {
        didSet {
            //обновляем кол-во лайком
            button.setTitle("\(totalCount)", for: .normal)
            print("text")
        }
    }
    
    var isLiked: Bool = false {
        didSet {
            //обновляем картинку сердца
            button.setImage(isLiked ? self.likedImage : self.unlikedImage, for: .normal)
            print("pict")
        }
    }
    
    private var button = UIButton(type: .custom)
//    private let unlikedImage = UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal)
//    private let likedImage = UIImage(named: "likeheart")?.withRenderingMode(.alwaysTemplate)
    private let unlikedImage = UIImage(systemName: "heartgrey")?.withRenderingMode(.alwaysOriginal)
    private let likedImage = UIImage(systemName: "likeheart")?.withRenderingMode(.alwaysTemplate)
    @IBInspectable private let unlikedScale: CGFloat = 0.8
    @IBInspectable private let likedScale: CGFloat = 1.2
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        print("init")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
        print("fatal")
    }
    
    func setupView(){
        
        self.addSubview(button)
        
        //настройки
        button.setImage(UIImage(named: "likeheart"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .red
        //добавляем таргет при нажатии на контрол
        button.addTarget(self, action: #selector(tapControl(_:)), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        print("setting")
        
        //слева
        button.frame = self.bounds
        button.contentHorizontalAlignment = .leading
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.contentEdgeInsets.left = 10
        print("left")
        print ("button x=\(button.frame.minX) y= \(button.frame.minY) width=\(button.frame.width) height=\(button.frame.height)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //обработчик нажатия на контрол
    @objc private func tapControl(_ sender: UIButton) {
        isLiked.toggle()
        totalCount = isLiked ? (totalCount + 1) : (totalCount - 1)
        animate()
        print("tap")
        //отправлеем экшн "наружу"
        self.sendActions(for: .valueChanged)
    }
    
    
    //MARK: - анимация
    private func animate() {
        print("anim")
        UIView.animate(withDuration: 0.1, animations: {
            let newImage = self.isLiked ? self.likedImage : self.unlikedImage
            let newScale = self.isLiked ? self.likedScale : self.unlikedScale
            self.button.transform = self.transform.scaledBy(x: newScale, y: newScale)
            self.button.setImage(newImage, for: .normal)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.button.transform = CGAffineTransform.identity
            
            })
        })
    }
    
    
    
}

