//
//  AlternativeNews.swift
//  MockExamples
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
class NewsAlternative {
    var url: URL
    var stories = ""

    init(url: URL) {
        self.url = url
    }

    // Pull out the hidden dependency URLSession.shared by making it the "session" parameter
    // Make that session of type URLSessionProtocol rather than URLSession
    func fetch(using session: URLSession = .shared, completionHandler: @escaping () -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                self.stories = String(decoding: data, as: UTF8.self)
            }

            completionHandler()
        }

        task.resume()
    }
}
