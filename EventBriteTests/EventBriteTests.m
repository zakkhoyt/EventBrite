//
//  EventBriteTests.m
//  EventBriteTests
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VWWRESTEngine.h"



@interface EventBriteTests : XCTestCase

@end

@implementation EventBriteTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample{
    __block BOOL complete = NO;
    
    
    [self eventSearchWithCompletion:^(NSError *error) {
        XCTAssertNil(error, @"Failed event search");
        complete = YES;
    }];
    
    while (!complete) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    complete = NO;

}




-(void)eventSearchWithCompletion:(VWWErrorBlock)completion{
    VWWGetEventSearchForm *form = [[VWWGetEventSearchForm alloc]init];
    form.keywords = @"";
    form.city = @"boise";
    [[VWWRESTEngine sharedInstance] getEventSearchWithForm:form
                                           completionBlock:^(NSArray *events) {
                                               completion(nil);
                                           } errorBlock:^(NSError *error) {
                                               completion(error);
                                           }];
}

@end