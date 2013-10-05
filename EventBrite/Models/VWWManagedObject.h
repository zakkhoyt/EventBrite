//
//  VWWManagedObject.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface VWWManagedObject : NSManagedObject
-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context;
-(NSString*)description;
@end
