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


// Subjects - publish and they can also subscribe

// PassthroughSubject

/*
 let subject = PassthroughSubject<Int, Never>()
 
 let cancellable21 = subject.sink { value in
 print(value)
 }
 
 
 subject.send(1)
 subject.send(2)
 
 */

// CurrentValueSubject

/*
let currentValueSubject = CurrentValueSubject<String, Never>("John")

let cancellable22 = currentValueSubject.sink { value in
    print(value)
}

currentValueSubject.send("Mary")

print(currentValueSubject.value)

*/

// Custom subjects

/*
class EvenSubject<Failure: Error>: Subject {
    
    typealias Output = Int
    
    private let wrapped: PassthroughSubject<Int, Failure>
    
    init(initialValue: Int) {
        self.wrapped = PassthroughSubject()
        let evenInitialValue = initialValue % 2 == 0 ? initialValue: 0
        send(initialValue)
    }
    
    func send(subscription: Subscription) {
        wrapped.send(subscription: subscription)
    }
    
    func send(_ value: Int) {
        if value % 2 == 0 {
            wrapped.send(value)
        }
    }
    
    func send(completion: Subscribers.Completion<Failure>) {
        wrapped.send(completion: completion)
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Int == S.Input {
        wrapped.receive(subscriber: subscriber)
    }
    
}

let subject = EvenSubject<Never>(initialValue: 4)

let cancellable = subject.sink { value in
    print(value)
}

subject.send(12)
subject.send(13)
subject.send(20)

*/

// WeatherClient using subjects

/*
class WeatherClient {
    let updates = PassthroughSubject<Int, Never>()
    
    func fetchWeather() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.updates.send(Int.random(in: 0...100))
        }
    }
}

let client = WeatherClient()
let cancellable23 = client.updates.sink { value in
    print(value)
}

client.fetchWeather()
*/

// Networking and error handling with combine

/*
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badServerResponse
}

func fetchPosts() -> AnyPublisher<[Post], Error> {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkError.badServerResponse
            }
            return data
        }
        .retry(3)
        .decode(type: [Post].self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

var cancellables23: Set<AnyCancellable> = []

fetchPosts().sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        print("Finished! We can update UI!")
    case .failure(let error):
        print(error)
    }
}, receiveValue: { posts in
    print(posts)
}).store(in: &cancellables23)

*/

// Combining multiple network requests

struct MovieResponse: Codable {
    let search: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct Movie: Codable {
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
    }
}

func fetchMovies(_ searchTerm: String) -> AnyPublisher<MovieResponse, Error> {
    let url = URL(string: "http://www.omdbapi.com/?s=\(searchTerm)&page=2&apikey=564727fa")!
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: MovieResponse.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

var cancellable24: Set<AnyCancellable> = []

Publishers.CombineLatest(fetchMovies("Batman"), fetchMovies("Superman"))
    .sink { _ in
        
    } receiveValue: { movie1, movie2 in
        movie1.search.map { movie in
            print(movie.title)
        }
        movie2.search.map { movie in
            print(movie.title)
        }
    }.store(in: &cancellable24)

