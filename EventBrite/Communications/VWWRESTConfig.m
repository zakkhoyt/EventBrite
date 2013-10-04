//
//  VWWRESTConfig.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWRESTConfig.h"

//#import "SMAppDelegate.h"

static VWWRESTConfig *instance;


@interface VWWRESTConfig ()

@end

@implementation VWWRESTConfig
+(VWWRESTConfig*)sharedInstance{
    if(instance == nil){
        instance = [[VWWRESTConfig alloc]init];
    };
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
        
        [self readUserDefaults];

        _serviceDataFormat = @"json";
//        _serviceEventsURI = @"events";
        _serviceEventSearchURI = @"event_search";
    }
    return self;
}

-(void)readUserDefaults{
    _serviceSecure = [VWWUserDefaults serverSecure];
    _server =  [VWWUserDefaults server];
    _server = [_server stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    _server = [_server stringByReplacingOccurrencesOfString:@"HTTP://" withString:@""];
    _server = [_server stringByReplacingOccurrencesOfString:@"ftp://" withString:@""];
    _server = [_server stringByReplacingOccurrencesOfString:@"FTP://" withString:@""];
    
    _serviceDomain = _server;
    _serviceEndpoint = [NSString stringWithFormat:@"%@", _server];
}

-(void)refreshServerFromUserDefaults{
    [self readUserDefaults];
}


@end