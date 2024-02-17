//
//  SimpleTimerSubscription.swift
//  SwiftUI-Start
//
//  Created by 최최광현 on 2/6/24.
//

import Combine
import Foundation

class SimpleTimerSubscription<S: Subscriber>: Subscription where S.Input == Int, S.Failure == Never {
    var subscriber: S?
    let interval: TimeInterval
    let times: Int
    var current = 0
    var timer: Timer?
    
    init(subscriber: S, interval: TimeInterval, times: Int) {
        self.subscriber = subscriber
        self.interval = interval
        self.times = times
    }
    
    // 구독을 시작하거나 요청한 아이템의 수를 처리합니다.
    func request(_ demand: Subscribers.Demand) {
        guard demand > 0 else { return }
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            guard let self = self, let subscriber = self.subscriber else { return }
            if self.current < self.times {
                _ = subscriber.receive(self.current)
                self.current += 1
            } else {
                subscriber.receive(completion: .finished)
                self.cancel()
            }
        }
    }
    
    // 구독을 취소합니다.
    func cancel() {
        timer?.invalidate()
        timer = nil
        subscriber = nil
    }
}
