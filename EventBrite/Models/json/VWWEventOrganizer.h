//
//  VWWEventOrganizer.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWModel.h"

@interface VWWEventOrganizer : VWWModel
+(VWWEventOrganizer*)eventOrganizerWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSURL *url;
@end
