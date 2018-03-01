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

- (void)testConcatString {
    char str0[256] = "Donald is";
    XCTAssertEqual(9, strlen(str0));
    char str1[128] = " learning C++.";
    StringTestsUtils::concatString(str0, str1);
    XCTAssertEqual(0, strcmp("Donald is learning C++.", str0)); // 0 means equal
    XCTAssertEqual(23, strlen(str0));
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

- (void)testStrlen {
    XCTAssertEqual(6, strlen("Donald"));
    XCTAssertEqual(0, strlen(""));
    char lastName[] = "Sheng";
    XCTAssertEqual(5, strlen(lastName));
}

- (void)testStrcpy {
    char* target = new char[20];
    char source[] = "Donald";
    strcpy(target, source);
    XCTAssertEqual(0, strcmp("Donald", target));
    XCTAssertEqual(0, strncmp("Donald", target, strlen(target)));
}

- (void)testStrncpy {
    char* target = new char[20];
    char source[] = "Donald";
    strncpy(target, source, 3);
    XCTAssertEqual(0, strcmp("Don", target));
    XCTAssertEqual(0, strncmp("Don", target, strlen(target)));
    
    strncpy(target, source, 18);
    XCTAssertEqual(0, strcmp("Donald", target));
}

- (void)testStrncat {
    char target[] = "Donald";
    char source[] = " Sheng";
    char* fullname = strncat(target, source, 4);
    XCTAssertEqual(0, strncmp("Donald Shen", fullname, strlen(target)));
}

- (void)testStrcmp {
    char name0[] = "donald";
    char name1[] = "frank";
    char name2[] = "gavin";
    XCTAssertEqual(-2, strcmp(name0, name1));
    XCTAssertEqual(2, strcmp(name1, name0));
    XCTAssertEqual(3, strcmp(name2, name0));
}

- (void)testStrstr {
    char frank[] = "frank";
    char an[] = "an";
    char* result = strstr(frank, an);
    XCTAssertTrue(NULL == strstr(frank, "ann"));
    XCTAssertTrue(NULL != strstr(frank, "an"));
    XCTAssertEqual(0, strcmp("ank", result));
}

- (void)testWcslen {
    char donald[] = "盛志军";
    wchar_t sheng[] = L"盛志军";
    XCTAssertEqual(9, strlen(donald));
    XCTAssertEqual(3, wcslen(sheng));
    XCTAssertEqual(6, wcslen(L"donald"));
    std::cout << donald << std::endl; // printed out "盛志军"
    std::wcout << sheng << std::endl; // printed out nothing
}

class StringTestsUtils {
public:
    static void concatString(char target[], const char source[]) {
        // find the end of the first string
        int targetIndex = 0;
        while(target[targetIndex]) {
            targetIndex++;
        }
        
        // tack teh second onto the end of the first
        int sourceIndex = 0;
        while(source[sourceIndex]) {
            target[targetIndex] = source[sourceIndex];
            targetIndex++;
            sourceIndex++;
        }
        
        // tack on the terminating null
        target[targetIndex] = '\0';
    }
    
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
