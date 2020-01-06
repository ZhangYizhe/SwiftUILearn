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


let searchText = PassthroughSubject<String, Never>()

let temp = check("Debounce")
{
    searchText
        .throttle(for: .seconds(1), scheduler: RunLoop.main, latest: true)
}

delay(0) {searchText.send("S")}
delay(0.1) {searchText.send("Sw1")}
delay(0.2) {searchText.send("Sw2")}
delay(0.3) {searchText.send("Sw3")}
delay(0.4) {searchText.send("Swi4")}
delay(1.3) {searchText.send("Swif")}
delay(1.4) {searchText.send("Swift1")}
delay(1.5) {searchText.send("Swift2")}
delay(1.6) {searchText.send("Swift3")}
delay(1.7) {searchText.send("Swift4")}
