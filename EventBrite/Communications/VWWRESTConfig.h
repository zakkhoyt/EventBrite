//
//  VWWRESTConfig.h
//  VWWModel
//
//  Created by Aleksandar Tosovic on 4/24/12.
//  Copyright (c) 2012 Webshots. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VWWRESTConfig : NSObject
@property (nonatomic) BOOL serviceSecure;
@property (nonatomic, strong) NSString* server;
@property (nonatomic, strong) NSString* serviceDomain;
@property (nonatomic, strong) NSString* serviceVersion;
@property (nonatomic, strong) NSString* serviceEndpoint;

@property (nonatomic, strong) NSString* serviceAlbumsURI;
@property (nonatomic, strong) NSString* serviceAssetsURI;
@property (nonatomic, strong) NSString* serviceAssetsBulkUpdateURI;
@property (nonatomic, strong) NSString* serviceBuddiesURI;
@property (nonatomic, strong) NSString* serviceClientsURI;
@property (nonatomic, strong) NSString* serviceDevicesURI;
@property (nonatomic, strong) NSString* serviceEventAssetsURI;
@property (nonatomic, strong) NSString* serviceEventsURI;
@property (nonatomic, strong) NSString* serviceFacetsURI;
@property (nonatomic, strong) NSString* serviceFacetsDateURI;
@property (nonatomic, strong) NSString* serviceFavoritesURI;
@property (nonatomic, strong) NSString* serviceFeedbackURI;
@property (nonatomic, strong) NSString* serviceFilterURI;
@property (nonatomic, strong) NSString* serviceFriendsURI;
@property (nonatomic, strong) NSString* serviceFollowersURI;
@property (nonatomic, strong) NSString* serviceHeartedAssetsURI;
@property (nonatomic, strong) NSString* serviceInvitationCodeValidateURI;
@property (nonatomic, strong) NSString* serviceInvitationsURI;
@property (nonatomic, strong) NSString* serviceInvitationsReceivedURI;
@property (nonatomic, strong) NSString* serviceNotesURI;
@property (nonatomic, strong) NSString* serviceNotificationsURI;
@property (nonatomic, strong) NSString* serviceRelationsURI;
@property (nonatomic, strong) NSString* serviceSearchEventsURI;
@property (nonatomic, strong) NSString* serviceServicesURI;
@property (nonatomic, strong) NSString* serviceSourcesURI;
@property (nonatomic, strong) NSString* serviceTokensURI;
@property (nonatomic, strong) NSString* serviceUsersURI;

+(VWWRESTConfig*)sharedInstance;
-(void)refreshServerFromUserDefaults;
@end