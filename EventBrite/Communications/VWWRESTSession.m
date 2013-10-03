//
//  VWWRESTSession.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWRESTSession.h"
#import "VWWRESTEngine.h"
#import "VWWUtility.h"



static VWWRESTSession *instance;

@interface VWWRESTSession ()
@property (nonatomic, strong) VWWRESTEngine *rest;
@property (nonatomic, strong) MKNetworkOperation *operation;
@property (nonatomic) dispatch_queue_t queue;
@end

@implementation VWWRESTSession

+(VWWRESTSession*)sharedInstance{
    if(instance == nil){
        instance = [[VWWRESTSession alloc]init];
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
    
    _queue = dispatch_queue_create("com.vaporwareworlf.session", NULL);
    dispatch_async(_queue, ^{

    });
}


@end













