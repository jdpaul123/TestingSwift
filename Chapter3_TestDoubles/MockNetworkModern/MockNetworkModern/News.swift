//
//  News.swift
//  MockNetworkModern
//
//  Created by Jonathan Paul on 12/3/23.
//

import Foundation

/*
 What we want to test:
 1. What was the URL that was requested?
 2. Was a network request actually started?
 3. Did the request come back with certain data?
 4. Did the request come back with a specific error?
 */
class News {
    var url: URL
    var stories = ""
    var error: Error?

    init(url: URL) {
        self.url = url
    }

    // Pull out the hidden dependency URLSession.shared by making it the "session" parameter
    // Make that session of type URLSessionProtocol rather than URLSession
    func fetch(using session: URLSessionProtocol = URLSession.shared, completionHandler: @escaping () -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                self.error = error
            } else if let data = data {
                self.stories = String(decoding: data, as: UTF8.self)
            }

            completionHandler()
        }

        task.resume()
    }
}

/*
 Sources:
 https://medium.com/@koromikoneo/the-complete-guide-to-network-unit-testing-in-swift-db8b3ee2c327
 https://github.com/koromiko/Tutorial/blob/master/NetworkingUnitTest.playground/Contents.swift
 */

// Protocol for mock/real
protocol URLSessionProtocol {
    typealias DataTaskResult = @Sendable (Data?, URLResponse?, Error?) -> Void
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

// Conform to protocol
extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
