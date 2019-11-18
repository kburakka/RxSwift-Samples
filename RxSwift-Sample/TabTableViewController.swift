//
//  TabTableViewController.swift
//  RxSwift-Sample
//
//  Created by burak kaya on 18/11/2019.
//  Copyright © 2019 burak kaya. All rights reserved.
//

import UIKit
import RxSwift

class User {
    let name: String
    let age: Int
    let city: String
    
    init(name: String, age: Int, city: String) {
        self.name = name
        self.age = age
        self.city = city
    }
}

class TabTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var userToShowInFirstVc = Variable(User(name: "", age: 0, city: ""))
    var userToShowInFirstVcObservable: Observable<User> {
        return userToShowInFirstVc.asObservable()
    }
    
    var userArray = Variable([User]())
    var userArrayObservable: Observable<[User]> {
        return userArray.asObservable()
    }
    
    func deployUsers() {
        userArray.value = [
            User(name: "John", age: 23, city: "Minsk"),
            User(name: "Ege", age: 24, city: "Amsterdam"),
            User(name: "Igor", age: 26, city: "Berlin")
        ]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = userArray.value[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userToShowInFirstVc.value = userArray.value[indexPath.row]
        tabBarController?.selectedIndex = 0
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        deployUsers()
        tableView.delegate = self
        tableView.dataSource = self
    }
}
