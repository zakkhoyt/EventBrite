//
//  VWWCreateEventForm.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWHTTPForm.h"

@interface VWWCreateEventForm : VWWHTTPForm
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *latitude;
@property (copy, nonatomic) NSString *longitude;
//@property (copy, nonatomic) NSDate *startAt;
//@property (copy, nonatomic) NSDate *endAt;
@end
