//
//  VWWEventsSearch.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class VWWGetEventSearchForm;
@class VWWSearchResults;

@interface VWWEventsSearch : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * keywords;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) VWWSearchResults *searchResults;
-(void)populateWithForm:(VWWGetEventSearchForm*)form context:(NSManagedObjectContext*)context;
@end
