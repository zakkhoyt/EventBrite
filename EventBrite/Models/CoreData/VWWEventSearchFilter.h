//
//  VWWEventSearchFilter.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VWWManagedObject.h"

@interface VWWEventSearchFilter : VWWManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSManagedObject *eventsSummary;
-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context;
@end
