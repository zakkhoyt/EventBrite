//
//  EventBriteTests.m
//  EventBriteTests
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VWWRESTEngine.h"

#import "VWWCoreData.h"

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


-(void)testCoreData{

    VWWCoreData *coreData = [[VWWCoreData alloc]init];
    NSManagedObjectContext *context = [coreData managedObjectContext];
    NSManagedObject *search = [NSEntityDescription
                               insertNewObjectForEntityForName:@"Search"
                               inManagedObjectContext:context];
    [search setValue:@"iPhone" forKey:@"keywords"];
    [search setValue:@"San Francisco" forKey:@"city"];
    
    NSManagedObject *results = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Results"
                                inManagedObjectContext:context];
    [results setValue:@(21) forKey:@"dictionary_count"];
    [search setValue:results forKey:@"results"];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    
    
    //Print out what we just wrote
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Search" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"keywords: %@", [info valueForKey:@"keywords"]);
        NSLog(@"city: %@", [info valueForKey:@"city"]);
        NSManagedObject *results = [info valueForKey:@"results"];
        NSLog(@"results count: %@", [results valueForKey:@"dictionary_count"]);
    }
}

//- (void)testExample{
//    __block BOOL complete = NO;
//    
//    
//    [self eventSearchWithCompletion:^(NSError *error) {
//        XCTAssertNil(error, @"Failed event search");
//        complete = YES;
//    }];
//    
//    while (!complete) {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    }
//    complete = NO;
//
//}
//
//
//
//
//-(void)eventSearchWithCompletion:(VWWErrorBlock)completion{
//    VWWGetEventSearchForm *form = [[VWWGetEventSearchForm alloc]init];
//    form.keywords = @"";
//    form.city = @"boise";
//    [[VWWRESTEngine sharedInstance] getEventSearchWithForm:form
//                                           completionBlock:^(VWWEvents *events) {
//                                               completion(nil);
//                                           } errorBlock:^(NSError *error) {
//                                               completion(error);
//                                           }];
//}

@end