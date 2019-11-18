//
//  TimerViewController.swift
//  RxSwift-Sample
//
//  Created by burak kaya on 18/11/2019.
//  Copyright © 2019 burak kaya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TimerViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"

        let up = button.rx.controlEvent(.touchUpInside)
        let down = button.rx.controlEvent(.touchDown)
        
        down.flatMapLatest { _ in
            return Observable<Int>
                .interval(1/20, scheduler: MainScheduler.instance)
                .startWith(0)
                .map { _ in
                    return dateFormatter.string(from: Date())
            }
            .takeUntil(up)
        }.bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}
