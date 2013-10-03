//
// VWWHTTPFormProtocol.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import <Foundation/Foundation.h>

@protocol VWWHTTPFormProtocol <NSObject>
@optional
- (NSDictionary *)httpParametersDictionary;
- (NSString *)JSONString;

@end
