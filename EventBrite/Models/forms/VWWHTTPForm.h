//
//  VWWHTTPForm.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import <Foundation/Foundation.h>

#import "VWWHTTPFormProtocol.h"

extern const NSInteger kItemsPerPageMax;

@interface VWWHTTPForm : NSObject <VWWHTTPFormProtocol>
- (NSDictionary *)httpParametersDictionary;
- (NSString *)JSONString;
- (void)setObject:(id)value forKey:(NSString *)key inDictionary:(NSMutableDictionary *)dictionary;
- (void)setBool:(BOOL)value forKey:(NSString *)key inDictionary:(NSMutableDictionary *)dictionary;
- (NSString *)descriptionForKeys:(NSString *)first, ...;
@end
