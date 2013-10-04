//
//  VWWGetEventSearchForm.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWHTTPForm.h"

@interface VWWGetEventSearchForm : VWWHTTPForm
@property (copy, nonatomic) NSString *keywords;
@property (copy, nonatomic) NSString *city;
@end
