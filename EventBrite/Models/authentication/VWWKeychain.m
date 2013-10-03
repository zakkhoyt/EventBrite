//
//  VWWKeychain.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWKeychain.h"


@interface VWWKeychain ()
@property (nonatomic, strong) NSMutableDictionary *IDToKeychainItem;
@end

@implementation VWWKeychain
+ (VWWKeychain *)sharedKeychain {
    static VWWKeychain *sharedKeychain;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedKeychain = [self new]; });
    return sharedKeychain;
}

- (id)init {
    self = [super init];
    if (self) {
        _IDToKeychainItem = [NSMutableDictionary new];
    }
    return self;
}


- (VWWCredential *)credentialForItemWithID:(NSString *)keychainItemID {
    if ([keychainItemID length] == 0) return nil;

    VWWCredential *credential = [VWWCredential credential];

    KeychainItemWrapper *keychainItem = [self itemForID:keychainItemID];
    credential.username = [keychainItem objectForKey:(__bridge id)kSecAttrAccount];
    credential.password = [keychainItem objectForKey:(__bridge id)kSecValueData];

    if (credential.username && credential.password) {
        return credential;
    }
    return nil;
}

- (void)setCredential:(VWWCredential *)credential forItemWithID:(NSString *)keychainItemID {
    if (!credential.username || [keychainItemID length] == 0) return;

    KeychainItemWrapper *keychainItem = [self itemForID:keychainItemID];
    [keychainItem setObject:keychainItemID forKey:(__bridge id)kSecAttrService];
    [keychainItem setObject:credential.username forKey:(__bridge id)kSecAttrAccount];
    [keychainItem setObject:credential.password forKey:(__bridge id)kSecValueData];
}

- (void)resetKeychainItemWithID:(NSString *)keychainItemID {
    [[self itemForID:keychainItemID] resetKeychainItem];
}

- (KeychainItemWrapper *)itemForID:(NSString *)keychainItemID {
    KeychainItemWrapper *item = self.IDToKeychainItem[keychainItemID];
    if (!item) {
        item = [[KeychainItemWrapper alloc] initWithIdentifier:keychainItemID accessGroup:nil];
        self.IDToKeychainItem[keychainItemID] = item;
    }
    return item;
}

@end
