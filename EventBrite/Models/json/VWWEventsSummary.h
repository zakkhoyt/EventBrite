//
//  VWWEventsSummary.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWModel.h"

@interface VWWEventsSummary : VWWModel
+(id)eventsSummaryWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic, strong) NSDictionary *filters;
@property (nonatomic, strong) NSNumber *firstEvent;
@property (nonatomic, strong) NSNumber *lastEvent;
@property (nonatomic, strong) NSNumber *numShowing;
@property (nonatomic, strong) NSNumber *totalItems;
@end
