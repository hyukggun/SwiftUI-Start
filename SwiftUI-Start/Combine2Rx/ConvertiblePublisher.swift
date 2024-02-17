//
//  ConvertiblePublisher.swift
//  SwiftUI-Start
//
//  Created by 최최광현 on 2/6/24.
//

import Combine
import RxSwift
import Foundation

// MARK: RxSwift.Observable -> Publisher
extension RxSwift.Observable {
    
    struct ObservablePublisher: Publisher {
        typealias Output = Element
        typealias Failure = Never

        let observable: RxSwift.Observable<Element>
        
        init(observable: RxSwift.Observable<Element>) {
            self.observable = observable
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Element == S.Input {
            let subscription = ObservableSubscription(observable: observable, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }
    
    class ObservableSubscription<S: Subscriber>: Subscription where S.Input == Element, S.Failure == Never {
        var disposable: Disposable?
        
        init(observable: RxSwift.Observable<Element>, subscriber: S) {
            disposable = observable.subscribe(
                onNext: { value in
                    _ = subscriber.receive(value)
                },
                onCompleted: {
                    subscriber.receive(completion: .finished)
                }
            )
        }
        
        func request(_ demand: Subscribers.Demand) {
            
        }
        
        func cancel() {
            disposable?.dispose()
        }
    }
    
    func toPublisher() -> ObservablePublisher {
        ObservablePublisher(observable: self)
    }
}

extension Publisher where Failure == Never {
    var observable: RxSwift.Observable<Output> {
        get {
            return .create { [self] observer in
                let cancellable = self.sink {
                    observer.onNext($0)
                }
                return Disposables.create { cancellable.cancel() }
            }
        }
        set { }
    }
}
