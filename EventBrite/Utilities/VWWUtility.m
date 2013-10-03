//
// VWWUtility.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWUtility.h"

@interface VWWUtility ()
@property (nonatomic, strong) NSDateFormatter *internetDateFormatter;
@end

@implementation VWWUtility
+ (id)sharedUtility {
    static dispatch_once_t onceToken;
    static VWWUtility *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VWWUtility alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        // Date formatter setup
        _internetDateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [_internetDateFormatter setLocale:enUSPOSIXLocale];
        [_internetDateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [_internetDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

    }
    return self;
}
@end

@implementation VWWUtility (dates)
- (NSString *)stringFromDate:(NSDate *)date usingFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

- (NSDate *)internetFormattedDateFromString:(NSString *)dateString {
    @synchronized(self.internetDateFormatter) {
        return [self.internetDateFormatter dateFromString:dateString];
    }
}

+ (NSDate *) convertFromUTCToLocal:(NSDate*)utcDate{
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [timeZone secondsFromGMTForDate:utcDate];
    return [NSDate dateWithTimeInterval: seconds sinceDate:utcDate];
}

+ (NSDate *) convertFromLocalToUTC:(NSDate*)localDate{
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSInteger seconds = -[timeZone secondsFromGMTForDate: localDate];
    return [NSDate dateWithTimeInterval: seconds sinceDate: localDate];
}
@end

@implementation VWWUtility (alerts)
+ (void)errorAlert:(NSString *)message title:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end

@implementation VWWUtility (strings)

+ (BOOL)isValidEmail:(NSString *)email {
    // Regular expression for email vaidation setup
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$";
    NSRegularExpression *emailValidationRegEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    return 0 < [emailValidationRegEx numberOfMatchesInString:email options:0 range:NSMakeRange(0, [email length])];
}
@end