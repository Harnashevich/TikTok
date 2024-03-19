//
//  TikTokTests.swift
//  TikTokTests
//
//  Created by Andrei Harnashevich on 19.03.24.
//

import XCTest

@testable import TikTok

final class TikTokTests: XCTestCase {

    func testPostChildPath() {
        let id = UUID().uuidString
        let user = User(
            username: "billgates",
            profilePictureURL: nil,
            identifier: "123"
        )
        let post = PostModel(
            identifier: id,
            user: user
        )
        
        XCTAssertTrue(post.caption.isEmpty)
    }
}
