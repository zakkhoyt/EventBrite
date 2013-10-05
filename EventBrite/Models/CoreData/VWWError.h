//
//  VWWError.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWError : NSObject
+(id)errorWithDictionary:(NSDictionary *)dictionary;


@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *type;
@end
