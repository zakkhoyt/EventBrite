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


-(void)testRESTQueryParsingStoreAndPull{
    __block BOOL complete = NO;

    // Make a query with something that will for sure have results
    VWWGetEventSearchForm *form = [[VWWGetEventSearchForm alloc]init];
    form.city = @"San Francisco";
    form.keywords = @"iPhone";

    // Although the data is returned by this block, let's not use it and instead pull it from the database and parse it
    [[VWWRESTEngine sharedInstance] getEventSearchWithForm:form completionBlock:^(VWWEventsSearch *DONT_USE) {
        NSError *cdError;
        VWWCoreData *coreData = [VWWCoreData sharedInstance];
        NSManagedObjectContext *context = [coreData managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"VWWEventsSearch" inManagedObjectContext:context];
        
        
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&cdError];

        
        
        NSLog(@"-------------------------------------------- event search ---------------------------------");
//        for(VWWSearchResults *searchResults in fetchedObjects){
        for(VWWEventsSearch *eventsSearch in fetchedObjects){
            
            XCTAssertNotNil(eventsSearch, @"Search is nil");
            NSLog(@"********************************************** search parameters **************************************");
            NSLog(@"eventsSearch: %@", eventsSearch.description);
            
            
            VWWSearchResults *searchResults = eventsSearch.searchResults;
            NSLog(@"********************************************** search results **************************************");
            NSLog(@"searchResults: %@", searchResults.description);
            
            
            // Check for and print summary
            VWWEventsSummary *summary = searchResults.eventsSummary;
            XCTAssertNotEqual(summary, 0, @"There are no objects in summary");
            XCTAssertNotNil(summary.totalItems, @"%s", __FUNCTION__);
            XCTAssertNotNil(summary.firstEvent, @"%s", __FUNCTION__);
            XCTAssertNotNil(summary.lastEvent, @"%s", __FUNCTION__);
            XCTAssertNotNil(summary.numShowing, @"%s", __FUNCTION__);
            
            NSLog(@"********************************************** summary **************************************");
            NSLog(@"summary: %@", summary.description);
            
            // Check for and print events
            
            NSSet *events = searchResults.events;
            NSLog(@"Found %d events for this search", events.count);
            for(VWWEvent *event in events){
                XCTAssertNotNil(event, @"Event is nil");
                NSLog(@"********************************************** event **************************************");
                NSLog(@"event: %@", event.description);
            
                VWWEventOrganizer *organizer = event.eventOrganizer;
                XCTAssertNotNil(organizer, @"Event has no organizer");
                NSLog(@"********************************************** organizer **************************************");
                NSLog(@"orgainizer: %@", organizer.description);
                
                VWWEventVenue *venue = event.eventVenue;
                XCTAssertNotNil(venue, @"Event has no venue");
                NSLog(@"********************************************** venue **************************************");
                NSLog(@"venue: %@", venue.description);
                
                NSSet *tickets = event.eventTickets;
                XCTAssertNotNil(tickets, @"Event has no tickets");
                
                for(VWWEventTicket *ticket in tickets){
                    XCTAssertNotNil(tickets, @"Ticket is nil");
                    NSLog(@"********************************************** ticket **************************************");
                    NSLog(@"ticket: %@", ticket.description);
                }
                
            }
        }
        complete = YES;

    } errorBlock:^(NSError *error) {
       
    }];
    
    
    while (!complete) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    
}



@end