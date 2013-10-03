//
//  VWWPageForm.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import <Foundation/Foundation.h>
#import "VWWHTTPForm.h"

@interface VWWPageForm : VWWHTTPForm
@property (strong, nonatomic) NSNumber *page;
@property (strong, nonatomic) NSNumber *perPage;
@end
