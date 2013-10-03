//
//  VWWEngine.h
//  JSON
//
//  Created by Zakk Hoyt on 2/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//
//  //entatively it will be /api/v2/assets/multiaction and it will take a PUT.
//  Documentation for VWW: https://sites.google.com/a/threefoldphotos.com/VWW/home/reference/api-v3


#import "MKNetworkEngine.h"
#import "VWWRESTConfig.h"

// Model includes
#import "SMHTTPForm.h"
#import "SMUser.h"
#import "SMSource.h"
#import "SMAsset.h"
#import "SMNote.h"
#import "SMUtility.h"
#import "SMInvite.h"
#import "SMEvent.h"

// Form includes
#import "SMCreateAssetForm.h"
#import "SMCreateDeviceForm.h"
#import "SMCreateEventForm.h"
#import "SMCreateInviteForm.h"
#import "SMCreateNoteForm.h"
#import "SMCreateSourceForm.h"
#import "SMGetAssetsForm.h"
#import "SMGetEventAssetsForm.h"
#import "SMGetEventsForm.h"
#import "SMGetFavoriteAssetsForm.h"
#import "SMGetHeartedAssetsForm.h"
#import "SMNestAssetForm.h"
#import "SMPageForm.h"
#import "SMVWWLogInForm.h"
#import "SMVWWSignUpForm.h"
#import "SMUpdateAssetForm.h"
#import "SMUpdateFavoriteForm.h"
#import "SMUpdateNoteForm.h"
#import "SMUpdateSourceForm.h"
#import "SMUpdateUserForm.h"


typedef void (^VWWRESTEngineAssetBlock)(SMAsset *asset);
typedef void (^VWWRESTEngineAssetDetailsBlock)(SMAsset *asset, NSArray *heartedUsers);
typedef void (^VWWRESTEngineAssetsBlock)(NSArray *assets);
typedef void (^VWWRESTEngineAssetsPageBlock)(NSArray *assets,VWWPagination* page);
typedef void (^VWWRESTEngineBuddiesBlock)(NSArray *buddies);
typedef void (^VWWRESTEngineDevicesBlock)(NSArray *devices);
typedef void (^VWWRESTEngineErrorBlock)(NSError *error, NSString *additionalInfo);
typedef void (^VWWRESTEngineEmptyBlock)(void);
typedef void (^VWWRESTEngineEventBlock)(SMEvent *event);
typedef void (^VWWRESTEngineEventsBlock)(NSArray *events);
typedef void (^VWWRESTEngineFeedbackBlock)(NSArray *feedback);
typedef void (^VWWRESTEngineFriendsBlock)(NSArray *friends);
typedef void (^VWWRESTEngineInviteBlock)(SMInvite *invite);
typedef void (^VWWRESTEngineInviteValidBlock)(BOOL valid);
typedef void (^VWWRESTEngineInvitesBlock)(NSArray *invites);
typedef void (^VWWRESTEngineNoteBlock)(SMNote *note);
typedef void (^VWWRESTEngineNotesBlock)(NSArray *notes,VWWPagination *page);
typedef void (^VWWRESTEngineSourceBlock)(SMSource *source);
typedef void (^VWWRESTEngineSourcesBlock)(NSArray *sources);
typedef void (^VWWRESTEngineTokenUserBlock)(NSString *token,VWWUser *user);
typedef void (^VWWRESTEngineUserBlock)(SMUser *user);
typedef void (^VWWRESTEngineUsersBlock)(NSArray *users);

@interface VWWRESTEngine : MKNetworkEngine

+(VWWRESTEngine*)sharedInstance;
+(void)releaseSingleton;

@property (nonatomic, strong) VWWRESTConfig* service;
@property (nonatomic, readonly) BOOL useHTTPS;


#pragma mark S3 uploader
//-(MKNetworkOperation*) httpSendFileToS3:(NSString*)path
//                       uploadParameters:(NSDictionary*)uploadParameters
//                                   file:(NSString*)file
//                        completionBlock:(SEBoolBlock)completionBlock
//                             errorBlock:(SEErrorBlock)errorBlock;


#pragma mark Logging in (Tokens)
-(MKNetworkOperation*)createTokenWithForm:(SMVWWLogInForm*)form
                              completionBlock:(VWWRESTEngineTokenUserBlock)completionBlock
                                   errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

