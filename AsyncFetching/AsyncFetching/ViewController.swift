//
//  ViewController.swift
//  AsyncFetching
//
//  Created by Eugene Berezin on 1/1/20.
//  Copyright © 2020 Eugene Berezin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
                   let data = try fetchSomethingAsyncAwait()
                   let s = String(decoding: data!, as: UTF8.self)
                   print("Data:", s)
               } catch {
                   print("Failed to fetch stuff:", error)
                   return
               }
               
               do {
                   let data = try fetchSomethingAsyncAwait()
                   let s = String(decoding: data!, as: UTF8.self)
                   print("Data:", s)
               } catch {
                   print("Failed to fetch stuff:", error)
                   return
               }
               
               do {
                   let data = try fetchSomethingAsyncAwait()
                   let s = String(decoding: data!, as: UTF8.self)
                   print("Data:", s)
               } catch {
                   print("Failed to fetch stuff:", error)
                   return
               }
    }
    
    
    enum NetworkError: Error {
            case url
            case statusCode
            case standard
        }
        
        // async await fetch function
        func fetchSomethingAsyncAwait() throws -> Data? {
            guard let dummyURL = URL(string: "https://www.google.com") else {
                throw NetworkError.url
            }
            
            var data: Data?
            var response: URLResponse?
            var error: Error?
            
            // Semaphore
            let semaphore = DispatchSemaphore(value: 0)
            
            URLSession.shared.dataTask(with: dummyURL) { (d, r, e) in
                data = d
                response = r
                error = e
                
                semaphore.signal()
            }.resume()
            
            _ = semaphore.wait(timeout: .distantFuture)
            
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode > 300 {
                throw NetworkError.statusCode
            }
            
            if error != nil {
                throw NetworkError.standard
            }
            
            return data
        }
        // callback hell
        
        func fetchSomething(completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            guard let dummyURL = URL(string: "https://www.google.com") else { return }
            URLSession.shared.dataTask(with: dummyURL) { (data, res, err) in
                completion(data, res, err)
            }.resume()
        }
        
        
        
    }




