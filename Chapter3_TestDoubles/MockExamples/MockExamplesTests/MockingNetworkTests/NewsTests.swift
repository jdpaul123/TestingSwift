//
//  NewsTests.swift
//  MockExamplesTests
//
//  Created by Jonathan Paul on 12/2/23.
//

import XCTest
@testable import MockExamples

final class NewsTests: XCTestCase {
    func testNewsFetchLoadsCorrectURL() {
        class DataTaskMock: URLSessionDataTask {
            // This is an example of a dummy because it doesn't do anything
            override func resume() { }
        }

        class URLSessionMock: URLSessionProtocol {
            var dataTask: DataTaskMock?
            var lastURL: URL?
            var testData: Data?

            func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
                defer { completionHandler(nil, nil, nil)}
                lastURL = url
                // TODO: The public init was deprecated for iOS 13.0 and newer. There is no accessable init
                return DataTaskMock()
            }
        }

        // given
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url) // System under test (SUT)
        let session = URLSessionMock()
        let expectation = XCTestExpectation(description: "Downloading news stories.")

        // when
        news.fetch(using: session) {
            XCTAssertEqual(URL(string: "https://www.apple.com/newsroom/rss-feed.rss"), session.lastURL)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testNewsFetchCallsResume() {
        class DataTaskMock: URLSessionDataTask {
            let completionHandler: (Data?, URLResponse?, Error?) -> Void
            var resumeWasCalled = false

            // TODO: The public init was deprecated for iOS 13.0 and newer. There is no accessable init
            init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
                self.completionHandler = completionHandler
            }

            // This is an example of a dummy because it doesn't do anything
            override func resume() {
                // resume was called, so flip our boolean and call the completion
                resumeWasCalled = true
                completionHandler(nil, nil, nil)
            }
        }

        class URLSessionMock: URLSessionProtocol {
            var dataTask: DataTaskMock?
            var testData: Data?

            func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
                let newDataTask = DataTaskMock(completionHandler: completionHandler)
                dataTask = newDataTask

                return newDataTask
            }
        }


        // given
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url)
        let session = URLSessionMock()
        let expectation = XCTestExpectation(description: "Downloading news stories triggers resume().")

        // when
        news.fetch(using: session) {
            XCTAssertTrue(session.dataTask?.resumeWasCalled ?? false)
            expectation.fulfill()
        }

        // then
        wait(for: [expectation], timeout: 1)
    }

    func testNewsStoriesAreFetched() {
        class DataTaskMock: URLSessionDataTask {
            override func resume() { }
        }

        class URLSessionMock: URLSessionProtocol {
            var testData: Data?
            var error: Error?

            func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
                defer {
                    completionHandler(testData, nil, error)
                }
                // TODO: The public init was deprecated for iOS 13.0 and newer. There is no accessable init
                return DataTaskMock()
            }
        }

        // given
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url)
        let session = URLSessionMock()
        session.testData = Data("Hello, world!".utf8)
        let expectation = XCTestExpectation(description: "Downloading news stories returns back data.")

        // When
        news.fetch(using: session) {
            XCTAssertEqual(news.stories, "Hello, world!")
            expectation.fulfill()
        }
    }

    func testNewsStoriesFails() {
        class DataTaskMock: URLSessionDataTask {
            override func resume() { }
        }

        class URLSessionMock: URLSessionProtocol {
            var testData: Data?
            var error: Error?

            func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
                defer {
                    completionHandler(testData, nil, error)
                }
                // TODO: The public init was deprecated for iOS 13.0 and newer. There is no accessable init
                return DataTaskMock()
            }
        }

        // given
        enum NewsError: Error {
            case newsError
        }
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url)
        let session = URLSessionMock()
        session.error = NewsError.newsError
        let expectation = XCTestExpectation(description: "Downloading news stories returns back data.")

        // When
        news.fetch(using: session) {
            XCTAssertEqual(session.error as? NewsError, NewsError.newsError)
            expectation.fulfill()
        }
    }
}


//// MARK: These classes can be used to check that we load the correct url and that resume was called
//// To test that the URL was requested we must make teh dataTask() method do nothing except save the URL that was sent
//class DataTaskMock: URLSessionDataTask {
//    let completionHandler: (Data?, URLResponse?, Error?) -> Void
//    var resumeWasCalled = false
//
//
//    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
//        self.completionHandler = completionHandler
//    }
//
//    // This is an example of a dummy because it doesn't do anything
//    override func resume() {
//        // resume was called, so flip our boolean and call the completion
//        resumeWasCalled = true
//        completionHandler(nil, nil, nil)
//    }
//}
//
//class URLSessionMock: URLSessionProtocol {
//    var dataTask: DataTaskMock?
//    var lastURL: URL?
//    var testData: Data?
//
//    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
//        // For checking that we load the correct url
//        lastURL = url
//
//        // For checking that resume was called
//        let newDataTask = DataTaskMock(completionHandler: completionHandler)
//        dataTask = newDataTask
//
//        return newDataTask
////        defer { completionHandler(nil, nil, nil)}
////        lastURL = url
////        return DataTaskMock() // TODO: The public init was deprecated for iOS 13.0 and newer. There is no accessable init
//    }
//}

//// MARK: These calsses can be used to check that meaningful data or an error was returned
//class DataTaskMock: URLSessionDataTask {
//    override func resume() { }
//}
//
//class URLSessionMock: URLSessionProtocol {
//    var testData: Data?
//    var error: Error?
//
//    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
//        defer {
//            completionHandler(testData, nil, error)
//        }
//        return DataTaskMock()
//    }
//}
