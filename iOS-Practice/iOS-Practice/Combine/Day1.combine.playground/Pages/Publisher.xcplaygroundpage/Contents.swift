import UIKit
import Combine

var myIntArrayPublisher: Publishers.Sequence<[Int], Never> = [1,2,3].publisher

myIntArrayPublisher.sink(receiveCompletion: { completion in 
    switch completion {
    case .finished:
        print("Complete")
    case .failure(let error):
        print(error)
    }
}, receiveValue: { receivedValue in
            print(receivedValue)
})
