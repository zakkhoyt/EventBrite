//
//  VWWSession.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import <Foundation/Foundation.h>
@class  VWWEventsSearch;


@interface VWWSession : NSObject

+(VWWSession*)sharedInstance;
@property (nonatomic, strong) VWWEventsSearch *currentEventsSearch;
@end
