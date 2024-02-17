//
//  ConvertibleObservableExampleUI.swift
//  SwiftUI-Start
//
//  Created by 최최광현 on 2/7/24.
//

import Combine
import RxSwift
import SwiftUI

class ConvertibleObservalbeState: ObservableObject {
    var cancelBag = Set<AnyCancellable>()
    @Published
    var count: Int = 0
}

struct ConvertibleObservableExampleUI: View {
    
    let convertibleObservable = RxSwift.Observable.from(1...10)
        .toPublisher()
    
    let convertibleRelay = RxSwift.BehaviorSubject(value: 0)
    
    @ObservedObject
    var state = ConvertibleObservalbeState()
    
    let publisher = Timer.publish(every: 1.0, on: .main, in: RunLoop.Mode.default)
    
    @State
    private var count: Int = 0
    
    @State
    var disposeBag: DisposeBag = DisposeBag()
    
    var body: some View {
        VStack {
            Text("count is : \(count)")
            Button(action: {
                convertibleRelay.onNext(1)
            }, label: {
                Text("increment count")
            })
        }
        .onReceive(convertibleRelay.scan(0, accumulator: { $0 + $1 }).toPublisher()) {
            count = $0
            state.count = $0
        }
        .onAppear {
//            publisher.autoconnect()
//                .observable
//                .subscribe(onNext: {
//                    print("time is going : \($0)")
//                })
//                .disposed(by: disposeBag)
            
            state.objectWillChange
                .sink {
                    print("value changed")
                }
                .store(in: &state.cancelBag)
        }
    }
}

#Preview {
    ConvertibleObservableExampleUI()
}
