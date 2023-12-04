//
//  NewsTestsAlternativeMethod.swift
//  MockExamplesTests
//
//  Created by Jonathan Paul on 12/3/23.
//

// NOTE: No need to write any URLSession mock using this method. We configure our URLProtocolMock class with whatever test data we expect
// to receive back, then ask URLSession to use that class as part of its networking

import XCTest
@testable import MockExamples

class URLProtocolMock: URLProtocol {
    // this is the data we're expecting to send back.
    // For every url tested we save it's data in this testURLs dictionary.
    static var testURLs = [URL: Data]()

    // It can handle all kinds of URLRequests so we will return true here
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    // We don't care what canonical means so we just send back whatever was sent in
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    // As soon as loading starts, sned back our test data or an empty Data instance, then end loading immediately
    override func startLoading() {
        if let url = request.url {
            self.client?.urlProtocol(self, didLoad: URLProtocolMock.testURLs[url] ?? Data())
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }

    // We don't need this but it's required, so we'll just write an empty method
    override func stopLoading() { }
}

final class NewsAlternativeTests: XCTestCase {
    func testNewsStoriesAreFetched() {
        // given
        let url = URL(string: "https://www.apple.com/newsroom/rssfeed/rss")!
        let news = AlternativeNews(url: url)
        let expectation = XCTestExpectation(description: "Downloading news stories returns \"Hello, world!\" as data.")
        URLProtocolMock.testURLs = [url: Data("Hello, world!".utf8)]

        // No cacheing using ephemeral
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)

        // when
        news.fetch(using: session) {
            XCTAssertEqual(news.stories, "Hello, world!")
            expectation.fulfill()
        }

        // then
        wait(for: [expectation], timeout: 1)
    }
}
