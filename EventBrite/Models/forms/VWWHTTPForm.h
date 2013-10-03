//
// VWWHTTPForm.h
//  Smile
//
//  Created by Zakk Hoyt
//  Copyright (c) 2013. Webshots.
//

#import <Foundation/Foundation.h>

#import "SMHTTPFormProtocol.h"

extern const NSInteger kItemsPerPageMax;

@interfaceVWWHTTPForm : NSObject <SMHTTPFormProtocol>
- (NSDictionary *)httpParametersDictionary;
- (NSString *)JSONString;
- (void)setObject:(id)value forKey:(NSString *)key inDictionary:(NSMutableDictionary *)dictionary;
- (void)setBool:(BOOL)value forKey:(NSString *)key inDictionary:(NSMutableDictionary *)dictionary;
- (NSString *)descriptionForKeys:(NSString *)first, ...;
@end
