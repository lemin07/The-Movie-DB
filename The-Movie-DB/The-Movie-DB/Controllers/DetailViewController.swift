//
//  DetailViewController.swift
//  The-Movie-DB
//
//  Created by LEMIN DAHOVICH on 20.10.2022.
//

import Foundation

/*

 // MARK: - Alamofire
 extension DetailViewController {
   private func fetch<T: Decodable & Displayable>(_ list: [String], of: T.Type) {
     var items: [T] = []
     let fetchGroup = DispatchGroup()
     
     list.forEach { (url) in
       fetchGroup.enter()
       AF.request(url).validate().responseDecodable(of: T.self) { (response) in
         if let value = response.value {
           items.append(value)
         }
         fetchGroup.leave()
       }
     }
     
     fetchGroup.notify(queue: .main) {
       self.listData = items
       self.listTableView.reloadData()
     }
   }
   
   func fetchList() {
     guard let data = data else { return }
     
     switch data {
     case is Film:
       fetch(data.listItems, of: Starship.self)
     case is Starship:
       fetch(data.listItems, of: Film.self)
     default:
       print("Unknown type: ", String(describing: type(of: data)))
     }
   }
 }
*/
