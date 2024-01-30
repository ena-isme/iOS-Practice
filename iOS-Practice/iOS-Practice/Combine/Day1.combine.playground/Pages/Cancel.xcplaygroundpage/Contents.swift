//: [Previous](@previous)

import UIKit
import Combine

var myDefaultNotification = Notification.Name("com.jiwon.customNotification")
var myDefaultPublisher = NotificationCenter.default.publisher(for: myDefaultNotification)

//Rx 의 Disposable 과 같은 개념
var mySubscription: AnyCancellable?
var mySubscriptionSet = Set<AnyCancellable>()

myDefaultPublisher.sink(receiveCompletion: { completion in 
    switch completion {
    case .finished:
        print("Complete")
    case .failure(let error):
        print(error)
    }
}, receiveValue: { receivedValue in
    print(receivedValue)
    
    //Rx 의 DisposedBag 과 같은 활용법
}).store(in: &mySubscriptionSet)

NotificationCenter.default.post(Notification(name: myDefaultNotification))