#pragma mark Password
//-(MKNetworkOperation*)updatePasswordWithUUID:(NSString*)UUID
//                                        form:(SMHTTPForm*)form
//                             completionBlock:(SEEmptyBlock)completionBlock
//                                  errorBlock:(SEErrorBlock)errorBlock;

#pragma mark Users

-(MKNetworkOperation*)createUserWithForm:(SMVWWSignUpForm*)form
                         completionBlock:(VWWRESTEngineTokenUserBlock)completionBlock
                              errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)getUserProfileWithUUID:(NSString*)userUUID
                             completionBlock:(VWWRESTEngineUserBlock)completionBlock
                                  errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)updateUser:(NSString*)UUID
                        withForm:(SMUpdateUserForm*)form
                 completionBlock:(VWWRESTEngineUserBlock)completionBlock
                      errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

#pragma mark Users (followers)

#pragma mark Users (buddies)
-(MKNetworkOperation*)getBuddiesWithForm:(SMPageForm*)form
                         completionBlock:(VWWRESTEngineBuddiesBlock)completionBlock
                              errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)getBuddiesAndFriendsWithForm:(SMPageForm*)form
                                   completionBlock:(VWWRESTEngineBuddiesBlock)completionBlock
                                        errorBlock:(VWWRESTEngineErrorBlock)errorBlock;


-(MKNetworkOperation*)deleteBuddyWithUUID:(NSString*)uuid
                          completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

#pragma mark Events
-(MKNetworkOperation*)createEventWithForm:(SMCreateEventForm*)form
                           completionBlock:(VWWRESTEngineEventBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)getEventsWithForm:(SMGetEventsForm*)form
                        completionBlock:(VWWRESTEngineEventsBlock)completionBlock
                             errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)getAssetsOfEvent:(NSString*)uuid
                              withForm:(SMPageForm*)form
                       completionBlock:(VWWRESTEngineAssetsBlock)completionBlock
                            errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)getUsersOfEvent:(NSString*)uuid
                              withForm:(SMPageForm*)form
                       completionBlock:(VWWRESTEngineUsersBlock)completionBlock
                            errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)subscribeToEvent:(NSString*)uuid
                      completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                           errorBlock:(VWWRESTEngineErrorBlock)errorBlock;


-(MKNetworkOperation*)deleteEventWithUUID:(NSString*)uuid
                          completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock;



#pragma mark Sources

