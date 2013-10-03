//
// VWWUtility.m
//  VWW
//
//  Created by Aleksandar Tosovic on 5/23/12.
//  Copyright (c) 2012 DFANY. All rights reserved.
//

#import "VWWUtility.h"
//#import "SMUser.h"
//#import "SMAppDelegate.h"
//#import "SMAsset.h"
//#import <MessageUI/MessageUI.h>
//#import "NSDate+Utilities.h"
//
//#import <ImageIO/ImageIO.h>

//static NSString* kLaunchedAppKey = @"launchedApp";

@implementationVWWUtility
//
+ (id)sharedUtility {
    static dispatch_once_t onceToken;
    staticVWWUtility *sharedInstance = nil;
    dispatch_once(&onceToken, ^{ sharedInstance = [[SMUtility alloc] init]; });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        // Date formatter setup
        internetDateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [internetDateFormatter setLocale:enUSPOSIXLocale];
        [internetDateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [internetDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

    }
    return self;
}

//
//- (NSString *)stringFromDate:(NSDate *)date usingFormat:(NSString *)format {
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    [dateFormatter setDateFormat:format];
//    return [dateFormatter stringFromDate:date];
//}
//
//- (NSDate *)internetFormattedDateFromString:(NSString *)dateString {
//    @synchronized(internetDateFormatter) {
//        return [internetDateFormatter dateFromString:dateString];
//    }
//}
//
//+ (BOOL)isValidEmail:(NSString *)email {
//    // Regular expression for email vaidation setup
//    
//    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$";
//    NSRegularExpression *emailValidationRegEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
//    return 0 < [emailValidationRegEx numberOfMatchesInString:email options:0 range:NSMakeRange(0, [email length])];
//}
//
//+ (NSError *)error:(NSString *)message {
//    NSDictionary *errorInfo = @{NSLocalizedDescriptionKey: message};
//    return [NSError errorWithDomain:kVWWErrorDomain code:1 userInfo:errorInfo];
//}
//
//+ (void)serverErrorAlert {
//    [self errorAlert:@"Oops, something went wrong :) Please try again later."
//               title:@"Problem with connecting to VWW"];
//
//}
//
//+ (void)errorAlert:(NSString *)message {
//    [self errorAlert:message title:nil];
//
//}
//
//+ (void)errorAlert:(NSString *)message title:(NSString *)title {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                    message:message
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//}
//
//+ (void)sendEmailWithSubject:(NSString *)subject andBody:(NSString *)body addCC:(NSString*)cc fromViewController:(UIViewController*)sender {
//    if (![MFMailComposeViewController canSendMail]) return;
//    
//    MFMailComposeViewController *compose = [[MFMailComposeViewController alloc] init];
//    compose.mailComposeDelegate = [self sharedUtility];
//    compose.subject = subject;
//    if(cc != nil){
//        NSArray* recipients = @[cc];
//        [compose setCcRecipients:recipients];
//    }
//    [compose setMessageBody:body isHTML:YES];
//    [sender presentViewController:compose animated:YES completion:nil];
//    
//}
//
//+ (void)sendEmailWithSubject:(NSString *)subject andBody:(NSString *)body addCC:(NSString*)cc addFile:(NSString*)file fromViewController:(UIViewController*)sender {
//    if (![MFMailComposeViewController canSendMail]) return;
//    
//    MFMailComposeViewController *compose = [[MFMailComposeViewController alloc] init];
//    compose.mailComposeDelegate = [self sharedUtility];
//    compose.subject = subject;
//    if(cc != nil){
//        NSArray* recipients = @[cc];
//        [compose setCcRecipients:recipients];
//    }
//    [compose setMessageBody:body isHTML:YES];
//    [compose addAttachmentData:[NSData dataWithContentsOfFile:file] mimeType:nil fileName:@"logs.zip"];
//    [sender presentViewController:compose animated:YES completion:nil];
//    
//}
//
//
//
//+ (void)sendEmailWithSubject:(NSString *)subject andBody:(NSString *)body fromViewController:(UIViewController*)sender {
//    [self sendEmailWithSubject:subject andBody:body addCC:nil fromViewController:sender];
//}
//
//+ (void)sendSmsWithBody:(NSString *)body  fromViewController:(UIViewController*)sender{
//    if (![MFMessageComposeViewController canSendText]) return;
//
//    MFMessageComposeViewController *sms = [[MFMessageComposeViewController alloc] init];
//    [sms setMessageComposeDelegate:[self sharedUtility]];
//    [sms setBody:body];
//    [sender presentViewController:sms animated:YES completion:nil];
//}
//
//+ (void)setLaunchedFlag:(bool)launched{
//    [[NSUserDefaults standardUserDefaults] setBool:launched forKey:kLaunchedAppKey];
//}
//
//+ (bool)getLaunchedFlag{
//    return [[NSUserDefaults standardUserDefaults]boolForKey:kLaunchedAppKey];
//}
//
//+(NSString*)assetsString:(NSArray*)assetsArray{
//    if (assetsArray == nil || assetsArray.count == 0) {
//        return @"";
//    }
//    
//    NSString *subjectString = [NSString stringWithFormat:@"%@ has shared a photo with you.", [SMUser activeUser].firstName];
////    NSString *subjectString = [NSString stringWithFormat:@"%@ has shared a photo with you.", @"Someone"];
//    NSMutableString *assetsString = [subjectString mutableCopy];
//    
//    if(assetsArray.count == 1){
//       VWWAsset *asset = assetsArray[0];
//        [assetsString appendFormat:@"\nView the photo: %@", asset.tempShareURL];
//    }
//    else{
//        for(NSInteger index = 0; index < assetsArray.count; index++){
//           VWWAsset *asset = assetsArray[index];
//            [assetsString appendFormat:@"\nView photo %d: %@", index+1, asset.tempShareURL];
//        }
//    }
//    return assetsString;
//}
//
//
//
//
////// Download image and return UIImage in completion block
////+(void)downloadAsset:(SMAsset*)asset completion:(SMUtilityImageBlock)completion{
////    if (!asset) completion(nil);
////    
////    dispatch_queue_t queue = dispatch_queue_create("download_asset_queue", nil);
////    dispatch_async(queue, ^{
////        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:asset.largeImageURL]];
////        // TODO add an error check here.
////        dispatch_sync(dispatch_get_main_queue(), ^{
////            completion(image);
////        });
////    });
////}
//
//
//// Download image and return UIImage in completion block
//+(void)downloadAsset:(SMAsset*)asset writeToDisk:(BOOL)writeToDisk completion:(SMUtilityImageBlock)completion{
//    if (!asset) completion(nil);
//    
//    dispatch_queue_t queue = dispatch_queue_create("download_asset_queue", nil);
//    dispatch_async(queue, ^{
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:asset.largeImageURL]];
//        if(writeToDisk == YES){
//            NSData *imgData = UIImageJPEGRepresentation(image, 1);
//            NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/temp.jpg"];
//            [imgData writeToFile:jpgPath atomically:YES];
//            UIImage *localImage = [UIImage imageWithContentsOfFile:jpgPath];
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                completion(localImage);
//            });
//        }
//        else{
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                completion(image);
//            });
//        }
//        
//    });
//}
//
////+(NSString*)stringFromLatitude:(float)latitude longitude:(float)longitude{
//+(NSString*)stringFromLocation:(float)location{
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//    [formatter setRoundingMode:NSNumberFormatterRoundHalfDown];
//    [formatter setMinimumFractionDigits:2];
//    [formatter setMaximumFractionDigits:2];
//    return [NSString stringWithFormat:@"%@", [formatter stringFromNumber:@(location)]];
//}
//
//
//
//+(NSString*)stringFromFileSizeInBytes:(NSInteger)size uploaded:(NSInteger)uploaded{
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//    [formatter setRoundingMode:NSNumberFormatterRoundHalfDown];
//    [formatter setMinimumFractionDigits:2];
//    [formatter setMaximumFractionDigits:2];
//    float fUploaded = 0;
//    float fSize = 0;
//    if(size > 1000000){
//        fUploaded = uploaded / 1000000.0;
//        fSize = size / 1000000.0;
//        return [NSString stringWithFormat:@"%@/%@ MB", [formatter stringFromNumber:@(fUploaded)], [formatter stringFromNumber:@(fSize)]];
//    }
//    else if(size > 1000){
//        fUploaded = uploaded / 1000.0;
//        fSize = size / 1000.0;
//        return [NSString stringWithFormat:@"%@/%@ kB", [formatter stringFromNumber:@(fUploaded)], [formatter stringFromNumber:@(fSize)]];
//    }
//    else{
//        return [NSString stringWithFormat:@"%@/%@ bytes", [formatter stringFromNumber:@(uploaded)], [formatter stringFromNumber:@(size)]];
//    }
//}
//
//+(NSString*)stringFromDistanceInMiles:(NSInteger)meters{
////    const float kFeetPerMile = 5280;
//    const float kMetersPerMile = 1609.34;
//    const float kFeetPerMeter = 3.28084;
//    if(meters > kMetersPerMile){
//        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//        [formatter setRoundingMode:NSNumberFormatterRoundHalfDown];
//        [formatter setMinimumFractionDigits:2];
//        [formatter setMaximumFractionDigits:2];
//        float miles = meters / kMetersPerMile;
//        return [NSString stringWithFormat:@"%@ miles", [formatter stringFromNumber:@(miles)]];
//    }
//    
//    return [NSString stringWithFormat:@"%d feet", (NSInteger)(meters * kFeetPerMeter)];
//}
//
//+(NSString*)stringFromDistanceInKilometers:(NSInteger)meters{
//
//    const float kMetersPerKilometer = 1000.0;
//    if(meters > kMetersPerKilometer){
//        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//        [formatter setRoundingMode:NSNumberFormatterRoundHalfDown];
//        [formatter setMinimumFractionDigits:2];
//        [formatter setMaximumFractionDigits:2];
//        float kilometers = meters / kMetersPerKilometer;
//        return [NSString stringWithFormat:@"%@ km", [formatter stringFromNumber:@(kilometers)]];
//    }
//    
//    return [NSString stringWithFormat:@"%d meters", (NSInteger)(meters)];
//}
//
//
//
//
//
//
//#pragma mark NSDate stuff
//+(NSString*)stringFromDate:(NSDate*)date{
//    if([date isToday]) return @"Today";
//    else if([date isTomorrow]) return @"Tomorrow";
//    else if([date isYesterday]) return @"Yesterday";
//    
////    NSString *dateFormatString = @"EEEE dd MMMM, YYYY";
//        NSString *dateFormatString = @"EEEE MMMM dd, YYYY";
//    
//    NSDateFormatter* dateUTC = [[NSDateFormatter alloc] init];
//    [dateUTC setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
//    [dateUTC setDateFormat:dateFormatString];
//    
//    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
//    [dateLocal setTimeZone:[NSTimeZone localTimeZone]];
//    [dateLocal setDateFormat:dateFormatString];
//    
//    NSString* dateString = [dateLocal stringFromDate:date];
//    if(dateString == nil) dateString = @"";
//    return dateString;
//}
//
//+(NSString*)timeElapsedStringFromDate:(NSDate*)date{
//    
//    
//    NSDate *now = [NSDate dateWithLocalTime];
//    
//    NSTimeInterval seconds = [now timeIntervalSinceDate:date];
//    NSTimeInterval minutes = seconds / 60.0f;
//    NSTimeInterval hours = minutes / 60.0f;
//    
//    if(minutes < 1.0 && hours < 1.0 && seconds > 0){
//        return @"just now";
//    }
//    else if(minutes < 60){
//        return [NSString stringWithFormat:@"%d minutes ago", (NSInteger)minutes];
//    }
//    else if(hours < 12){
//        return [NSString stringWithFormat:@"%d hours ago", (NSInteger)hours];
//    }
//    else if([date isToday]) return @"Today";
//    else if([date isTomorrow]) return @"Tomorrow";
//    else if([date isYesterday]) return @"Yesterday";
//    
//    NSString *dateFormatString = @"EEEE MMMM dd, YYYY";
//    
//    NSDateFormatter* dateUTC = [[NSDateFormatter alloc] init];
//    [dateUTC setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
//    [dateUTC setDateFormat:dateFormatString];
//    
//    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
//    [dateLocal setTimeZone:[NSTimeZone localTimeZone]];
//    [dateLocal setDateFormat:dateFormatString];
//    
//    NSString* dateString = [dateLocal stringFromDate:date];
//    if(dateString == nil) dateString = @"";
//    return dateString;
//}
//
//+(NSString*)relativeTimeFromDate:(NSDate*)date{
//    NSDate *now = [NSDate dateWithLocalTime];
//    
//    NSTimeInterval seconds = [now timeIntervalSinceDate:date];
//    NSTimeInterval minutes = seconds / 60.0f;
//    NSTimeInterval hours = minutes / 60.0f;
//    NSTimeInterval days = minutes / 24.0f;
//    
//    if(minutes < 1.0 && hours < 1.0 && seconds > 0){
//        return @"just now";
//    }
//    else if(minutes < 60){
//        return [NSString stringWithFormat:@"%d minutes ago", (NSInteger)minutes];
//    }
//    else if(hours < 24){
//        return [NSString stringWithFormat:@"%d hours ago", (NSInteger)hours];
//    }
//    else{
//        return [NSString stringWithFormat:@"%d days ago", (NSInteger)days];
//    }
//}
//
//+(NSString*)stringFromDateDayOnly:(NSDate*)date{
//    
//    NSString *dateFormatString = @"MMMMdd, YYYY";
//    
//    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
//    [dateLocal setTimeZone:[NSTimeZone localTimeZone]];
//    [dateLocal setDateFormat:dateFormatString];
//    
//    NSString* dateString = [dateLocal stringFromDate:date];
//    if(dateString == nil) dateString = @"";
//    return dateString;
//}
//
//+(NSString*)stringFromDateAndTime:(NSDate*)date{
////    if([date isToday]) return @"Today";
////    else if([date isTomorrow]) return @"Tomorrow";
////    else if([date isYesterday]) return @"Yesterday";
//    
//    NSString *dateFormatString = @"EEEE MMMM dd, YYYY @HH:mm";
//    NSString *hourFormatString = @"HH:mm";
//    
////    NSDateFormatter* dateUTC = [[NSDateFormatter alloc] init];
////    [dateUTC setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
////    [dateUTC setDateFormat:dateFormatString];
//    
//    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
//    [dateLocal setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
//    
//    
//    
//    if([date isToday]){
//        [dateLocal setDateFormat:hourFormatString];
//        return [NSString stringWithFormat:@"Today %@", [dateLocal stringFromDate:date]];
//    }
//    else if([date isTomorrow]){
//        [dateLocal setDateFormat:hourFormatString];
//        return [NSString stringWithFormat:@"Tomorrow %@", [dateLocal stringFromDate:date]];
//    }
//    else if([date isYesterday]) {
//        [dateLocal setDateFormat:hourFormatString];
//        return [NSString stringWithFormat:@"Yesterday %@", [dateLocal stringFromDate:date]];
//    }
//
//    
//    [dateLocal setDateFormat:dateFormatString];
//    
//    NSString* dateString = [dateLocal stringFromDate:date];
//    if(dateString == nil) dateString = @"";
//    return dateString;
//}
//
//
//
//+(NSDate*)dateFromMonth:(NSInteger)month day:(NSInteger)day year:(NSInteger)year{
//    return [SMUtility dateFromMonth:month
//                                day:day
//                               year:year
//                               hour:5
//                             minute:10
//                             second:0];
//}
//
//+(NSDate*)dateFromMonth:(NSInteger)month
//                    day:(NSInteger)day
//                   year:(NSInteger)year
//                   hour:(NSInteger)hour
//                 minute:(NSInteger)minute
//                 second:(NSInteger)second{
//    
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//    [dateComponents setMonth:month];
//    [dateComponents setDay:day];
//    [dateComponents setYear:year];
//    [dateComponents setHour:hour];
//    [dateComponents setMinute:minute];
//    [dateComponents setSecond:second];
//    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    return [gregorianCalendar dateFromComponents:dateComponents];
//}
//
//
//
//#pragma mark Email message delegate
//
//- (void)mailComposeController:(MFMailComposeViewController *)controller
//          didFinishWithResult:(MFMailComposeResult)result
//                        error:(NSError *)error
//{
//    if(error != nil){
//
//    }
//    [controller dismissViewControllerAnimated:YES completion:nil];
//}
//
//#pragma markVWWS message delegate
//
//- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
//                 didFinishWithResult:(MessageComposeResult)result {
//    
//    [controller dismissViewControllerAnimated:YES completion:nil];
//}
//
//+ (NSString*)buildAndVersion{
//    NSBundle* bundle = [NSBundle mainBundle];
//    NSString* appVersion = [bundle objectForInfoDictionaryKey:(NSString *)@"CFBundleShortVersionString"];
//    NSString* appBuildNumber = [bundle objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
//    return [NSString stringWithFormat:@"%@.%@", appVersion, appBuildNumber];
//}
//+ (NSString*)version{
//    NSBundle* bundle = [NSBundle mainBundle];
//    NSString* appVersion = [bundle objectForInfoDictionaryKey:(NSString *)@"CFBundleShortVersionString"];
//    return [NSString stringWithFormat:@"%@", appVersion];
//}
//+ (NSString*)build{
//    NSBundle* bundle = [NSBundle mainBundle];
//    NSString* appBuildNumber = [bundle objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
//    return [NSString stringWithFormat:@"%@", appBuildNumber];
//}
//
//
//
//+(UIImage*)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize{
//    //UIGraphicsBeginImageContext(newSize);
//    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
//    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}
//
//
//// This function requires ivar currentLocation to be set by CoreLocation ahead of time
//// Appends data to the dictionary that looks like this:
////"{GPS}" =     {
////    Altitude = "6.781530343007915";
////    Latitude = "37.964";
////    LatitudeRef = N;
////    Longitude = "122.5076666666667";
////    LongitudeRef = W;
////};
//
//+(NSDictionary*)appendGPSLocation:(CLLocation*)location toMetadata:(NSDictionary*)metadata{
//    NSString *latitudeRef;
//    NSString *longitudeRef;
//    NSNumber *latitude;
//    NSNumber *longitude;
//    if (location.coordinate.latitude < 0.0) {
//        latitude = [NSNumber numberWithFloat:-location.coordinate.latitude];
//        latitudeRef = @"S";
//    }
//    else {
//        latitude = [NSNumber numberWithFloat:location.coordinate.latitude];
//        latitudeRef = @"N";
//    }
//    
//    if (location.coordinate.longitude < 0.0) {
//        longitude = [NSNumber numberWithFloat:-location.coordinate.longitude];
//        longitudeRef = @"W";
//    }
//    else {
//        longitude = [NSNumber numberWithFloat:location.coordinate.longitude];
//        longitudeRef = @"E";
//    }
//    
//    NSDictionary *gps = @{(NSString*)kCGImagePropertyGPSLatitude : latitude,
//                          (NSString*)kCGImagePropertyGPSLatitudeRef : latitudeRef,
//                          (NSString*)kCGImagePropertyGPSLongitude : longitude,
//                          (NSString*)kCGImagePropertyGPSLongitudeRef : longitudeRef,
//                          (NSString*)kCGImagePropertyGPSAltitude : @(location.altitude)};
//    
//    NSMutableDictionary *md = [metadata mutableCopy];
//    [md setObject:gps forKey:(NSString*)kCGImagePropertyGPSDictionary];
//    return md;
//}
//
////+(NSDate*)offsetDateFromGMT:(NSDate*)date{
//////    NSDate *localDate = [NSDate date];
////    NSTimeInterval timeZoneOffset = [[NSTimeZone defaultTimeZone] secondsFromGMT]; // You could also use the systemTimeZone method
////    NSTimeInterval gmtTimeInterval = [date timeIntervalSinceReferenceDate] - timeZoneOffset;
////    NSDate *gmtDate = [NSDate dateWithTimeIntervalSinceReferenceDate:gmtTimeInterval];
////    return gmtDate;
////}
//
//
//+(void)locationFromAsset:(SMAsset*)asset withCompletion:(SMUtilityStringBlock)completion{
//    if(asset.location){
//        float latitude = 0, longitude = 0;
//        if([asset latitude:&latitude longitude:&longitude]){
//            if(latitude != 0 && longitude != 0){
//                CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
//                CLGeocoder *geocoder = [[CLGeocoder alloc]init];
//                [geocoder reverseGeocodeLocation:location
//                               completionHandler:^(NSArray *placemarks, NSError *error) {
//                                   NSString *locationString = @"";
//                                   if(placemarks.count > 0){
//                                       CLPlacemark *placemark = placemarks[0];
//                                       
//                                       if(placemark.areasOfInterest && placemark.locality && placemark.areasOfInterest.count > 0){
//                                           locationString = [NSString stringWithFormat:@"%@, %@", placemark.areasOfInterest[0], placemark.locality];
//                                       }
//                                       else if(placemark.locality && placemark.subLocality){
//                                           locationString = [NSString stringWithFormat:@"%@, %@", placemark.locality, placemark.subLocality];
//                                       }
//                                       else if(placemark.locality){
//                                           locationString = [NSString stringWithFormat:@"%@", placemark.locality];
//                                       }
//                                   }
//                                   completion(locationString);
//                               }];
//            }
//        }
//    }
//    
//    
//    completion(@"");
//}
//



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
