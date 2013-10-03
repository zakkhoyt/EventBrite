//
//  VWWKeychain.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"
#import "VWWCredential.h"

@interface VWWKeychain : NSObject
+ (VWWKeychain *)sharedKeychain;
- (VWWCredential *)credentialForItemWithID:(NSString *)keychainItemID;
- (void)setCredential:(VWWCredential *)credential forItemWithID:(NSString *)keychainItemID;
- (void)resetKeychainItemWithID:(NSString *)keychainItemID;
@end
