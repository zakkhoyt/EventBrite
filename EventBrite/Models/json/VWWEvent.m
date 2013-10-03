//
// VWWEvent.m
//  Heartstream
//
//  Created by Zakk Hoyt on 7/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEvent.h"
#import "VWWUser.h"

@interfaceVWWEvent () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong)VWWEventDistanceCompletion distanceCompletion;
@end

@implementationVWWEvent


#pragma mark Private methods


- (id)initWithDictionary:(NSDictionary *)dictionary{
    if (dictionary == nil) {
        return nil;
    }
    
    self = [super init];
    if(self){
        _startAt = [dictionary dateForKey:@"start_at"];
        _endAt = [dictionary dateForKey:@"end_at"];
        _uuid = [dictionary stringForKey:@"uuid"];
        _ownerUUID = [dictionary stringForKey:@"owner_uuid"];
        _title = [dictionary stringForKey:@"title"];
        _latitude = [dictionary floatForKey:@"latitude"];
        _longitude = [dictionary floatForKey:@"longitude"];
        _distance = [dictionary floatForKey:@"distance"];
        _isActive = [dictionary boolForKey:@"is_active"];
        _isSubscribed = [dictionary boolForKey:@"is_subscribed"];
        _numberOfAssets = [dictionary intForKey:@"number_of_assets"];
        _numberOfUsers = [dictionary intForKey:@"number_of_users"];
    }
    return self;
}

#pragma mark Public methods
+(id)eventWithDictionary:(NSDictionary *)dictionary{
    return [[SMEvent alloc]initWithDictionary:dictionary];
}



-(NSString*)description{
    return [NSString stringWithFormat:@"uuid: %@\n"
            @"ownerUUID: %@\n"
            @"title: %@\n"
            @"latitude: %f\n"
            @"longitue: %f\n"
            @"distance: %f\n"
            @"startAt: %@\n"
            @"endAt: %@\n"
            @"isActive: %@\n"
            @"isSubscribed: %@",
            _uuid,
            _ownerUUID,
            _title,
            _latitude,
            _longitude,
            _distance,
            _startAt,
            _endAt,
            _isActive ? @"YES" : @"NO",
            _isSubscribed ? @"YES" : @"NO"];
}

@end

//#pragma markVWWEvent (Utilities)
@implementationVWWEvent (Utilities)
-(void)startLocationMonitor{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
}
-(void)stopLocationMonitor{
    [self.locationManager stopUpdatingLocation];
    _locationManager = nil;
}


#pragma   mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
//    self.currentLocation = newLocation;
    CLLocation *eventLocation = [[CLLocation alloc]initWithLatitude:self.latitude
                                                          longitude:self.longitude];
    CLLocationDistance meters = [eventLocation distanceFromLocation:newLocation];
    const float feetPerMeter = 3.28;
    [self stopLocationMonitor];
    self.distanceCompletion(meters * feetPerMeter);
}




-(NSInteger)distanceFromLocationInFeet:(CLLocation*)location{
    CLLocation *eventLocation = [[CLLocation alloc]initWithLatitude:self.latitude
                                                          longitude:self.longitude];
    CLLocationDistance meters = [eventLocation distanceFromLocation:location];
    const float feetPerMeter = 3.28;
    return meters * feetPerMeter;
}


-(void)distanceFromEventWithCompletion:(SMEventDistanceCompletion)completion{
    self.distanceCompletion = completion;
    [self startLocationMonitor];
}
-(BOOL)belongsToActiveUser{
    return [self.ownerUUID isEqualToString:[SMUser activeUser].uuid];
}

@end
