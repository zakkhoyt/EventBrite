 //
// VWWUser.m
//  SmileModel
//
//  Created by Aleksandar Tosovic on 4/23/12.
//  Copyright (c) 2012 Webshots. All rights reserved.
//

#import "VWWUser.h"
#import "NSDictionary+TypedGetters.h"
//#import "SMSource.h"
////#import "SMUtility.h"
//#import "SDWebImagePrefetcher.h"
//#import "SmileRESTEngine.h"
//#import "SMPageForm.h"
//#import <objc/runtime.h>
//#import "SMAsset.h"
//#import "SDWebImageManager.h"





@interface VWWUser ()
//@property (strong, nonatomic) NSArray *sources;
//@property (nonatomic, strong)VWWAsset *avatarAsset;
//@property (nonatomic, strong) SDWebImagePrefetcher *imagePrefetcher;
////@property (copy, nonatomic) NSString *avatarUUID;
@end

@implementation VWWUser

//staticVWWUser *activeUser = nil;
//
//+ (NSMutableDictionary *)userStore {
//    static NSMutableDictionary *userStore;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        userStore = [@{}mutableCopy];
//    });
//    return userStore;
//}
//
//
//+ (void)setActiveUser:(SMUser *)user {
//    activeUser = user;
//    if(activeUser == nil) return;
//    
//    __block BOOL complete = NO;
//    [SMSource ensureSourceForHardware:^(NSError *error) {
//        complete = YES;
//    }];
//    
//    // We need to wait until we are sure we have created aVWWSource for this device.
//    // Using completion block was hanging becuase of too many calls within MKNewtworkKit, so
//    // we'll just wait here. 
//    while (!complete) {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    }
//    
//    [SMUserDefaults clearNotificationsCount];
//    
//    DDLogInfo(@"Set active user to %@ %@ %@", user.firstName, user.lastName, user.email);
//    
//}
//
//+ (SMUser *)activeUser {
//    return activeUser;
//}
//
//+ (id)userWithDictionary:(NSDictionary *)dictionary {
//    return [[SMUser alloc] initWithDictionary:dictionary];
//}
//
//- (id)initWithDictionary:(NSDictionary *)dictionary {
//    if (dictionary == nil) return nil;
//    
//    self.defaultAvatarImage = [UIImage imageNamed:@"flip_avatar_default~iphone.png"];
//    // User always has uuid
//    NSString *uuid = [dictionary stringForKey:@"uuid"];
//    if(!uuid) return nil;
//    // If user does not exist in asset store add it else update exsisting one
//   VWWUser *storedUser = [SMUser userStore][uuid];
//    if (storedUser) {
//        self = storedUser;
//        return self;
//    }
//    
//    self = [super init];
//    if (self) {
//        // Add to user store
//        [SMUser userStore][uuid] = self;
//        
//        self.uuid = uuid;
//        self.firstName = [dictionary stringForKey:@"first_name"];
//        self.lastName = [dictionary stringForKey:@"last_name"];
//        self.email = [dictionary stringForKey:@"email"];
//        self.createdDate = [dictionary dateForKey:@"created_at"];
//        self.updatedDate = [dictionary dateForKey:@"updated_at"];
//        self.avatarUUID = [dictionary stringForKey:@"avatar_uuid"];
//        
//        // set default image then do a prefetch
//        self.avatarImage = self.defaultAvatarImage;
//        self.imagePrefetcher = [[SDWebImagePrefetcher alloc]init];
//        if(self.avatarUUID){
//            [self prefetchAvatar];
//        }
//        
//    }
//    
//    return self;
//}
//
//-(void)prefetchAvatar{
//    if(self.avatarUUID == nil) return;
//    
//    // Convert asset to URL
////    NSLog(@"Fetching avatar for user: %@ %@ %@", self.uuid, self.firstName, self.lastName);
//    [[SmileRESTEngine sharedInstance] getAssetOnlyWithUUID:self.avatarUUID
//                                       completionBlock:^(SMAsset *asset) {
//                                           if(asset){
//                                               __weakVWWUser *weakSelf = self;
//                                               [[SDWebImageManager sharedManager] downloadWithURL:asset.thumbImageURL
//                                                                                          options:SDWebImageRetryFailed
//                                                                                         progress:^(NSUInteger receivedSize, long long expectedSize) {
//                                                                                         } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
//                                                                                             if(image && finished){
//                                                                                                 weakSelf.avatarImage = image;
//                                                                                             }
//                                                                                         }];
//                                           }
//                                           else{
//                                               NSLog(@"****** error: asset == nil");
//                                           }
//                                       } errorBlock:^(NSError *error, NSString *additionalInfo) {
//                                       }];
//}
//
//
//- (NSString *)description {
//    return [NSString stringWithFormat:@"uuid: %@\n"
//            @"firstName: %@\n"
//            @"lastName: %@\n"
//            @"email: %@\n",
//            _uuid,
//            _firstName,
//            _lastName,
//            _email];
//}
//
//
//+ (void)parseFriends:(NSData *)data index:(NSString *)index completion:(void (^)(NSArray *,VWWPagination *, NSError *))completion {
//    NSError *error;
//    NSDictionary *JSONObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//    if (!JSONObject){
//        completion(nil, nil, error);
//        return;
//    }
//
//   VWWPagination *pagination = [SMPagination paginationWithDictionary:JSONObject];
//
//    NSMutableArray *friends = [NSMutableArray array];
//    for (NSDictionary *dictionary in JSONObject[index]) {
//       VWWUser *user = [SMUser userWithDictionary:dictionary];
//        if (user) {
//            [friends addObject:user];
//        }
//    }
//
//    completion(friends, pagination, nil);
//}
//- (bool)isActiveUser{
//   VWWUser* currentUser = [SMUser activeUser];
//    if([self.uuid isEqual:currentUser.uuid]){
//        return YES;
//    }
//    return NO;
//}
//
//
//-(SMAsset*)avatarAsset{
//    return _avatarAsset;
//}
//
//-(void)setAvatarUUID:(NSString *)avatarUUID{
//    _avatarUUID = avatarUUID;
//    
//    [self prefetchAvatar];
//}
//
//@end
//
//@implementationVWWUser (Utilities)
//
//
//
//
//-(BOOL)isUser:(SMUser*)user{
//    return [user.uuid isEqualToString:self.uuid];
//}
//
//-(BOOL)isEmployee{
//    if ([self.email rangeOfString:@"webshots.com"].location != NSNotFound ||
//        [self.email rangeOfString:@"threefoldphotos.com"].location != NSNotFound) {
//        return YES;
//    }
//    return NO;
//}
//-(void)updateAvatarUUID:(NSString*)uuid
//        completionBlock:(SMUserEmptyBlock)completionBlock
//             errorBlock:(SMUserErrorBlock)errorBlock{
//    
//   VWWUpdateUserForm *form = [[SMUpdateUserForm alloc]init];
//    form.avatarUUID = uuid;
//    [[SmileRESTEngine sharedInstance] updateUser:[SMUser activeUser].uuid
//                                        withForm:form
//                                 completionBlock:^(SMUser *user) {
//                                     if(user){
//                                         completionBlock();
//                                     }
//                                     errorBlock(nil);
//                                 }
//                                      errorBlock:^(NSError *error, NSString *additionalInfo) {
//                                          DDLogWarn(@"Warning: could not set avatar. error : %@", error);
//                                          errorBlock(error);
//                                      }];
//    
//}
//
//-(void)deleteFromServerWithCompletion:(SMUserEmptyBlock)completionBlock
//                           errorBlock:(SMUserErrorBlock)errorBlock{
//    [[SmileRESTEngine sharedInstance] deleteBuddyWithUUID:self.uuid
//                                          completionBlock:^{
//                                              [SMMixPanel eventRemoveBuddy];
//                                              [SMMixPanel peopleNumberOfBuddies:-1];
//                                              completionBlock();
//                                          } errorBlock:^(NSError *error, NSString *additionalInfo) {
//                                              DDLogError(@"ERROR: Could not delete buddy from Smile. Buddy UUID: %@", self.uuid);
//                                              errorBlock(error);
//                                          }];
//}
//
//-(void)updateUserWithCompletionBlock:(SMUserUserBlock)completionBlock
//                          errorBlock:(SMUserEmptyBlock)errorBlock{
//}
//// Zakk Hoyt
//-(NSString*)fullName{
//    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
//}
//
//// Zakk H.
//-(NSString*)abbreviatedName{
//    if(self.firstName && [self.firstName isEqualToString:@""] == NO &&
//            self.lastName && [self.lastName isEqualToString:@""] == NO){
//        NSString *lastInitial = [self.lastName substringToIndex:1];
//        return [NSString stringWithFormat:@"%@ %@.", self.firstName, lastInitial];
//    }
//    else if(self.firstName && [self.firstName isEqualToString:@""] == NO){
//        return self.firstName;
//    }
//    else if(self.lastName && [self.lastName isEqualToString:@""] == NO){
//        return self.lastName;
//    }
//    else if(self.email && [self.email isEqualToString:@""] == NO){
//        return self.email;
//    }
//
//    return self.uuid;
//}

@end
