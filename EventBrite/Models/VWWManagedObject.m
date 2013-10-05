//
//  VWWManagedObject.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWManagedObject.h"

@implementation VWWManagedObject
-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context{
    NSAssert(nil, @"Implementnation error: Child class must implement this method");
}
-(NSString*)description{
    NSAssert(nil, @"Implementnation error: Child class must implement this method");
    return nil;
}

@end
