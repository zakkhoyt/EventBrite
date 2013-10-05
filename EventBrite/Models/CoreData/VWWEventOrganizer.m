//
//  VWWEventOrganizer.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventOrganizer.h"
#import "VWWEvent.h"


@implementation VWWEventOrganizer

@dynamic uuid;
@dynamic name;
@dynamic url;
@dynamic about;
@dynamic event;
-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context{
    self.uuid = dictionary[@"id"];
    self.name = dictionary[@"name"];
    self.about = dictionary[@"description"];
    self.url = dictionary[@"url"];
}
-(NSString*)description{
    return [NSString stringWithFormat:@"id: %@"
            @"name: %@"
            @"description: %@"
            @"url: %@",
            self.uuid,
            self.name,
            self.about,
            self.url];
}

@end
