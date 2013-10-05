//
//  VWWEvents.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VWWEventsSummary;
@class VWWEvent;

@interface VWWEvents : NSObject
@property (nonatomic, strong) VWWEventsSummary *summary;
@property (nonatomic, strong) NSMutableArray *events;
@end
