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
#import "VWWEvent.h"
#import "VWWError.h"
#import "VWWSearchResults.h"

// Form includes
#import "VWWGetEventSearchForm.h"

typedef void (^VWWRESTEngineEventBlock)(VWWEvent *event);
typedef void (^VWWRESTEngineSearchResultsBlock)(VWWSearchResults *searchResults);
typedef void (^VWWRESTEngineErrorBlock)(NSError *error);

@interface VWWRESTEngine : MKNetworkEngine

+(VWWRESTEngine*)sharedInstance;
+(void)releaseSingleton;

@property (nonatomic, strong) VWWRESTConfig* service;
@property (nonatomic, readonly) BOOL useHTTPS;

#pragma mark Events
-(MKNetworkOperation*)getEventSearchWithForm:(VWWGetEventSearchForm*)form
                             completionBlock:(VWWRESTEngineSearchResultsBlock)completionBlock
                                  errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

@end
