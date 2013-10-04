//
//  VWWEventsSearch.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VWWEvents;

@interface VWWEventsSearch : NSObject
@property (nonatomic, strong) NSDictionary *searchParemeters;
@property (nonatomic, strong) VWWEvents *events;
-(NSString*)searchHash;
@end
