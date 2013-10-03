//
// VWWEvent.h
//  Heartstream
//
//  Created by Zakk Hoyt on 7/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "SMModel.h"
#import <CoreLocation/CoreLocation.h>

typedef void (^SMEventDistanceCompletion)(CLLocationDistance distance);


@interfaceVWWEvent :VWWModel
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

@interfaceVWWEvent (Utilities)
-(NSInteger)distanceFromLocationInFeet:(CLLocation*)location;
-(void)distanceFromEventWithCompletion:(SMEventDistanceCompletion)completion;
-(BOOL)belongsToActiveUser;
@end
