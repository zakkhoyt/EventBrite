//
//  VWWRESTSession.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import <Foundation/Foundation.h>



typedef enum{
    VWWRESTSessionErrorUnknown = 1,
} VWWRESTSessionErrors;

@interface VWWRESTSession : NSObject

+(VWWRESTSession*)sharedInstance;


@end