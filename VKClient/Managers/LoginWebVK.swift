//
//  LoginWebVK.swift
//  VKClient
//
//  Created by Maksim Savin on 09.02.2021.
//

import UIKit
import WebKit

class LoginWebVK: UIViewController {

    @IBOutlet weak var VKWebView: WKWebView!{
        didSet{
            VKWebView.navigationDelegate = self
        }
    }
    var urlComponents = URLComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7752483"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
         //   URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "scope", value: "270342"),
//            URLQueryItem(name: "scope", value: "wall"),
//            URLQueryItem(name: "scope", value: "friends"),
//            URLQueryItem(name: "scope", value: "offline"),
//            URLQueryItem(name: "scope", value: "photos"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.145")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
 
        
        delCookie()
        VKWebView.load(request)
    }
    

    func delCookie(){
        let dataStore = WKWebsiteDataStore.default()
            dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
                for record in records {
                    if record.displayName.contains("vk") {
                        dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {
                        })
                    }
                }
            }
    }

}

extension LoginWebVK: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        let userID = params["user_id"]
        
        Session.startSession.token = params["access_token"]
        Session.startSession.userID = Int(params["user_id"]!)
        
        print("Token = \(token!)")
        print("UserID = \(userID!)")
        
        
        decisionHandler(.cancel)
        
        performSegue(withIdentifier: "ToTabBar", sender: nil)
    }
}


