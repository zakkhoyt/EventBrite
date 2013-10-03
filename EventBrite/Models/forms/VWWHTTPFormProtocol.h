//
//  SMHTTPFormProtocol.h
//  SmileModel
//
//  Copyright (c) 2012 Webshots. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMHTTPFormProtocol <NSObject>
@optional
- (NSDictionary *)httpParametersDictionary;
- (NSString *)JSONString;

@end
