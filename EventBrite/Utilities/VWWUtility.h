//
//  VWWUtility.h
//  VWW
//
//  Created by Aleksandar Tosovic on 5/23/12.
//  Copyright (c) 2012 DFANY. All rights reserved.
//

#import <Foundation/Foundation.h>
]//#import <CoreLocation/CoreLocation.h>

//__attribute ((unused)) static NSString* kGenericError = @"An error occurred while contacting VWW.";

//typedef void (^SMUtilityImageBlock)(UIImage *image);
//typedef void (^SMUtilityStringBlock)(NSString *string);
//@classVWWAsset;

@interface VWWUtility : NSObject{
    NSDateFormatter *internetDateFormatter;
}

//+ (id)sharedUtility;

/**
 @brief Converts internet date/time string to NSDate
 http://www.ietf.org/rfc/rfc3339.txt
 @param dateString intenet formatted date/time string
 @return NSDate instance
 */

//- (NSString *)stringFromDate:(NSDate *)date usingFormat:(NSString *)format;
//- (NSDate *)internetFormattedDateFromString:(NSString *)dateString;
//+ (BOOL)isValidEmail:(NSString *)email;
//
//+ (NSError *)error:(NSString *)message;
//+ (void)serverErrorAlert;
//+ (void)errorAlert:(NSString *)message;
//+ (void)errorAlert:(NSString *)message title:(NSString *)title;
//
//+ (void)sendEmailWithSubject:(NSString *)subject andBody:(NSString *)body addCC:(NSString*)cc fromViewController:(UIViewController*)sender;
//+ (void)sendEmailWithSubject:(NSString *)subject andBody:(NSString *)body addCC:(NSString*)cc addFile:(NSString*)file fromViewController:(UIViewController*)sender;
//+ (void)sendEmailWithSubject:(NSString *)subject andBody:(NSString *)body fromViewController:(UIViewController*)sender;
//+ (void)sendSmsWithBody:(NSString *)body fromViewController:(UIViewController*)sender;
//
//+(NSString*)assetsString:(NSArray*)assetsArray;
//
//+ (void)setLaunchedFlag:(bool)launched;
//+ (bool)getLaunchedFlag;
//
//+ (NSString*)buildAndVersion;
//+ (NSString*)build;
//+ (NSString*)version;
//
//+(void)downloadAsset:(SMAsset*)asset writeToDisk:(BOOL)writeToDisk completion:(SMUtilityImageBlock)completion;
//
//+(NSString*)stringFromLocation:(float)location;
//+(NSString*)stringFromFileSizeInBytes:(NSInteger)size uploaded:(NSInteger)uploaded;
//+(NSString*)stringFromDistanceInMiles:(NSInteger)feet;
//+(NSString*)stringFromDistanceInKilometers:(NSInteger)meters;
//
//
//#pragma mark NSDate stuff
//
//+(NSString*)stringFromDate:(NSDate*)date;
//+(NSString*)timeElapsedStringFromDate:(NSDate*)date;
//+(NSString*)stringFromDateDayOnly:(NSDate*)date;
//+(NSString*)relativeTimeFromDate:(NSDate*)date;
//+(NSString*)stringFromDateAndTime:(NSDate*)date;
//+(NSDate*)dateFromMonth:(NSInteger)month day:(NSInteger)day year:(NSInteger)year;
//+(NSDate*)dateFromMonth:(NSInteger)month
//                    day:(NSInteger)day
//                   year:(NSInteger)year
//                   hour:(NSInteger)hour
//                 minute:(NSInteger)minute
//                 second:(NSInteger)second;
//
//
//+(UIImage*)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
//
//+(NSDictionary*)appendGPSLocation:(CLLocation*)location toMetadata:(NSDictionary*)metadata;
//
//
//
//+(void)locationFromAsset:(SMAsset*)asset withCompletion:(SMUtilityStringBlock)completion;


+(NSDate *)convertFromUTCToLocal:(NSDate*)utcDate;
+(NSDate *)convertFromLocalToUTC:(NSDate*)localDate;

@end
