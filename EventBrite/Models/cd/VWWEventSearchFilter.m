//
//  VWWEventSearchFilter.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventSearchFilter.h"

//{
//    summary =     {
//        filters =         {
//            city = boise;
//        };
//        "first_event" = 8334848757;
//        "last_event" = 8135113343;
//        "num_showing" = 10;
//        "total_items" = 108;
//    };
//}

@implementation VWWEventSearchFilter

@dynamic key;
@dynamic value;
@dynamic eventsSummary;
-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context{
    
//    NSMutableSet *filters
//    for(NSString *key in dictionary.allKeys){
//        NSString *value = dictionary[key];
//        
//    }
}

-(NSString*)description{
    return [NSString stringWithFormat:@""];
}

@end
