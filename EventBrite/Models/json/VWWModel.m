//
// VWWModel.m
//  Smile
//
//  Created by Thomas Goyne on 7/30/12.
//

#import "SMModel.h"

@implementationVWWModel

- (NSString *)descriptionForKeys:(NSString *)first, ... {
    NSMutableString *desc = [NSMutableString stringWithFormat:@"<%@:%p %@:%@",
                             NSStringFromClass([self class]), self,
                             first, [self valueForKey:first]];

    va_list args;
    va_start(args, first);
    for (NSString *key = nil; (key = va_arg(args, NSString *)); ) {
        [desc appendFormat:@" %@:%@", key, [self valueForKey:key]];
    }

    return [desc stringByAppendingString:@">"];
}

@end
