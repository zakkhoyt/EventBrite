//
//  VWWEventOrganizer.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VWWManagedObject.h"
#import "VWWManagedObject.h"

@class VWWEvent;

@interface VWWEventOrganizer : VWWManagedObject
-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context;
@property (nonatomic, retain) NSNumber * uuid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) VWWEvent *event;

@end
