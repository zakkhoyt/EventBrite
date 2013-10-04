//
//  VWWRESTConfig.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import <Foundation/Foundation.h>



@interface VWWRESTConfig : NSObject
@property (nonatomic) BOOL serviceSecure;
@property (nonatomic, strong) NSString* server;
@property (nonatomic, strong) NSString* serviceDomain;
@property (nonatomic, strong) NSString* serviceDataFormat;
@property (nonatomic, strong) NSString* serviceEndpoint;

//@property (nonatomic, strong) NSString* serviceEventsURI;
@property (nonatomic, strong) NSString* serviceEventSearchURI;


+(VWWRESTConfig*)sharedInstance;
-(void)refreshServerFromUserDefaults;
@end