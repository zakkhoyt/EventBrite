//
//  VWWCredential.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWCredential.h"

@implementation VWWCredential
+ (id)credential {
    return [VWWCredential new];
}

+ (id)credentialWithUsername:(NSString *)username password:(NSString *)password {
    if ([username length] == 0 && [password length] == 0) return nil;
    
    VWWCredential *credential = [self credential];
    credential.username = username;
    credential.password = password;
    return credential;
}

+ (id)credentialWithUsername:(NSString *)username
                       token:(NSString *)token
                      secret:(NSString *)secret
                  expiration:(NSDate *)expires
{
    if ([username length] == 0 && ([token length] == 0 || [secret length] == 0)) {
        return nil;
    }
    
    VWWCredential *credential = [self credential];
    credential.username = username;
    credential.token = token;
    credential.secret = secret;
    credential.expires = expires;
    return credential;
}

@end