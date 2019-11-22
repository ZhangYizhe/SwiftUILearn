import Combine

check("Empty") {
    Empty<Int, SampleError>()
}

check("Just") {
    Just("Hello SwiftUI")
}


check("Sequence") {
    [1,2,3]
    .publisher
        .map{$0 * 2}
}

print([1,2,3,4,5].scan(0, +))
print("")

check("Scan") {
    [1,2,3,4,5].publisher.scan(0, +)
}

check("Compact Map") {
    ["1","2","3","cat","5"]
    .publisher
        .compactMap{ Int($0)}
}

check("Remove Duplicates") {
    ["S", "Sw", "Sw", "Sw", "Swi",
      "Swif", "Swift", "Swift", "Swif"]
    .publisher
    .removeDuplicates()
}

check("Fail") {
    Fail<Int, SampleError>(error: .sampleError)
        .mapError { (error) -> Error in
            switch error {
            case .sampleError:
                return MyError.myError
            }
    }
}


check("Throw") {
    ["1","2","Swift","4"].publisher
        .tryMap { s -> Int in
            guard let value = Int(s) else {
                throw MyError.myError
            }
            return value
    }
}
