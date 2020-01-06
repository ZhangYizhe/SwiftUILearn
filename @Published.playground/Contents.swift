import Cocoa
import Combine

/*

class Wrapper {
    @Published var text: String = "hoho"
}

var wrapper = Wrapper()

check("Published") {
    wrapper.$text
}


wrapper.text = "123"
wrapper.text = "abc"
 
*/

class Clock {
    var timeString: String = "--:--:--" {
        didSet {print("\(timeString)")}
    }
}

let clock = Clock()

let formatter = DateFormatter()
formatter.timeStyle = .medium

let timer = Timer.publish(every: 1, on: .main, in: .default)
var token = timer.map{formatter.string(from: $0)}.assign(to: \.timeString, on: clock)

timer.connect()

