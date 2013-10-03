//
//  VWWEngine.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//

#import "MKNetworkEngine.h"
#import "VWWRESTConfig.h"

// Model includes
#import "VWWHTTPForm.h"
#import "VWWUser.h"
#import "VWWEvent.h"

// Form includes
#import "VWWCreateEventForm.h"
#import "VWWGetEventsForm.h"


typedef void (^VWWRESTEngineEventBlock)(VWWEvent *event);
typedef void (^VWWRESTEngineEventsBlock)(NSArray *events);
typedef void (^VWWRESTEngineErrorBlock)(NSError *error);

@interface VWWRESTEngine : MKNetworkEngine

+(VWWRESTEngine*)sharedInstance;
+(void)releaseSingleton;

@property (nonatomic, strong) VWWRESTConfig* service;
@property (nonatomic, readonly) BOOL useHTTPS;




#pragma mark Events
-(MKNetworkOperation*)createEventWithForm:(VWWCreateEventForm*)form
                           completionBlock:(VWWRESTEngineEventBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)getEventsWithForm:(VWWGetEventsForm*)form
                        completionBlock:(VWWRESTEngineEventsBlock)completionBlock
                             errorBlock:(VWWRESTEngineErrorBlock)errorBlock;


@end
