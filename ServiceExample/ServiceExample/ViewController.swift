//
//  ViewController.swift
//  ServiceExample
//
//  Created by Eugene Berezin on 12/28/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func onSendPostTapped(_ sender: Any) {
        // create url
        guard let urlString = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return }
        
        //create request
        var request = URLRequest(url: urlString)
        //specify http methid
        request.httpMethod = "POST"
        //add value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //create object that you want to send
        let newPost  = Post(body: "This is new post", id: 122, title: "This is my title", userId: 999)
        
        //encode
        do {
            let jsonBody = try JSONEncoder().encode(newPost)
            request.httpBody = jsonBody
            
        } catch {}
        
        //url session
        let session = URLSession.shared
        
        // create the task
        let task = session.dataTask(with: request) { (data, _, err) in
            if let err = err {
                print(err)
            }
            guard let data = data else {return}
            
            do {
                let sentPost = try JSONDecoder().decode(Post.self, from: data)
                print(sentPost)
            } catch {}
        }
        
        task.resume()
        
        
        
    }
    
    @IBAction func onGetPostTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

