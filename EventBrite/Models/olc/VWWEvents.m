//
//  VWWEvents.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEvents.h"

@implementation VWWEvents
-(id)init{
    self = [super init];
    if(self){
        _events = [@[]mutableCopy];
    }
    return self;
}
@end
