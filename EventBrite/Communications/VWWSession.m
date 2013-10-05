//
//  VWWSession.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWSession.h"
#import "VWWEventsSearch.h"


static VWWSession *instance;

@interface VWWSession ()
@end

@implementation VWWSession

+(VWWSession*)sharedInstance{
    if(instance == nil){
        instance = [[VWWSession alloc]init];
    }
    return instance;
}


-(id)init{
    self = [super init];
    if(self){
        [self initializeClass];
    }
    return self;
}


#pragma mark Private methods
-(void)initializeClass{

}


@end













