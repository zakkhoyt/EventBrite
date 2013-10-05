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


-(void)testParsing{
    __block BOOL complete = NO;
    
    VWWGetEventSearchForm *form = [[VWWGetEventSearchForm alloc]init];
    form.city = @"San Francisco";
    form.keywords = @"iPhone";
    [[VWWRESTEngine sharedInstance] getEventSearchWithForm:form completionBlock:^(VWWSearchResults *searchResults) {
        // Temp: write our data out
        NSError *cdError;
        VWWCoreData *coreData = [VWWCoreData sharedInstance];
        NSManagedObjectContext *context = [coreData managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"VWWSearchResults" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&cdError];
        
        for(VWWSearchResults *searchResults in fetchedObjects){
            
            // Check for and print summary
            VWWEventsSummary *summary = searchResults.eventsSummary;
            XCTAssertNotEqual(summary, 0, @"There are no objects in summary");
            XCTAssertNotNil(summary.totalItems, @"%s", __FUNCTION__);
            XCTAssertNotNil(summary.firstEvent, @"%s", __FUNCTION__);
            XCTAssertNotNil(summary.lastEvent, @"%s", __FUNCTION__);
            XCTAssertNotNil(summary.numShowing, @"%s", __FUNCTION__);
            
            NSLog(@"summary--------------------------------");
            NSLog(@"summar.totalItem: %@", summary.totalItems);
            NSLog(@"Summary.firstEvent: %@", summary.firstEvent);
            NSLog(@"Summary.lastEvent: %@", summary.lastEvent);
            NSLog(@"Summary.numShowing: %@", summary.numShowing);
            
            // Check for and print events
            
            NSSet *events = searchResults.events;
            NSLog(@"Found %d events for this search", events.count);
            for(VWWEvent *event in events){
                XCTAssertNotEqual(event, 0, @"Event is nil");
                NSLog(@"event: %@", event.description);
            
                VWWEventOrganizer *organizer = event.eventOrganizer;
                XCTAssertNotEqual(organizer, 0, @"Event has no organizer");
                NSLog(@"orgainizer: %@", organizer.description);
                
                
                
            }
        }
        complete = YES;

    } errorBlock:^(NSError *error) {
       
    }];
    
    
    while (!complete) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    
}

//
//-(void)testCoreData{
//
//
//    VWWCoreData *coreData = [[VWWCoreData alloc]init];
//    NSManagedObjectContext *context = [coreData managedObjectContext];
//    NSManagedObject *search = [NSEntityDescription
//                               insertNewObjectForEntityForName:@"Search"
//                               inManagedObjectContext:context];
//    [search setValue:@"iPhone" forKey:@"keywords"];
//    [search setValue:@"San Francisco" forKey:@"city"];
//    
//    NSManagedObject *results = [NSEntityDescription
//                                insertNewObjectForEntityForName:@"Results"
//                                inManagedObjectContext:context];
//    [results setValue:@(21) forKey:@"dictionary_count"];
//    [search setValue:results forKey:@"results"];
//    NSError *error;
//    if (![context save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//    }
//    
//    
//    
//    //Print out what we just wrote
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"Search" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    for (NSManagedObject *info in fetchedObjects) {
//        NSLog(@"keywords: %@", [info valueForKey:@"keywords"]);
//        NSLog(@"city: %@", [info valueForKey:@"city"]);
//        NSManagedObject *results = [info valueForKey:@"results"];
//        NSLog(@"results count: %@", [results valueForKey:@"dictionary_count"]);
//    }
//    
//}

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