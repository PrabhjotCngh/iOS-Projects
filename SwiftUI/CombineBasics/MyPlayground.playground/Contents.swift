import UIKit
import Combine

//MARK: - Basic Publishers

// Just Publisher

/*
let publisher = Just(123)

let cancellable1 = publisher.sink { value in
    print(value)
}

// cancellable is not required
cancellable.cancel()

// Sequence Publisher
 
let numbersPublisher = [1,2,3,4,5,6].publisher
let doublePublisher = numbersPublisher.map { $0 * 2 }

let cancellable2 = doublePublisher.sink { value in
    print(value)
}
*/

//MARK: - Subscribing to publishers
/*
// Timer publisher
let timerPublisher = Timer.publish(every: 1, on: .main, in: .common)
let cancellable3 = timerPublisher.autoconnect().sink { timestamp in
    print("Timestamp: \(timestamp)")
}

// Device orientation publisher
var cancellables4: Set<AnyCancellable> = []
NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification).sink { _ in
    let currentOrientation = UIDevice.current.orientation
    print(currentOrientation)
}.store(in: &cancellables4)

// UIKit publisher
private var cancellables5: Set<AnyCancellable> = []
var textField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Enter name"
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
}()

NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
    .compactMap { $0.object as? UITextField }
    .sink { textField in
        if let text = textField.text {
            print(text)
        }
    }.store(in: &cancellables5)
*/

//MARK: Error handling and completion

/*
enum NumberError: Error {
  case operationFailed
}

let numbersPublisher = [1, 2, 3, 4, 5].publisher
 
 // TryMap and catch
 
let doubledPublisher = numbersPublisher
    .tryMap { number in
        if number == 4 {
            throw NumberError.operationFailed
        }
        
        return number * 2
    }
    .catch { error in
        if let numberError = error as? NumberError {
            print("Error occurred: \(numberError)")
        }
        
        return Just(0)
}

let cancellable6 = doubledPublisher.sink { completion in
    switch completion {
        case .finished:
            print("finished")
        case .failure(let error):
            print(error)
    }
} receiveValue: { value in
    print(value)
}
 
 // TryMap and mapError
 
 let doubledPublisher = numbersPublisher
     .tryMap { number in
         if number == 4 {
             throw NumberError.operationFailed
         }
         
         return number * 2
         
     }.mapError { error in
         return NumberError.operationFailed
     }

 let cancellable7 = doubledPublisher.sink { completion in
     switch completion {
         case .finished:
             print("finished")
         case .failure(let error):
             print(error)
     }
 } receiveValue: { value in
     print(value)
 }
*/

// MARK: - Map, flatMap and merge

/*
 // map
 
let numbersPublisher = (1...5).publisher

let squaredPublisher = numbersPublisher.map { "Item# \($0)" }

let cancellable8 = squaredPublisher.sink { value in
    print(value)
} */

// flatMap

/*
let namePublisher = ["John", "Mary", "Steven"].publisher

let flattedNamePublisher = namePublisher.flatMap { name in
    name.publisher
}

let cancellable9 = flattedNamePublisher
    .sink { char in
        print(char)
    }
 
 */

/*
// merge

let publisher1 = [1,2,3].publisher
let publisher2 = [4,5,6].publisher
let publisher3 = ["A", "B"].publisher

let mergedPublisher = Publishers.Merge(publisher1, publisher2)

let cancellable10 = mergedPublisher.sink { value in
    print(value)
}
 */

//MARK: - filter, compactMap, debounce

// filter
/*
let numbersPublisher = (1...10).publisher

let evenNumberPublisher = numbersPublisher.filter { $0 % 2 == 0}

let cancellable11 = evenNumberPublisher.sink { value in
    print(value)
} */

// compactMap
/*
let stringsPublisher = ["1", "2", "3", "4", "A"].publisher

let numbersPublisher = stringsPublisher.compactMap { Int($0) }

let cancellable12 = numbersPublisher.sink { value in
    print(value)
} */

