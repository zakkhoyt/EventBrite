//
//  VWWRESTConfig.m
//  VWWModel
//
//  Created by Zakk hoyt
//  Copyright (c) 2013 Webshots. All rights reserved.
//

#import "VWWRESTConfig.h"
//#import "SMAppDelegate.h"

static VWWRESTConfig *instance;


@interface VWWRESTConfig ()

@end

@implementation VWWRESTConfig
+(VWWRESTConfig*)sharedInstance{
    if(instance == nil){
        instance = [[VWWRESTConfig alloc]init];
    };
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
        
        [self readUserDefaults];

        _serviceVersion = @"v3";
        _serviceAlbumsURI = @"albums";
        _serviceAssetsURI = @"assets";
        _serviceAssetsBulkUpdateURI = @"assets/bulk_update";
        _serviceBuddiesURI = @"buddies";
        _serviceClientsURI = @"clients";
        _serviceDevicesURI = @"devices";
        _serviceEventAssetsURI = @"assets/event";
        _serviceEventsURI = @"events";
        _serviceFacetsURI = @"facets";
        _serviceFacetsDateURI = @"facets/date";
        _serviceFavoritesURI =	 @"favorites";
        _serviceFeedbackURI = @"feedbacks/current";
        _serviceFilterURI = @"filter";
        _serviceFriendsURI = @"friends";
        _serviceFollowersURI = @"followers";
        _serviceHeartedAssetsURI = @"assets/hearted";
        _serviceInvitationCodeValidateURI = @"invitations/validate";
        _serviceInvitationsURI = @"invitations";
        _serviceInvitationsReceivedURI = @"invitations/received";
        _serviceNotesURI = @"notes";
        _serviceNotificationsURI = @"notifications";
        _serviceRelationsURI = @"relations";
        _serviceSearchEventsURI = @"events/search";
        _serviceServicesURI = @"services";
        _serviceSourcesURI = @"sources";
        _serviceTokensURI = @"tokens";
        _serviceUsersURI = @"users";
    }
    return self;
}

-(void)readUserDefaults{
    _serviceSecure = [SMUserDefaults VWWServerSecure];
    _server =  [SMUserDefaults VWWServer];
    _server = [_server stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    _server = [_server stringByReplacingOccurrencesOfString:@"HTTP://" withString:@""];
    _server = [_server stringByReplacingOccurrencesOfString:@"ftp://" withString:@""];
    _server = [_server stringByReplacingOccurrencesOfString:@"FTP://" withString:@""];
    
    _serviceDomain = _server;
    _serviceEndpoint = [NSString stringWithFormat:@"%@/api", _server];
}

-(void)refreshServerFromUserDefaults{
    [self readUserDefaults];
}


@end