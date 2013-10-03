
#import <Foundation/Foundation.h>

@interface NSDictionary (TypedGetters)

- (NSString *)stringForKey:(NSString *)key;
- (NSURL *)urlForKey:(NSString *)key;
- (NSDate *)dateForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (NSInteger)intForKey:(NSString *)key;
- (NSUInteger)uintForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key;

@end
