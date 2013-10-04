//
//  VWWUserDefaults.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//

#import "VWWUserDefaults.h"
__attribute ((unused)) static NSString* kVWWUserDefaultDebugModeKey = @"debug_mode";
__attribute ((unused)) static NSString* kVWWUserDefaultServerKey = @"server";
__attribute ((unused)) static NSString* kVWWUserDefaultServerSecureKey = @"server_secure";

@implementation VWWUserDefaults


#pragma mark Private methods


#pragma mark Public methods
+(BOOL)debugMode{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVWWUserDefaultDebugModeKey];
}

+(NSString*)server{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kVWWUserDefaultServerKey];
}
+(void)setServer:(NSString*)server{
    [[NSUserDefaults standardUserDefaults] setObject:server forKey:kVWWUserDefaultServerKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)serverSecure{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVWWUserDefaultServerSecureKey];
}
+(void)setServerSecure:(BOOL)secure{
    [[NSUserDefaults standardUserDefaults] setBool:secure forKey:kVWWUserDefaultServerSecureKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}






@end
