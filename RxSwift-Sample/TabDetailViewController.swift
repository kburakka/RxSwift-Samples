//
//  TabDetailViewController.swift
//  RxSwift-Sample
//
//  Created by burak kaya on 18/11/2019.
//  Copyright © 2019 burak kaya. All rights reserved.
//

import UIKit
import RxSwift

class TabDetailViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var city: UILabel!
    
    var userToDisplay = Variable(User(name: "", age: 0, city: ""))
    var userToDisplayObservable: Observable<User> {
        return userToDisplay.asObservable()
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        subscribeToUsers()
    }
    
    func configureLabels() {
        //1
        userToDisplayObservable.subscribe(onNext: { [weak self] user in
            //2
            self?.name.text = user.name
            self?.age.text = String(user.age)
            self?.city.text = user.city
        }).disposed(by: disposeBag)//3
    }
    
    func subscribeToUsers() {
        let secondVC = tabBarController?.viewControllers?.last as! TabTableViewController
        secondVC.userToShowInFirstVcObservable.subscribe(onNext: { [weak self] user in
            self?.userToDisplay.value = user
            self?.configureLabels()
        }).disposed(by: disposeBag)
    }
}