// debounce
/*
let textPublisher = PassthroughSubject<String, Never>()

let debouncedPublisher = textPublisher.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)

let cancellable13 = debouncedPublisher.sink { value in
    print(value)
}

textPublisher.send("A")
textPublisher.send("B")
textPublisher.send("C")
textPublisher.send("D")
textPublisher.send("E")
textPublisher.send("F")
*/

//MARK: - combineLatest, zip, switchToLatest


// combineLatest
/*
let publisher1 = CurrentValueSubject<Int, Never>(1)
let publisher2 = CurrentValueSubject<String, Never>("Hello World")

let combinedPublisher = publisher1.combineLatest(publisher2)

let cancellable14 = combinedPublisher.sink { value1, value2 in
    print("Value 1: \(value1), Value 2: \(value2)")
}

publisher1.send(3)
publisher2.send("Introduction to Combine")
 */

// zip
/*
let publisher1 = [1,2,3,4].publisher
let publisher2 = ["A", "B", "C", "D", "E"].publisher
let publisher3 = ["John", "Doe", "Mary", "Steven"].publisher

//let zippedPublisher = publisher1.zip(publisher2)

let zippedPublisher = Publishers.Zip3(publisher1, publisher2, publisher3)

let cancellable15 = zippedPublisher.sink { value in
    print("\(value.0), \(value.1), \(value.2)")
}
*/

// switchToLatest
/*
let outerPublisher = PassthroughSubject<AnyPublisher<Int, Never>, Never>()
let innerPublisher1 = CurrentValueSubject<Int, Never>(1)
let innerPublisher2 = CurrentValueSubject<Int, Never>(2)

let cancellable16 = outerPublisher
    .switchToLatest()
    .sink { value in
        print(value)
}

outerPublisher.send(AnyPublisher(innerPublisher1))
innerPublisher1.send(10)

outerPublisher.send(AnyPublisher(innerPublisher2))
innerPublisher2.send(20)
innerPublisher2.send(100)
outerPublisher.send(AnyPublisher(innerPublisher1))
outerPublisher.send(AnyPublisher(innerPublisher2))
*/

//MARK: - Error handling operators in combine

/*
enum SampleError: Error {
    case operationFailed
}
*/

// tryMap

/*
let numbersPublisher = [1,2,3,4,5,6].publisher

let transformedPublisher = numbersPublisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        
        return value
    }.catch { error in
        print(error)
        return Just(0)
    }

 let cancellable17 = transformedPublisher.sink { value in
    print(value)
} */

// replaceError with single value

/*
let numbersPublisher = [1,2,3,4,5,6].publisher

let transformedPublisher = numbersPublisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        
        return value * 2
    }.replaceError(with: -1)


let cancellable18 = transformedPublisher.sink { value in
    print(value)
}
*/

// replaceError with another publisher

/*
let numbersPublisher = [1,2,3,4,5,6].publisher

let fallbackPublisher = Just(-1)

let transformedPublisher = numbersPublisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        return Just(value * 2)
}.replaceError(with: fallbackPublisher)

let cancellable19 = transformedPublisher.sink { publisher in
    let _ = publisher.sink { value in
        print(value)
    }
} */

// retry

/*
let publisher = PassthroughSubject<Int, Error>()

let retriedPublisher = publisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        return value
    }.retry(2)

let cancellable20 = retriedPublisher.sink { completion in
    switch completion {
        case .finished:
            print("Pubisher has completed.")
        case .failure(let error):
            print("Publisher failed with error \(error)")
    }
} receiveValue: { value in
    print(value)
}

publisher.send(1)
publisher.send(2)
publisher.send(3) // failed
publisher.send(4)
publisher.send(5)
publisher.send(3) // failed
publisher.send(6)
publisher.send(7)
publisher.send(3) // failed
publisher.send(8)

*/




