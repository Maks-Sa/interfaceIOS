//
//  IconSettings.swift
//  VKClient
//
//  Created by Maksim Savin on 13.01.2021.
//

import UIKit

@IBDesignable class IconSettings: UIView {
    //создаем переменные и константы иконки и тени
    var imageView = UIImageView()
    let shadowView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(tapGestureRecognizer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addGestureRecognizer(tapGestureRecognizer)
    }
    
//    // создаем переменную для радиуса 25, чтобы был круг
//    @IBInspectable  var imageRadius: CGFloat = 25.0 {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
    
    @IBInspectable var shadowRadius: CGFloat = 5.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    //создаем переменную для прозрачности
    @IBInspectable var shadowOpacity: Float = 0.6 {
        didSet {
            setNeedsDisplay()
        }
    }
    //создаем переменную для смещения
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 3) {
        didSet {
            setNeedsDisplay()
        }
    }
    //создаем переменную для цвета тени
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //настраивем иконку
        imageView.frame = rect
        imageView.layer.cornerRadius = frame.size.height / 2
        imageView.clipsToBounds = true
        

        //настраиваем тень для иконки
        shadowView.frame = rect
        shadowView.clipsToBounds = false
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowOffset = shadowOffset
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: frame.size.height / 2).cgPath

        //добавляем иконку на тень и на вью
        shadowView.addSubview(imageView)
        self.addSubview(shadowView)
    }
    
    //распознование жестов
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
            recognizer.numberOfTapsRequired = 1    // Количество нажатий, необходимое для распознавания
            recognizer.numberOfTouchesRequired = 1 // Количество пальцев, которые должны коснуться экрана для распознавания
            return recognizer
        }()

    //анимация нажатия
        @objc func onTap() {
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = transform.self
            scaleAnimation.toValue = 0.8
            scaleAnimation.duration = 0.15
            scaleAnimation.autoreverses = true
            layer.add(scaleAnimation, forKey: nil)

        }
    
}


