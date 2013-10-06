//
//  VWWEventAnnotation.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventAnnotation.h"
#import "VWWEvent.h"
#import "VWWUtility.h"

@implementation VWWEventAnnotation
-(void)setEvent:(VWWEvent *)event{
    _event = event;
    self.title = event.title;
    if(event.startDate){
        self.subtitle = event.startDate;
    }
}
@end