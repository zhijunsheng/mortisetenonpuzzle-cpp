//
//  StringTests.mm
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-02-28.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <iostream>
#import <vector>
#import <string>

@interface StringTests : XCTestCase

@end

@implementation StringTests

- (void)testStringVector {
    std::vector<std::string> colors;
    colors.push_back("Blue");
    colors.push_back("Red");
    colors.push_back("Orange");
    colors.push_back("Yellow");
    XCTAssertEqual(4, colors.size());
    XCTAssertEqual("Blue", colors.at(0));
    XCTAssertEqual("Orange", colors.at(2));
}

- (void)testStringArray {
    std::string colors[4] = {"Blue", "Red", "Orange", "Yellow"};
    XCTAssertEqual("Yellow", colors[3]);
}

- (void)testConcatCharString {
    std::cout << StringTestsUtils::concatCharString("Donald", "Paul") << std::endl;
    XCTAssertEqual(0, strcmp("DonaldPaul", StringTestsUtils::concatCharString("Donald", "Paul")));
    
    XCTAssertEqual("DonaldPaul", std::string("Donald") + std::string("Paul"));
}

- (void)testRemoveSpaces {
    XCTAssertEqual("Donaldlovesbadminton.", StringTestsUtils::removeSpaces("Donald loves badminton."));
}

- (void)testEraseFindInsert {
    XCTAssertEqual("Donld", std::string("Donald").erase(3, 1));
    
    XCTAssertEqual(4, std::string("Donald").find("ld"));
    XCTAssertEqual(std::string::npos, std::string("Donald").find("ldM"));
    
    XCTAssertEqual("DPaulonald", std::string("Donald").insert(1, "Paul"));
}

class StringTestsUtils {
public:
    static char* concatCharString(const char* s0, const char* s1) {
        long length = strlen(s0) + strlen(s1) + 1;
        char* s = new char[length];
        strcpy(s, s0);
        strcat(s, s1);
        return s;
    }
    
    static std::string removeSpaces(const std::string& source) {
        // make a copy of the source stirng so that we don't modify it
        std::string s = source;
        
        // find the offset of the first space;
        // search the string until no more spaces founce
        size_t offset;
        while((offset = s.find(" ")) != std::string::npos) {
            // remove the space just discovered
            s.erase(offset, 1);
        }
        return s;
    }
};

@end
