//
//  APIClient.swift
//  TDD-TodoList
//
//  Created by Ivan Garcia on 28/6/17.
//  Copyright © 2017 Ivan Garcia. All rights reserved.
//

import Foundation

enum WebServiceError: Error {
  case DataEmptyError
  case ResponseError
}

class APIClient {
  lazy var session: SessionProtocol = URLSession.shared
  
  func loginUser(withName username: String, password: String, completion: @escaping (Token?, Error?) -> Void) {
    
    guard let url = URL(string: "https://awesometodos.com/login") else { fatalError() }
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
    
    let queryUsername = URLQueryItem(name: "username", value: username)
    let queryPassword = URLQueryItem(name: "password", value: password)
    
    urlComponents?.queryItems = [queryUsername, queryPassword]
    
    guard let loginURL = urlComponents?.url else { fatalError() }
    session.dataTask(with: loginURL) { (data, response, error) in
      guard error == nil else {
        completion(nil, WebServiceError.ResponseError)
        return
      }
      guard let data = data else {
        completion(nil, WebServiceError.DataEmptyError)
        return
      }
      do {
        let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:String]
        let token: Token?
        if let tokenString = dict?["token"] {
          token = Token(id: tokenString)
        } else {
          token = nil
        }
        completion(token, nil)
      } catch {
        completion(nil, error)
      }
      }.resume()
    }
}

protocol SessionProtocol {
  func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {
  
}
