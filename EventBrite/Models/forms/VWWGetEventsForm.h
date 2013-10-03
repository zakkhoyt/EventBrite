//
//  VWWGetEventsForm.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWHTTPForm.h"

@interface VWWGetEventsForm : VWWHTTPForm

@property (copy, nonatomic) NSNumber *radius;
@property (copy, nonatomic) NSNumber *latitude;
@property (copy, nonatomic) NSNumber *longitude;
@property (nonatomic) BOOL search;
@property (nonatomic) BOOL isActive;
@end
 