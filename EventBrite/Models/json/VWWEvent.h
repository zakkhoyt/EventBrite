//
// VWWEvent.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWModel.h"
#import <CoreLocation/CoreLocation.h>

typedef void (^SMEventDistanceCompletion)(CLLocationDistance distance);


@interface VWWEvent : VWWModel
@property (copy, nonatomic) NSString *uuid;
@property (copy, nonatomic) NSString *ownerUUID;
@property (copy, nonatomic) NSDate *startAt;
@property (copy, nonatomic) NSDate *endAt;
@property (copy, nonatomic) NSString *title;
@property (nonatomic) NSInteger numberOfAssets;
@property (nonatomic) NSInteger numberOfUsers;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property (nonatomic) float distance;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL isSubscribed;

+(id)eventWithDictionary:(NSDictionary *)dictionary;
-(id)initWithDictionary:(NSDictionary *)dictionary;
@end

@interface VWWEvent (Utilities)
//-(NSInteger)distanceFromLocationInFeet:(CLLocation*)location;
//-(void)distanceFromEventWithCompletion:(SMEventDistanceCompletion)completion;
//-(BOOL)belongsToActiveUser;
@end
