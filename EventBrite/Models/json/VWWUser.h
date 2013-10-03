//
// VWWUser.h
//  SmileModel
//
//  Created by Aleksandar Tosovic on 4/23/12.
//  Copyright (c) 2012 Webshots. All rights reserved.
//


@interfaceVWWUser :VWWModel

//@property (copy, nonatomic) NSString *uuid;
//@property (copy, nonatomic) NSString *firstName;
//@property (copy, nonatomic) NSString *lastName;
//@property (copy, nonatomic) NSString *email;
//@property (copy, nonatomic) NSString *avatarUUID;
//@property (strong, nonatomic) NSDate *createdDate;
//@property (strong, nonatomic) NSDate *updatedDate;
//@property (strong, nonatomic) NSString *password;
//@property (nonatomic, strong) UIImage *avatarImage;
//@property (nonatomic, strong) UIImage *defaultAvatarImage;
//
//
//+ (void)setActiveUser:(SMUser *)user;
//+ (SMUser *)activeUser;
//
//+ (id)userWithDictionary:(NSDictionary *)dictionary;
//- (id)initWithDictionary:(NSDictionary *)dictionary;
//- (bool)isActiveUser; 
//
//-(NSString*)description;
//-(SMAsset*)avatarAsset;

@end

@interfaceVWWUser (Utilities)

//-(BOOL)isUser:(SMUser*)user;
//-(BOOL)isEmployee;
//-(void)updateAvatarUUID:(NSString*)uuid
//        completionBlock:(SMUserEmptyBlock)completionBlock
//             errorBlock:(SMUserErrorBlock)errorBlock;
//
//
//-(void)deleteFromServerWithCompletion:(SMUserEmptyBlock)completionBlock errorBlock:(SMUserErrorBlock)errorBlock;
//
//-(void)updateUserWithCompletionBlock:(SMUserUserBlock)completionBlock
//                          errorBlock:(SMUserEmptyBlock)errorBlock;
//
//
//// Zakk Hoyt
//-(NSString*)fullName;
//// Zakk H.
//-(NSString*)abbreviatedName;
@end
