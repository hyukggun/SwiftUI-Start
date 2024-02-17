//
//  SimpleTimerPublisher.swift
//  SwiftUI-Start
//
//  Created by 최최광현 on 2/6/24.
//

import Combine
import Foundation

struct SimpleTimerPublisher: Publisher {
    typealias Output = Int
    typealias Failure = Never
    
    let interval: TimeInterval
    let times: Int
    
    init(interval: TimeInterval, times: Int) {
        self.interval = interval
        self.times = times
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Int == S.Input {
        let subscription = SimpleTimerSubscription(subscriber: subscriber, interval: interval, times: times)
        subscriber.receive(subscription: subscription)
    }
}
