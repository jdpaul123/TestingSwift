//
//  PrimeCalculator.swift
//  First
//
//  Created by Jonathan Paul on 11/30/23.
//

import Foundation

// Sieve of Eratosthenes: Calculates Prime Numbers Up To A Maximum Number
// Easy to do on main thread when max is 100_000, but app will drop frames if its a large number like one million or billion so we multithread it
struct PrimeCalculator {
    // NOTE: Rather than return the array we use a completion to deal with the resulting array of prime numbers
    static func calculate(upTo max: Int, completion: @escaping ([Int]) -> Void) {
        // push our work straight to a background thread
        DispatchQueue.global().async {
            guard max > 1 else {
                // if the input value is 0 or 1 exit immediately
                return
            }
            // mark all our numbers as prime
            var sieve = [Bool](repeating: true, count: max)

            // 0 and 1 are by definition not prime
            sieve[0] = false
            sieve[1] = false

            // count from 0 up to the ceiling...
            for number in 2..<max {
                // if this is marked as prime, then every multiple of it is not prime
                if sieve[number] == true {
                    for multiple in stride(from: number * number, to: sieve.count, by: number) { // TODO: I see how this is more efficient, but wouldn't starting at number*2 work? I guess there is some mathematical reason why we can start at number * number: like anything before is covered by some earlier number value that has already switched number * 2 to false?
                        sieve[multiple] = false
                    }
                }
            }

            // collapse our results down to a single array of primes
            let primes = sieve.enumerated().compactMap { $1 == true ? $0 : nil } // $1 is the value in the array and $0 is the index in the array
            completion(primes)
        }
    }

    static func calculateStreaming(upTo max: Int, completion: @escaping (Int) -> Void) {
        // push our work straight to a background thread
        DispatchQueue.global().async {
            guard max > 1 else {
                // if the input value is 0 or 1 exit immediately
                return
            }
            // mark all our numbers as prime
            var sieve = [Bool](repeating: true, count: max)

            // 0 and 1 are by definition not prime
            sieve[0] = false
            sieve[1] = false

            // count from 0 up to the ceiling...
            for number in 2..<max {
                // if this is marked as prime, then every multiple of it is not prime
                if sieve[number] == true {
                    for multiple in stride(from: number * number, to: sieve.count, by: number) {
                        sieve[multiple] = false
                    }
                    completion(number)
                }
            }
        }
    }

    static func calculateWithProgress(upTo max: Int, completion: @escaping ([Int]) -> Void) -> Progress {
        // create a Progress object that counts up to our maximum number
        let progress = Progress(totalUnitCount: Int64(max))

        DispatchQueue.global().async {
            guard max > 1 else {
                completion([])
                return
            }

            var sieve = [Bool](repeating: true, count: max)
            sieve[0] = false
            sieve[1] = false

            // add 2 to our progress counter, because we already went through 0 and 1
            progress.completedUnitCount += 2

            for number in 2..<max {
                // every time we've checked one number, add 1 to our completed unit count
                progress.completedUnitCount += 1

                if sieve[number] == true {
                    for multiple in stride(from: number * number, to: sieve.count, by: number) {
                        sieve[multiple] = false
                    }
                }
            }

            let primes = sieve.enumerated().compactMap { (index, value) in
                value == true ? index : nil
            }
            completion(primes)
        }

        // send back the Progress object
        return progress
    }
}
