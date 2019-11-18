//
//  AnimationViewController.swift
//  RxSwift-Sample
//
//  Created by burak kaya on 18/11/2019.
//  Copyright © 2019 burak kaya. All rights reserved.
//

import UIKit
import RxSwift

class AnimationViewController: UIViewController {
    let disposeBag = DisposeBag()

    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rotate(image, duration: 0.5)
            .flatMap { [unowned self] in
                self.shift(self.image, duration: 0.5, isRotateToRight: true)
        }
        .flatMap { [unowned self] in
            self.fade(self.image, duration: 0.5)
        }
        .flatMap { [unowned self] in
            self.shift(self.image, duration: 0.5, isRotateToRight: false)
        }
        .subscribe()
        .disposed(by: disposeBag)
    }
    func rotate(_ view: UIView, duration: TimeInterval) -> Observable<Void> {
           return Observable.create { (observer) -> Disposable in
               UIView.animate(withDuration: duration, animations: {
                   view.transform = CGAffineTransform(rotationAngle: .pi/2)
               }, completion: { (_) in
                   observer.onNext(())
                   observer.onCompleted()
               })
               return Disposables.create()
           }
       }
    
    func shift(_ view: UIView, duration: TimeInterval, isRotateToRight:Bool) -> Observable<Void> {
        var dx = 0
        if isRotateToRight == true{
            dx = 50
        }else{
            dx = -50
        }
           return Observable.create { (observer) -> Disposable in
               UIView.animate(withDuration: duration, animations: {
                view.alpha = 1
                   view.frame = view.frame.offsetBy(dx: CGFloat(dx), dy: 0)
               }, completion: { (_) in
                   observer.onNext(())
                   observer.onCompleted()
               })
               return Disposables.create()
           }
       }
    
       func fade(_ view: UIView, duration: TimeInterval) -> Observable<Void> {
           return Observable.create { (observer) -> Disposable in
               UIView.animate(withDuration: duration, animations: {
                   view.alpha = 0
                    
               }, completion: { (_) in
                   observer.onNext(())
                   observer.onCompleted()
               })
               return Disposables.create()
           }
       }
}
