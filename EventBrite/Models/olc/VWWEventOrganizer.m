//
//  VWWEventOrganizer.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventOrganizer.h"

@implementation VWWEventOrganizer

-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (dictionary == nil) {
        return nil;
    }
    
    self = [super init];
    if(self){
        _ID = [dictionary numberForKey:@"id"];
        _name = [dictionary stringForKey:@"name"];
        _description = [dictionary stringForKey:@"description"];
        _url = [dictionary urlForKey:@"url"];
        

    }
    return self;
}

+(VWWEventOrganizer*)eventOrganizerWithDictionary:(NSDictionary *)dictionary{
    return [[VWWEventOrganizer alloc]initWithDictionary:dictionary];
}


@end
