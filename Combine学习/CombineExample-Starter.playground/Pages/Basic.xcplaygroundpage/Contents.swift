import Combine
import Foundation

//check("Empty") {
//    Empty<Int, SampleError>()
//}
//
//check("Just") {
//    Just("Hello SwiftUI")
//}
//
//
//check("Sequence") {
//    [1,2,3]
//        .publisher
//        .map{$0 * 2}
//}
//
//print([1,2,3,4,5].scan(0, +))
//print("")
//
//check("Scan") {
//    [1,2,3,4,5].publisher.scan(0, +)
//}
//
//check("Compact Map") {
//    ["1","2","3","cat","5"]
//        .publisher
//        .compactMap{ Int($0)}
//}
//
//check("Remove Duplicates") {
//    ["S", "Sw", "Sw", "Sw", "Swi",
//     "Swif", "Swift", "Swift", "Swif"]
//        .publisher
//        .removeDuplicates()
//}
//
//check("Fail") {
//    Fail<Int, SampleError>(error: .sampleError)
//        .mapError { (error) -> Error in
//            switch error {
//            case .sampleError:
//                return MyError.myError
//            }
//    }
//}
//
//
//check("Throw") {
//    ["1","2","Swift","4"].publisher
//        .tryMap { s -> Int in
//            guard let value = Int(s) else {
//                throw MyError.myError
//            }
//            return value
//    }
//}
//
//check("Replace Error") {
//    ["1","2","Swift","4"].publisher
//        .tryMap { (s) -> Int in
//            guard let value = Int(s) else {
//                throw MyError.myError
//            }
//            return value
//    }
//    .replaceError(with: -1)
//}
//
//check("Catch with Just") {
//    ["1","2","Swift","4"].publisher
//        .flatMap{ s in
//            return Just(s)
//                .tryMap {s -> Int in
//                    guard let value = Int(s) else {
//                        throw MyError.myError
//                    }
//                    return value
//            }
//            .catch { _ in Just(-1) }
//    }
//}
//
//
//let s1 = check("Subject") { () -> PassthroughSubject<Int, Never> in
//    let subject = PassthroughSubject<Int, Never>()
//    delay(1) {
//        subject.send(1)
//        delay(1) {
//            subject.send(2)
//            delay(1) {
//                subject.send(completion: .finished)
//            }
//        }
//    }
//
//    return subject
//}


//func loadPage(
//    url: URL,
//    handler: @escaping (Data?, URLResponse?, Error?) -> Void)
//{
//    URLSession.shared.dataTask(with: url) {
//        data, response, error in
//        handler(data, response, error)
//    }.resume()
//}

//struct Response: Decodable {
//    struct Args: Decodable {
//        let foo: String
//    }
//    let args: Args?
//}


//let future = check("Future") {
//    Future<(Data, URLResponse), Error> { promise in
//        loadPage(url: URL(string: "https://httpbin.org/get?foo=bar")!) {
//            data, response, error in
//            if let data = data, let response = response {
//                promise(.success((data, response)))
//            } else {
//                promise(.failure(error!))
//            }
//        }
//    }
//    .map { data, _ in data }
//    .decode(type: Response.self, decoder: JSONDecoder())
//    .compactMap { $0.args?.foo }
//}

//struct Response: Decodable {
//    struct Args: Decodable {
//        let foo: String
//    }
//    let args: Args?
//}
//
//enum HTTPError: LocalizedError {
//    case statusCode
//}

//check("URL Session") {
//    URLSession.shared.dataTaskPublisher(for: URL(string: "https://httpbin.org/get?foo=bar")!)
//        .tryMap { output in
//            guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
//                throw HTTPError.statusCode
//            }
//            return output.data
//        }
//        .decode(type: Response.self, decoder: JSONDecoder())
//        .eraseToAnyPublisher()
//        .sink(receiveCompletion: { completion in
//            switch completion {
//            case .finished:
//                break
//            case .failure(_):
//                break
//            }
//        }) { response in
//            print(response.args?.foo)
//    }
//}

//let url = URL(string: "https://httpbin.org/get?foo=bar")!
//
//let cancellable = URLSession.shared.dataTaskPublisher(for: url)
//    .map { $0.data }
//    .decode(type: Response.self, decoder: JSONDecoder())
//    .sink(receiveCompletion: { completion in
//        switch completion {
//        case .finished:
//            break
//        case .failure(let error):
//            print("received error: ", error)
//        }
//    }, receiveValue: { response in
//        print(response.args?.foo ?? "")
//    })

//let timer = Timer.publish(every: 1, on: .main, in: .default)
//
//let temp = check("Timer Connected") {
//    timer
//}
//
//timer.connect()


