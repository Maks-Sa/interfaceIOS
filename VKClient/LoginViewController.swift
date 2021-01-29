//
//  ViewController.swift
//  Less1
//
//  Created by Maksim Savin on 08.12.2020.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Жест нажатия
                let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                // Присваиваем его UIScrollVIew
        scrollViewStartForm?.addGestureRecognizer(hideKeyboardGesture)
        startSession()
    }
    @objc func hideKeyboard() {
            self.scrollViewStartForm?.endEditing(true)
        }

    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
            
            // Получаем размер клавиатуры
            let info = notification.userInfo! as NSDictionary
            let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
            
            // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
            self.scrollViewStartForm?.contentInset = contentInsets
            scrollViewStartForm?.scrollIndicatorInsets = contentInsets
        }
        
        //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
            // Устанавливаем отступ внизу UIScrollView, равный 0
            let contentInsets = UIEdgeInsets.zero
            scrollViewStartForm?.contentInset = contentInsets
        }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
           NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
           // Второе — когда она пропадает
           NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       }
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }

    @IBAction func buttonPressedStartForm(_ sender: Any) {
//        //Проверка нажатия
//        // Получаем текст логина
//        let login = loginInputStartForm.text!
//        // Получаем текст-пароль
//        let password = passwordInputStartForm.text!
//
//        // Проверяем, верны ли они
//        if login == "admin" && password == "123456" {
//            print("успешная авторизация")
//        } else {
//            print("неуспешная авторизация")
//        }

    }
  
    //отключим проверку входа. Расскоментировать!
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//            // Проверяем данные
//            let checkResult = checkUserData()
//            
//            // Если данные не верны, покажем ошибку
//            if !checkResult {
//                showLoginError()
//            }
//            
//            // Вернем результат
//            return checkResult
//        }
//        
//        func checkUserData() -> Bool {
//            guard let login = loginInputStartForm.text,
//                let password = passwordInputStartForm.text else { return false }
//            
//            if login == "admin" && password == "123456" {
//                return true
//            } else {
//                return false
//            }
//        }
//        
//        func showLoginError() {
//            // Создаем контроллер
//            let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
//            // Создаем кнопку для UIAlertController
//            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            // Добавляем кнопку на UIAlertController
//            alter.addAction(action)
//            // Показываем UIAlertController
//            present(alter, animated: true, completion: nil)
//        }

    func startSession (){
        let session = Session.startSession
        session.token = "Login"
    }

    @IBOutlet weak var buttonStartForm: UIButton!
    @IBOutlet weak var scrollViewStartForm: UIScrollView!
    @IBOutlet weak var loginInputStartForm: UITextField!
    @IBOutlet weak var passwordInputStartForm: UITextField!
   
}

