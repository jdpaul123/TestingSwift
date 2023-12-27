import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// 2nd Modified from Original
print("A")
DispatchQueue.main.async {
    print("E")
}
DispatchQueue.global().sync {
    print("C")

    DispatchQueue.main.async {
        print("D")
    }
}
print("B")


// 1st Modified from Original
//print("A")
//DispatchQueue.main.async {
//    print("C")
//
//    DispatchQueue.main.async {
//        print("D")
//    }
//
//    DispatchQueue.global().sync {
//        print("E")
//    }
//}
//print("B")

// Original
//print("A")
//DispatchQueue.main.async {
//    print("C")
//
//    DispatchQueue.main.async {
//        print("D")
//    }
//
//    DispatchQueue.global().sync {
//        print("E")
//        // This will cause a deadlock. DispatchQueue.main.sync will wait for the main queue to finish executing the closure, but the main queue is waiting for the global queue to finish executing the closure. The global queue will never finish executing the closure because it is waiting for the main queue to finish executing the closure.
//        DispatchQueue.main.sync {
//            print("F")
//        }
//    }
//}
//print("B")
