import Cocoa
import Combine

public func check<P: Publisher>(_ title: String, publisher: () -> P) -> AnyCancellable {
    print("----- \(title) -----")
    defer { print("") }
    return publisher()
        .print()
        .sink(
            receiveCompletion: { _ in},
            receiveValue: { _ in }
        )
}

public func delay(_ seconds: TimeInterval = 0, on queue: DispatchQueue = .main, block: @escaping () -> Void) {
    queue.asyncAfter(deadline: .now() + seconds, execute: block)
}


//let searchText = PassthroughSubject<String, Never>()
//
//let temp = check("Debounce")
//{
//    searchText
//        .debounce(for: .seconds(1), scheduler: RunLoop.main)
//}
//
//delay(0) {searchText.send("S")}
//delay(0.1) {searchText.send("Sw")}
//delay(0.2) {searchText.send("Swi")}
//delay(1.3) {searchText.send("Swif")}
//delay(1.4) {searchText.send("Swift")}


// let temp = check("URL Session") {
//     URLSession.shared
//         .dataTaskPublisher(
//             for: URL(string: "https://httpbin.org/get?foo=bar")!)
//         .map { data, _ in data }
//         .decode(type: Response.self, decoder: JSONDecoder())
//         .compactMap { $0.args?.foo }
// }


struct Response: Decodable {
    struct Foo: Decodable {
        let foo: String
    }
    let args: Foo?
}

let searchText = PassthroughSubject<String, Never>()
let session = URLSession.shared

let temp = check("Debounce") {
    searchText
        .scan("", { return $0 + " " + $1 })
        .debounce(for: .seconds(1), scheduler: RunLoop.main)
        .map { (value) -> URL in
            var components = URLComponents()
            components.scheme = "https"
            components.host = "httpbin.org"
            components.path = "/get"
            let queryItemFoo = URLQueryItem(name: "foo", value: value)
            components.queryItems = [queryItemFoo]
            return components.url!
    }.flatMap { url in
        return URLSession.shared.dataTaskPublisher(for: url)
                .map { data, _ in data }
                .decode(type: Response.self, decoder: JSONDecoder())
                .compactMap { $0.args?.foo }
                .replaceError(with: "")
    }
}

delay(0.1) { searchText.send("I") }
delay(0.2) { searchText.send("Love") }
delay(0.5) { searchText.send("SwiftUI") }
delay(1.6) { searchText.send("And") }
delay(2.0) { searchText.send("Combine") }





