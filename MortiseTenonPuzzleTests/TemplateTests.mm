//
//  TemplateTests.cpp
//  MortiseTenonPuzzleTests
//
//  Created by Donald Sheng on 2018-02-28.
//  Copyright © 2018 GoldThumb Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <string>
#import "templatevector.h"

@interface TemplateTests : XCTestCase

@end

@implementation TemplateTests

- (void)testTemplateVectorWithStrings {
    TemplateVector<std::string> stringVector(100);
    XCTAssertEqual(0, stringVector.size());
    stringVector.add("Donald");
    stringVector.add("John");
    stringVector.add("Alex");
    XCTAssertEqual(3, stringVector.size());
    XCTAssertEqual("Donald", stringVector.get());
    XCTAssertEqual("John", stringVector.get());
    
    stringVector.reset();
    XCTAssertEqual(0, stringVector.size());
    XCTAssertEqual("Donald", stringVector.get()); // haha :-D
}

- (void)testTemplateVectorWithIntegers {
    TemplateVector<int> intVector(100);
    XCTAssertEqual(0, intVector.size());
    intVector.add(7);
    intVector.add(13);
    intVector.add(17);
    XCTAssertEqual(3, intVector.size());
    XCTAssertEqual(7, intVector.get());
    XCTAssertEqual(13, intVector.get());
    
    intVector.reset();
    XCTAssertEqual(0, intVector.size());
    XCTAssertEqual(7, intVector.get()); // haha :-D
}

- (void)testTemplate {
    XCTAssertEqual(2.5, TemplateTestUtils::maximum(2.2, 2.5));
    XCTAssertEqual(5, TemplateTestUtils::maximum(2, 5));
    XCTAssertEqual('b', TemplateTestUtils::maximum('a', 'b')); // calling maximum<T>(T, T)
}

class TemplateTestUtils {
public:
    static double maximum(double d0, double d1) {
        return d0 > d1 ? d0 : d1;
    }
    
    static int maximum(int n0, int n1) {
        return n0 > n1 ? n0 : n1;
    }
    
    template <class T> static T maximum(T t0, T t1) {
        return t0 > t1 ? t0 : t1;
    }
};

- (void)testTemplateVectorWithNames {
    TemplateVector<Name> nameVector(100);
    XCTAssertEqual(0, nameVector.size());
    nameVector.add(Name("Donald"));
    nameVector.add(Name("John"));
    nameVector.add(Name("Alex"));
    XCTAssertEqual(3, nameVector.size());
    XCTAssertEqual("Donald", nameVector.get().display());
    XCTAssertEqual("John", nameVector.get().display());

    nameVector.reset();
    XCTAssertEqual(0, nameVector.size());
    XCTAssertEqual("Donald", nameVector.get().display()); // haha :-D
}

class Name {
public:
    Name() = default;
    Name(std::string s): name(s){}
    const std::string& display() { return name; }
protected:
    std::string name;
};

@end
