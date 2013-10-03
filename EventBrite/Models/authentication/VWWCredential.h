//
//  VWWCredential.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import <Foundation/Foundation.h>


@interface VWWCredential : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *secret;
@property (nonatomic, copy) NSDate *expires;

+ (id)credential;
+ (id)credentialWithUsername:(NSString *)username password:(NSString *)password;
+ (id)credentialWithUsername:(NSString *)username
                       token:(NSString *)token
                      secret:(NSString *)secret
                  expiration:(NSDate *)expires;
@end