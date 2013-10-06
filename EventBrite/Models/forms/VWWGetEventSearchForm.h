//
//  VWWGetEventSearchForm.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWHTTPForm.h"

@interface VWWGetEventSearchForm : VWWHTTPForm
@property (strong, nonatomic) NSString *keywords;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *region;
@property (strong, nonatomic) NSString *postalCode;
@property (strong, nonatomic) NSString *country;
@end
