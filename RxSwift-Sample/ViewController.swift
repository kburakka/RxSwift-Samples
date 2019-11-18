//
//  ViewController.swift
//  RxSwift-Sample
//
//  Created by burak kaya on 15/11/2019.
//  Copyright © 2019 burak kaya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tf.rx.text
            .filter({ value in
                value!.count > 10 && value!.count<15
            })
            .map({ value in
                value?.uppercased()
            })
            .startWith("Enter 10-15 character length text ")
            .subscribe(onNext: { text in
                guard let txt = text else {return}
                self.label.text = txt
            }).disposed(by: disposeBag)
    }
}