-(MKNetworkOperation*)getSourcesWithForm:(SMPageForm*)form
                         completionBlock:(VWWRESTEngineSourcesBlock)completionBlock
                              errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)createSourceWithForm:(SMCreateSourceForm*)form
                           completionBlock:(VWWRESTEngineSourceBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)updateSourceWithUUID:(NSString*)UUID
                                  withForm:(SMHTTPForm*)form
                           completionBlock:(VWWRESTEngineSourceBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

#pragma mark Devices

-(MKNetworkOperation*)getDevicesOfUserWithID:(NSString*)UUID
                                    withForm:(SMPageForm*)form
                             completionBlock:(VWWRESTEngineDevicesBlock)completionBlock
                                  errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)createDeviceWithForm:(SMCreateDeviceForm*)form
                           completionBlock:(VWWRESTEngineSourceBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock;


#pragma mark Assets



-(MKNetworkOperation*)createAssetWithForm:(SMCreateAssetForm*)form
                          completionBlock:(VWWRESTEngineAssetBlock)completionBlock
                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock;



-(MKNetworkOperation*)updateAssetWithUUID:(NSString*)UUID
                                 withForm:(SMHTTPForm*)form
                          completionBlock:(VWWRESTEngineAssetBlock)completionBlock
                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock;


-(MKNetworkOperation*)getAssetWithUUID:(NSString*)uuid
                              completionBlock:(VWWRESTEngineAssetDetailsBlock)completionBlock
                                   errorBlock:(VWWRESTEngineErrorBlock)errorBlock;




-(MKNetworkOperation*)getAssetOnlyWithUUID:(NSString*)uuid
                           completionBlock:(VWWRESTEngineAssetBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock;


-(MKNetworkOperation*)deleteAssetWithUUID:(NSString*)uuid
                          completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

#pragma mark Assets (notes)
// GET
// /api/v3/assets/40c3deecd92dfcd86d94ff19126dd5ae24e58979b0c87e8952d7a4e5b154cee5/notes
-(MKNetworkOperation*)getAssetNotesWithUUID:(NSString*)uuid
                            completionBlock:(VWWRESTEngineNotesBlock)completionBlock
                                 errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

// POST
// api/v3/assets/40c3deecd92dfcd86d94ff19126dd5ae24e58979b0c87e8952d7a4e5b154cee5/notes
-(MKNetworkOperation*)createNoteForAssetUUID:(NSString*)uuid
                                         form:(SMCreateNoteForm*)form
                              completionBlock:(VWWRESTEngineNoteBlock)completionBlock
                                   errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

// PUT
// /api/v3/assets/40c3deecd92dfcd86d94ff19126dd5ae24e58979b0c87e8952d7a4e5b154cee5/notes/b81664c0fec20130df49406c8f2b585a
-(MKNetworkOperation*)updateNoteForAssetUUID:(NSString*)assetUUID
                                    noteUUID:(NSString*)noteUUID
                                        form:(SMUpdateNoteForm*)form
                            completionBlock:(VWWRESTEngineNoteBlock)completionBlock
                                 errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

// DELETE
// /api/v3/assets/40c3deecd92dfcd86d94ff19126dd5ae24e58979b0c87e8952d7a4e5b154cee5/notes/b81664c0fec20130df49406c8f2b585a
-(MKNetworkOperation*)deleteNoteForAssetUUID:(NSString*)assetUUID
                                     noteUUID:(NSString*)noteUUID
                            completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                                 errorBlock:(VWWRESTEngineErrorBlock)errorBlock;





//#pragma mark Assets (events)
//-(MKNetworkOperation*)getEventAssetsWithForm:(SMGetEventAssetsForm*)form
//                             completionBlock:(VWWRESTEngineAssetsBlock)completionBlock
//                                  errorBlock:(VWWRESTEngineErrorBlock)errorBlock;
//



#pragma mark Assets (favorites)


///api/v3/assets/hearted?date=2013-06-01T22:26:35Z
-(MKNetworkOperation*)getHeartedAssetsWithForm:(SMGetHeartedAssetsForm*)form
                                completionBlock:(VWWRESTEngineAssetsPageBlock)completionBlock
                                     errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)getFavoriteAssetsWithForm:(SMGetFavoriteAssetsForm*)form
                                completionBlock:(VWWRESTEngineAssetsPageBlock)completionBlock
                                     errorBlock:(VWWRESTEngineErrorBlock)errorBlock;


-(MKNetworkOperation*)getAssetsWithForm:(SMGetAssetsForm*)form
                        completionBlock:(VWWRESTEngineAssetsPageBlock)completionBlock
                             errorBlock:(VWWRESTEngineErrorBlock)errorBlock;


-(MKNetworkOperation*)favoriteAssetWithForm:(SMUpdateFavoriteForm*)form
                            completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                                 errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)unfavoriteAssetWithUUID:(NSString*)uuid
                              completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                                   errorBlock:(VWWRESTEngineErrorBlock)errorBlock;



#pragma mark Notifications

//-(MKNetworkOperation*)sendNotificationToUserWithID:(NSString*)UUID
//                                          withForm:(SMHTTPForm*)form
//                                   completionBlock:(SEEmptyBlock)completionBlock
//                                        errorBlock:(SEErrorBlock)errorBlock;
//


#pragma mark Invitations
-(MKNetworkOperation*)createInviteWithForm:(SMCreateInviteForm*)form
                           completionBlock:(VWWRESTEngineInviteBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)getInvitesWithForm:(SMPageForm*)form
                       completionBlock:(VWWRESTEngineInvitesBlock)completionBlock
                            errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)deleteInviteWithUUID:(NSString*)uuid
                           completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock;

-(MKNetworkOperation*)getInvitesReceivedWithForm:(SMPageForm*)form
                                 completionBlock:(VWWRESTEngineInvitesBlock)completionBlock
                                      errorBlock:(VWWRESTEngineErrorBlock)errorBlock;


-(MKNetworkOperation*)redeemInviteCode:(NSString*)inviteCode
                       completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                            errorBlock:(VWWRESTEngineErrorBlock)errorBlock;


-(MKNetworkOperation*)getInviteCodeValid:(NSString*)inviteCode
                        completionBlock:(VWWRESTEngineInviteValidBlock)completionBlock
                             errorBlock:(VWWRESTEngineErrorBlock)errorBlock;


#pragma mark Feedback

-(MKNetworkOperation*)getFeedbackWithCompletionBlock:(VWWRESTEngineFeedbackBlock)completionBlock
                                                 errorBlock:(VWWRESTEngineErrorBlock)errorBlock;



@end
