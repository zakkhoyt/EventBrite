//
//  VWWEngine.m
//  JSON
//
//  Created by Zakk Hoyt on 2/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWRESTEngine.h"
#import "VWWRESTParser.h"
#import "SMKeychain.h"
#import "SMUtility.h"



#defineVWW_LOG_CURL_COMMANDS 1

typedef void (^PVWWRESTEngineErrorBlock)(NSError* error, id responseJSON);
typedef void (^PSESuccessBlock)(id responseJSON);

static NSString* kHTTPTRequstTypePost = @"POST";
static NSString* kHTTPTRequstTypeGet = @"GET";
static NSString* kHTTPTRequstTypePut = @"PUT";
static NSString* kHTTPTRequstTypeDelete = @"DELETE";
static VWWRESTEngine *instance;

@interface VWWRESTEngine ()

@end

@implementation VWWRESTEngine

#pragma mark Overrides MKNetworkEngine

+(VWWRESTEngine*)sharedInstance{
    if(instance == nil){
        instance = [[VWWRESTEngine alloc]init];
    };
    return instance;
    
}

+(void)releaseSingleton{
    if(instance){
        [instance cancelAllOperations];
        [instance emptyCache];
        DDLogInfo(@"Releasing VWWRESTEngine");
        instance = nil;
    }
}

-(id)init{
    if(self){
        _service = [VWWRESTConfig sharedInstance];
        self = [super initWithHostName:_service.serviceEndpoint
                               apiPath:_service.serviceVersion
                    customHeaderFields:nil];
    }
    return self;
}

//-(void)enableCaching:(BOOL)enable{
//// This is causing issues where completion blocks are called twice. Yes that's what it is supposed to do, but
//// is not always desired.
//    [self useCache];
//}
//-(void)clearCachedData{
//    [self clearCache];
//}

-(void)prepareHeaders:(MKNetworkOperation *)operation {
    // Read stored token from keychain system
   VWWCredential *credential = [[SMKeychain sharedKeychain] credentialForItemWithID:kVWWTokenKeychainItemID];
    if ([credential.password length]) {
        NSDictionary* headersDict = @{@"X-Auth-Token": credential.password};
        [operation addHeaders:headersDict];
    }

    [super prepareHeaders:operation];
    
    
    // detect if server has changed
    if([self.service.server isEqualToString:[SMUserDefaults VWWServer]] == NO){
        // The user has changed the server in settings. Display notification and kill the app on confirm
        [[[UIAlertView alloc]initWithTitle:@"Server change"
                                   message:@"A change to the server address and will close. When restarted it will use the new address"
                                  delegate:self
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil, nil]show];
    }
    
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    exit(0);
}

#pragma mark Private custom methods
-(MKNetworkOperation*) httpGetEndpoint:(NSString*)endpoint
                        jsonDictionary:(NSDictionary*)jsonDictionary
                       completionBlock:(PSESuccessBlock)completionBlock
                            errorBlock:(PVWWRESTEngineErrorBlock)errorBlock{
    MKNetworkOperation* operation = [self operationWithPath:endpoint
                                                     params:jsonDictionary
                                                 httpMethod:kHTTPTRequstTypeGet
                                                        ssl:self.service.serviceSecure];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
#if defined(SM_LOG_CURL_COMMANDS)

        DDLogVerbose(@"Success! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        completionBlock(completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#if defined(SM_LOG_CURL_COMMANDS)
        DDLogVerbose(@"Error! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        [self examineHTTPError:completedOperation];
        errorBlock(error, completedOperation.responseJSON);
    }];
    
    [self enqueueOperation:operation];
    return operation;
}


-(MKNetworkOperation*) httpPostEndpoint:(NSString*)endpoint
                         jsonDictionary:(NSDictionary*)jsonDictionary
                         completionBlock:(PSESuccessBlock)completionBlock
                              errorBlock:(PVWWRESTEngineErrorBlock)errorBlock{
    
    MKNetworkOperation* operation = [self operationWithPath:endpoint
                                                     params:jsonDictionary
                                                 httpMethod:kHTTPTRequstTypePost
                                                        ssl:self.service.serviceSecure];
    
    [operation setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
#if defined(SM_LOG_CURL_COMMANDS)
        DDLogVerbose(@"Success! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        completionBlock(completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#if defined(SM_LOG_CURL_COMMANDS)
         DDLogVerbose(@"Error! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        [self examineHTTPError:completedOperation];
        errorBlock(error, completedOperation.responseJSON);
    }];
    
    [self enqueueOperation:operation];
    return operation;
}


-(MKNetworkOperation*) httpPutEndpoint:(NSString*)endpoint
                        jsonDictionary:(NSDictionary*)jsonDictionary
                        completionBlock:(PSESuccessBlock)completionBlock
                             errorBlock:(PVWWRESTEngineErrorBlock)errorBlock{

    MKNetworkOperation* operation = [self operationWithPath:endpoint
                                                     params:jsonDictionary
                                                 httpMethod:kHTTPTRequstTypePut
                                                        ssl:self.service.serviceSecure];
    [operation setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
#if defined(SM_LOG_CURL_COMMANDS)
        DDLogVerbose(@"Success! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        completionBlock(completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#if defined(SM_LOG_CURL_COMMANDS)
        DDLogVerbose(@"Error! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        [self examineHTTPError:completedOperation];
        errorBlock(error, completedOperation.responseJSON);
    }];
    
    [self enqueueOperation:operation];
    return operation;
}

-(MKNetworkOperation*) httpDeleteEndpoint:(NSString*)endpoint
                           jsonDictionary:(NSDictionary*)jsonDictionary
                          completionBlock:(PSESuccessBlock)completionBlock
                               errorBlock:(PVWWRESTEngineErrorBlock)errorBlock{

    MKNetworkOperation* operation = [self operationWithPath:endpoint
                                                     params:jsonDictionary
                                                 httpMethod:kHTTPTRequstTypeDelete
                                                        ssl:self.service.serviceSecure];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
#if defined(SM_LOG_CURL_COMMANDS)
        DDLogVerbose(@"Success! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        completionBlock(completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#if defined(SM_LOG_CURL_COMMANDS)
        DDLogVerbose(@"Error! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        [self examineHTTPError:completedOperation];
        errorBlock(error, completedOperation.responseJSON);
    }];
    
    [self enqueueOperation:operation];
    return operation;
    
}

-(void)examineHTTPError:(MKNetworkOperation*)completedOperation{
    DDLogError(@"**************** SERVER ERROR %d from curl command: %@", completedOperation.HTTPStatusCode, completedOperation.curlCommandLineString);
    if([SMUserDefaults debugMode] == YES){
        NSString *alertText = [NSString stringWithFormat:@"JSON:\n%@\nCURL:\n%@", (NSString*)completedOperation.responseJSON, completedOperation.curlCommandLineString];
        [SMUtility errorAlert:alertText title:[NSString stringWithFormat:@"Server code:%d", completedOperation.HTTPStatusCode]];
    }

}

// This is a utility to overwrite a json call from the VWW server with the contents of a file named $file$.json
-(id)jsonObjectFromFile:(NSString*)file{

    NSString *fName = [[NSBundle mainBundle] pathForResource:file ofType:@"json"];
    if(fName == nil){
        return nil;
    }
    NSError *error;
    NSString *json = [NSString stringWithContentsOfFile:fName encoding:NSUTF8StringEncoding error:&error];
    if(error){
        DDLogError(@"Error reading json file: %@", file);
        return nil;
    }
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    id r = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if(error){
        DDLogError(@"Error createing json object from json file: %@", file);
        return nil;
    }
    return r;
}


#pragma mark Public custom methods


#pragma mark S3

//-(MKNetworkOperation*) httpSendFileToS3:(NSString*)path
//                       uploadParameters:(NSDictionary*)uploadParameters
//                                   file:(NSString*)file
//                        completionBlock:(SEBoolBlock)completionBlock
//                             errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
//    
//    NSString *kFileKey = @"file";
//    
//    DDLogInfo(@"Sending file to %@", path);
//    MKNetworkOperation *op = [self operationWithURLString:path
//                                                   params:uploadParameters
//                                               httpMethod:kHTTPTRequstTypePut];
//    
//    
//    [op addFile:file forKey:kFileKey];
//    
//    //    // setFreezable uploads your images after connection is restored!
//    //        [op setFreezable:YES];
//    
//    [op onUploadProgressChanged:^(double progress) {
////        NSLog(@"upload progress=%f", progress);
//    }];
//    
//    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
////        NSLog(@"%@",[completedOperation responseString]);
////        NSDictionary *jsonString = [completedOperation responseJSON];
////        NSLog(@"%@",jsonString);
//        completionBlock(YES);
//    }
//                errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//                    errorBlock(error, nil);
//                }];
//    
//    [self enqueueOperation:op forceReload:YES];
//    
//    return op;
//}


#pragma mark Logging in (Tokens)
-(MKNetworkOperation*)createTokenWithForm:(SMVWWLogInForm*)form
                          completionBlock:(VWWRESTEngineTokenUserBlock)completionBlock
                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    return [self httpPostEndpoint:self.service.serviceTokensURI
                   jsonDictionary:[form httpParametersDictionary]
                  completionBlock:^(id responseJSON){
                      NSString *token;
                      [VWWRESTParser parseJSON:responseJSON token:&token];
                     VWWUser *user;
                      [VWWRESTParser parseJSON:responseJSON user:&user];
                      completionBlock(token, user);
                  }
                       errorBlock:^(NSError *error, id responseJSON){
                           errorBlock(error, responseJSON[@"message"]);
                       }];
    
}


#pragma mark Password
//-(MKNetworkOperation*)updatePasswordWithUUID:(NSString*)UUID
//                                        form:(SMHTTPForm*)form
//                             completionBlock:(SEEmptyBlock)completionBlock
//                                  errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
//        return [self httpPutEndpoint:[NSString stringWithFormat:@"%@/%@", self.service.serviceUsersURI, UUID]
//                  jsonDictionary:[form httpParametersDictionary]
//                 completionBlock:^(id responseJSON){
//                     completionBlock();
//                 }
//                      errorBlock:^(NSError *error, id responseJSON){
//                          errorBlock(error, responseJSON[@"message"]);
//                      }];
//}





#pragma mark Users
// POST to user, returns token and user
-(MKNetworkOperation*)createUserWithForm:(SMVWWSignUpForm*)form
                         completionBlock:(VWWRESTEngineTokenUserBlock)completionBlock
                              errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        return [self httpPostEndpoint:self.service.serviceUsersURI
                       jsonDictionary:[form httpParametersDictionary]
                      completionBlock:^(id responseJSON){
                          NSString *token;
                          [VWWRESTParser parseJSON:responseJSON token:&token];
                         VWWUser *user;
                          [VWWRESTParser parseJSON:responseJSON user:&user];
                          completionBlock(token, user);
                      }
                           errorBlock:^(NSError *error, id responseJSON){
                               errorBlock(error, responseJSON[@"message"]);
                           }];
    }
}

//[NSString stringWithFormat:@"%@/%@", self.service.serviceUsersURI, userUUID]
-(MKNetworkOperation*)getUserProfileWithUUID:(NSString*)userUUID
                             completionBlock:(VWWRESTEngineUserBlock)completionBlock
                                  errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {
        return [self httpGetEndpoint:[NSString stringWithFormat:@"%@/%@", self.service.serviceUsersURI, userUUID]
                      jsonDictionary:nil
                     completionBlock:^(id responseJSON) {
                        VWWUser *user;
                         [VWWRESTParser parseJSON:responseJSON user:&user];
                         completionBlock(user);
                     } errorBlock:^(NSError *error, id responseJSON) {
                        
                     }];
    }
}


-(MKNetworkOperation*)updateUser:(NSString*)UUID
                        withForm:(SMUpdateUserForm*)form
                 completionBlock:(VWWRESTEngineUserBlock)completionBlock
                      errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {

    return [self httpPutEndpoint:[NSString stringWithFormat:@"%@/%@", self.service.serviceUsersURI, UUID]
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id responseJSON){
                    VWWUser *user;
                     [VWWRESTParser parseJSON:responseJSON user:&user];
                     completionBlock(user);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    }
}



#pragma mark Users (buddies)
-(MKNetworkOperation*)getBuddiesWithForm:(SMPageForm*)form
                         completionBlock:(VWWRESTEngineBuddiesBlock)completionBlock
                              errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {

    return [self httpGetEndpoint:self.service.serviceBuddiesURI
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id responseJSON){
                     NSArray *buddies;
                    VWWPagination *page;
                     [VWWRESTParser parseJSON:responseJSON buddies:&buddies page:&page];
                     completionBlock(buddies);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    }
}


-(MKNetworkOperation*)getBuddiesAndFriendsWithForm:(SMPageForm*)form
                                   completionBlock:(VWWRESTEngineBuddiesBlock)completionBlock
                                        errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {
        return [self httpGetEndpoint:[NSString stringWithFormat:@"%@?include_friends=true", self.service.serviceBuddiesURI]
                      jsonDictionary:[form httpParametersDictionary]
                     completionBlock:^(id responseJSON){
                         NSArray *buddies;
                        VWWPagination *page;
                         [VWWRESTParser parseJSON:responseJSON buddies:&buddies page:&page];
                         completionBlock(buddies);
                     }
                          errorBlock:^(NSError *error, id responseJSON){
                              errorBlock(error, responseJSON[@"message"]);
                          }];
    }
}




-(MKNetworkOperation*)deleteBuddyWithUUID:(NSString*)uuid
                          completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {

    return [self httpDeleteEndpoint:[NSString stringWithFormat:@"%@/%@", self.service.serviceBuddiesURI, uuid]
                     jsonDictionary:nil
                    completionBlock:^(id responseJSON){
                        completionBlock();
                    }
                         errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    }
}

#pragma mark Events
-(MKNetworkOperation*)createEventWithForm:(SMCreateEventForm*)form
                          completionBlock:(VWWRESTEngineEventBlock)completionBlock
                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        
        return [self httpPostEndpoint:self.service.serviceEventsURI
                       jsonDictionary:[form httpParametersDictionary]
                      completionBlock:^(id responseJSON){
                         VWWEvent *event;
                          [VWWRESTParser parseJSON:responseJSON event:&event];
                          completionBlock(event);
                      }
                           errorBlock:^(NSError *error, id responseJSON){
                               errorBlock(error, responseJSON[@"message"]);
                           }];
    }
}


// http://wbs.ht/api/v3/events?search=true&latitude=37.9922&longitude=-122.5814&radius=10
-(MKNetworkOperation*)getEventsWithForm:(SMGetEventsForm*)form
                        completionBlock:(VWWRESTEngineEventsBlock)completionBlock
                             errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
    
    return [self httpGetEndpoint:self.service.serviceEventsURI
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id responseJSON){
                     NSArray *events;
                    VWWPagination *page;
                     [VWWRESTParser parseJSON:responseJSON events:&events page:&page];
                     completionBlock(events);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    }
}



-(MKNetworkOperation*)getAssetsOfEvent:(NSString*)uuid
                              withForm:(SMPageForm*)form
                       completionBlock:(VWWRESTEngineAssetsBlock)completionBlock
                            errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        
        return [self httpGetEndpoint:[NSString stringWithFormat:@"%@/%@/assets", self.service.serviceEventsURI, uuid]
                      jsonDictionary:[form httpParametersDictionary]
                     completionBlock:^(id responseJSON){
                         NSArray *assets;
                        VWWPagination *page;
                         [VWWRESTParser parseJSON:responseJSON assets:&assets page:&page];
                         completionBlock(assets);
                     }
                          errorBlock:^(NSError *error, id responseJSON){
                              errorBlock(error, responseJSON[@"message"]);
                          }];
    }
}

-(MKNetworkOperation*)getUsersOfEvent:(NSString*)uuid
                             withForm:(SMPageForm*)form
                      completionBlock:(VWWRESTEngineUsersBlock)completionBlock
                           errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        
        return [self httpGetEndpoint:[NSString stringWithFormat:@"%@/%@/users", self.service.serviceEventsURI, uuid]
                      jsonDictionary:[form httpParametersDictionary]
                     completionBlock:^(id responseJSON){
                         NSArray *users;
                        VWWPagination *page;
                         [VWWRESTParser parseJSON:responseJSON users:&users page:&page];
                         completionBlock(users);
                     }
                          errorBlock:^(NSError *error, id responseJSON){
                              errorBlock(error, responseJSON[@"message"]);
                          }];
    }
}

-(MKNetworkOperation*)subscribeToEvent:(NSString*)uuid
                       completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                            errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        
        return [self httpPostEndpoint:[NSString stringWithFormat:@"%@/%@/users", self.service.serviceEventsURI, uuid]
                       jsonDictionary:nil
                      completionBlock:^(id responseJSON){
                          completionBlock();
                      }
                           errorBlock:^(NSError *error, id responseJSON){
                               errorBlock(error, responseJSON[@"message"]);
                           }];
    }

}




-(MKNetworkOperation*)deleteEventWithUUID:(NSString*)uuid
                          completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {
        return [self httpDeleteEndpoint:[NSString stringWithFormat:@"%@/%@", self.service.serviceEventsURI, uuid]
                         jsonDictionary:nil
                        completionBlock:^(id responseJSON){
                            completionBlock();
                        }
                             errorBlock:^(NSError *error, id responseJSON){
                                 errorBlock(error, responseJSON[@"message"]);
                             }];
    }
}



#pragma mark Sources

-(MKNetworkOperation*)getSourcesWithForm:(SMPageForm*)form
                         completionBlock:(VWWRESTEngineSourcesBlock)completionBlock
                              errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {

    return [self httpGetEndpoint:self.service.serviceSourcesURI
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id responseJSON){
                     
                     NSArray *sources = nil;
                    VWWPagination *page = nil;
                     [VWWRESTParser parseJSON:responseJSON
                                       sources:&sources
                                           page:&page];
                     completionBlock(sources);
                     
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    }
    
}


-(MKNetworkOperation*)createSourceWithForm:(SMCreateSourceForm*)form
                           completionBlock:(VWWRESTEngineSourceBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {

    return [self httpPostEndpoint:self.service.serviceSourcesURI
                   jsonDictionary:[form httpParametersDictionary]
                  completionBlock:^(id responseJSON){
                     VWWSource *source = nil;
                      [VWWRESTParser parseJSON:responseJSON source:&source];
                      completionBlock(source);
                  }
                       errorBlock:^(NSError *error, id responseJSON){
                           errorBlock(error, responseJSON[@"message"]);
                       }];
    }
}


-(MKNetworkOperation*)updateSourceWithUUID:(NSString*)UUID
                                  withForm:(SMUpdateSourceForm*)form
                           completionBlock:(VWWRESTEngineSourceBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {

    return [self httpPutEndpoint:[NSString stringWithFormat:@"%@/%@", form.isDevice ? @"devices" : @"sources", UUID]
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id responseJSON){
                    VWWSource *source = nil;
                     [VWWRESTParser parseJSON:responseJSON source:&source];
                     completionBlock(source);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    }
}

#pragma mark Devices

-(MKNetworkOperation*)getDevicesOfUserWithID:(NSString*)UUID
                                    withForm:(SMPageForm*)form
                             completionBlock:(VWWRESTEngineDevicesBlock)completionBlock
                                  errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {

        NSString *endpoint = [NSString stringWithFormat:@"%@/%@/%@", self.service.serviceUsersURI, UUID, self.service.serviceDevicesURI];
        NSDictionary *httpDictionary = [form httpParametersDictionary];
        return [self httpGetEndpoint:endpoint
                    jsonDictionary:httpDictionary
                 completionBlock:^(id responseJSON){
                     NSArray *devices = nil;
                    VWWPagination *page = nil;
                     [VWWRESTParser parseJSON:responseJSON
                                        devices:&devices
                                           page:&page];
                     completionBlock(devices);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    }
    
}

-(MKNetworkOperation*)createDeviceWithForm:(SMCreateDeviceForm*)form
                           completionBlock:(VWWRESTEngineSourceBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {

    return [self httpPostEndpoint:self.service.serviceDevicesURI
                   jsonDictionary:[form httpParametersDictionary]
                  completionBlock:^(id responseJSON){
                     VWWSource *device = nil;
                      [VWWRESTParser parseJSON:responseJSON
                                          source:&device];
                      
                      completionBlock(device);
                  }
                       errorBlock:^(NSError *error, id responseJSON){
                           errorBlock(error, responseJSON[@"message"]);
                       }];
    }
}

#pragma mark Assets

-(MKNetworkOperation*)createAssetWithForm:(SMCreateAssetForm*)form
                          completionBlock:(VWWRESTEngineAssetBlock)completionBlock
                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {


    return [self httpPostEndpoint:self.service.serviceAssetsURI
                   jsonDictionary:[form httpParametersDictionary]
                  completionBlock:^(id responseJSON){
                     VWWAsset *asset = nil;
                      [VWWRESTParser parseJSON:responseJSON asset:&asset];
                      completionBlock(asset);
                  }
                       errorBlock:^(NSError *error, id responseJSON){
                           errorBlock(error, responseJSON[@"message"]);
                       }];
    }
}

-(MKNetworkOperation*)updateAssetWithUUID:(NSString*)UUID
                                 withForm:(SMHTTPForm*)form
                          completionBlock:(VWWRESTEngineAssetBlock)completionBlock
                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {

        return [self httpPutEndpoint:[NSString stringWithFormat:@"%@/%@", self.service.serviceAssetsURI, UUID]
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id responseJSON){
                    VWWAsset *asset = nil;
                     [VWWRESTParser parseJSON:responseJSON asset:&asset];
                     completionBlock(asset);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    }
}


-(MKNetworkOperation*)deleteAssetWithUUID:(NSString*)uuid
                          completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {
        return [self httpDeleteEndpoint:[NSString stringWithFormat:@"%@/%@", self.service.serviceAssetsURI, uuid]
                         jsonDictionary:nil
                        completionBlock:^(id responseJSON){
                            completionBlock();
                        }
                             errorBlock:^(NSError *error, id responseJSON){
                                 errorBlock(error, responseJSON[@"message"]);
                             }];
    }
}




//#pragma mark Assets (events)
//-(MKNetworkOperation*)getEventAssetsWithForm:(SMGetEventAssetsForm*)form
//                             completionBlock:(VWWRESTEngineAssetsBlock)completionBlock
//                                  errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
//    @autoreleasepool {
//        return [self httpGetEndpoint:self.service.serviceEventAssetsURI
//                      jsonDictionary:[form httpParametersDictionary]
//                     completionBlock:^(id responseJSON){
//                        VWWPagination *page = nil;
//                         NSArray *assets = nil;
//                         [VWWRESTParser parseJSON:responseJSON assets:&assets page:&page];
//                         completionBlock(assets);
//                     }
//                          errorBlock:^(NSError *error, id responseJSON){
//                              errorBlock(error, responseJSON[@"message"]);
//                          }];
//    }
//    
//}


#pragma mark Assets (favorites)

///api/v3/assets/hearted?date=2013-06-01T22:26:35Z
-(MKNetworkOperation*)getHeartedAssetsWithForm:(SMGetHeartedAssetsForm*)form
                              completionBlock:(VWWRESTEngineAssetsPageBlock)completionBlock
                                    errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {

    return [self httpGetEndpoint:self.service.serviceHeartedAssetsURI
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id responseJSON){
                    VWWPagination *page = nil;
                     NSArray *assets = nil;
                     [VWWRESTParser parseJSON:responseJSON assets:&assets page:&page];
                     completionBlock(assets, page);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    }
    
}



-(MKNetworkOperation*)getFavoriteAssetsWithForm:(SMGetFavoriteAssetsForm*)form
                                completionBlock:(VWWRESTEngineAssetsPageBlock)completionBlock
                                     errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        return [self httpGetEndpoint:self.service.serviceAssetsURI
                      jsonDictionary:[form httpParametersDictionary]
                     completionBlock:^(id responseJSON){
                        VWWPagination *page;
                         NSArray *assets;
                         [VWWRESTParser parseJSON:responseJSON assets:&assets page:&page];
                         completionBlock(assets, page);
                     }
                          errorBlock:^(NSError *error, id responseJSON){
                              errorBlock(error, responseJSON[@"message"]);
                          }];
    }
}



-(MKNetworkOperation*)getAssetsWithForm:(SMGetAssetsForm*)form
                        completionBlock:(VWWRESTEngineAssetsPageBlock)completionBlock
                             errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        
        return [self httpGetEndpoint:self.service.serviceAssetsURI
                      jsonDictionary:[form httpParametersDictionary]
                     completionBlock:^(id responseJSON){
                        VWWPagination *page = nil;
                         NSArray *assets = nil;
                         [VWWRESTParser parseJSON:responseJSON assets:&assets page:&page];
                         completionBlock(assets, page);
                     }
                          errorBlock:^(NSError *error, id responseJSON){
                              errorBlock(error, responseJSON[@"message"]);
                          }];
    }
    
}


-(MKNetworkOperation*)favoriteAssetWithForm:(SMUpdateFavoriteForm*)form
                            completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                                 errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {

    return [self httpPostEndpoint:self.service.serviceFavoritesURI
                   jsonDictionary:[form httpParametersDictionary]
                  completionBlock:^(id responseJSON){
                      completionBlock();
                  }
                       errorBlock:^(NSError *error, id responseJSON){
                           errorBlock(error, responseJSON[@"message"]);
                       }];
    }
}

-(MKNetworkOperation*)unfavoriteAssetWithUUID:(NSString*)uuid
                              completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                                   errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {

    return [self httpDeleteEndpoint:[NSString stringWithFormat:@"%@/%@", self.service.serviceFavoritesURI, uuid]
                   jsonDictionary:nil
                  completionBlock:^(id responseJSON){
                      completionBlock();
                  }
                       errorBlock:^(NSError *error, id responseJSON){
                           errorBlock(error, responseJSON[@"message"]);
                       }];
    }
}


-(MKNetworkOperation*)getAssetWithUUID:(NSString*)uuid
                              completionBlock:(VWWRESTEngineAssetDetailsBlock)completionBlock
                                   errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {

    return [self httpGetEndpoint:[NSString stringWithFormat:@"%@/%@", self.service.serviceAssetsURI, uuid]
                  jsonDictionary:nil
                 completionBlock:^(id responseJSON){
                    VWWAsset *asset;
                     NSArray *users;
                     [VWWRESTParser parseJSON:responseJSON asset:&asset users:&users];
                     completionBlock(asset, users);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    }
    return nil;
}








-(MKNetworkOperation*)getFavoriteAssetsWithCompletionBlock:(VWWRESTEngineAssetDetailsBlock)completionBlock
                                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        
        return [self httpGetEndpoint:[NSString stringWithFormat:@"%@?user=favorite", self.service.serviceAssetsURI]
                      jsonDictionary:nil
                     completionBlock:^(id responseJSON){
                        VWWAsset *asset;
                         NSArray *users;
                         [VWWRESTParser parseJSON:responseJSON asset:&asset users:&users];
                         completionBlock(asset, users);
                     }
                          errorBlock:^(NSError *error, id responseJSON){
                              errorBlock(error, responseJSON[@"message"]);
                          }];
    }
    return nil;
}



-(MKNetworkOperation*)getAssetOnlyWithUUID:(NSString*)uuid
                           completionBlock:(VWWRESTEngineAssetBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        
        return [self httpGetEndpoint:[NSString stringWithFormat:@"%@/%@", self.service.serviceAssetsURI, uuid]
                      jsonDictionary:nil
                     completionBlock:^(id responseJSON){
                        VWWAsset *asset;
                         [VWWRESTParser parseJSON:responseJSON asset:&asset];
                         completionBlock(asset);
                     }
                          errorBlock:^(NSError *error, id responseJSON){
                              errorBlock(error, responseJSON[@"message"]);
                          }];
    }
    return nil;
}

#pragma mark Assets (notes)

-(MKNetworkOperation*)getAssetNotesWithUUID:(NSString*)uuid
                            completionBlock:(VWWRESTEngineNotesBlock)completionBlock
                                 errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        
        return [self httpGetEndpoint:[NSString stringWithFormat:@"%@/%@/%@", self.service.serviceAssetsURI, uuid, self.service.serviceNotesURI]
                      jsonDictionary:nil
                     completionBlock:^(id responseJSON){
                         NSArray *notes;
                        VWWPagination *page;
                         [VWWRESTParser parseJSON:responseJSON notes:&notes page:&page];
                         completionBlock(notes, page);
                     }
                          errorBlock:^(NSError *error, id responseJSON){
                              errorBlock(error, responseJSON[@"message"]);
                          }];
    }
    return nil;
}

// POST
// api/v3/assets/40c3deecd92dfcd86d94ff19126dd5ae24e58979b0c87e8952d7a4e5b154cee5/notes
-(MKNetworkOperation*)createNoteForAssetUUID:(NSString*)uuid
                                        form:(SMCreateNoteForm*)form
                             completionBlock:(VWWRESTEngineNoteBlock)completionBlock
                                  errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        return [self httpPostEndpoint: [NSString stringWithFormat:@"%@/%@/%@", self.service.serviceAssetsURI, uuid, self.service.serviceNotesURI]
                       jsonDictionary:[form httpParametersDictionary]
                      completionBlock:^(id responseJSON){
                         VWWNote *note;
                          [VWWRESTParser parseJSON:responseJSON note:&note];
                          completionBlock(note);
                      }
                           errorBlock:^(NSError *error, id responseJSON){
                               errorBlock(error, responseJSON[@"message"]);
                           }];
    }
}

// PUT
// /api/v3/assets/40c3deecd92dfcd86d94ff19126dd5ae24e58979b0c87e8952d7a4e5b154cee5/notes/b81664c0fec20130df49406c8f2b585a
-(MKNetworkOperation*)updateNoteForAssetUUID:(NSString*)assetUUID
                                    noteUUID:(NSString*)noteUUID
                                        form:(SMUpdateNoteForm*)form
                             completionBlock:(VWWRESTEngineNoteBlock)completionBlock
                                  errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        return [self httpPutEndpoint:[NSString stringWithFormat:@"%@/%@/%@/%@",
                                      self.service.serviceAssetsURI,
                                      assetUUID,
                                      self.service.serviceNotesURI,
                                      noteUUID]
                      jsonDictionary:[form httpParametersDictionary]
                     completionBlock:^(id responseJSON){
                        VWWNote *note;
                         [VWWRESTParser parseJSON:responseJSON note:&note];
                         completionBlock(note);
                     }
                          errorBlock:^(NSError *error, id responseJSON){
                              errorBlock(error, responseJSON[@"message"]);
                          }];
    }
}

// DELETE
// /api/v3/assets/40c3deecd92dfcd86d94ff19126dd5ae24e58979b0c87e8952d7a4e5b154cee5/notes/b81664c0fec20130df49406c8f2b585a
-(MKNetworkOperation*)deleteNoteForAssetUUID:(NSString*)assetUUID
                                     noteUUID:(NSString*)noteUUID
                              completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                                   errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        return [self httpDeleteEndpoint:[NSString stringWithFormat:@"%@/%@/%@/%@",
                                         self.service.serviceAssetsURI,
                                         assetUUID,
                                         self.service.serviceNotesURI,
                                         noteUUID]
                         jsonDictionary:nil
                        completionBlock:^(id responseJSON){
                            completionBlock();
                        }
                             errorBlock:^(NSError *error, id responseJSON){
                                 errorBlock(error, responseJSON[@"message"]);
                             }];
    }
}







#pragma mark Notifications

//-(MKNetworkOperation*)sendNotificationToUserWithID:(NSString*)UUID
//                                          withForm:(SMHTTPForm*)form
//                                   completionBlock:(SEEmptyBlock)completionBlock
//                                        errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
//        return [self httpPostEndpoint:[NSString stringWithFormat:@"%@/%@/%@", self.service.serviceUsersURI, UUID, self.service.serviceNotificationsURI]
//                   jsonDictionary:[form httpParametersDictionary]
//                  completionBlock:^(id responseJSON){
//                      completionBlock();
//                  }
//                       errorBlock:^(NSError *error, id responseJSON){
//                           errorBlock(error, responseJSON[@"message"]);
//                       }];
//}






#pragma mark Invitations
-(MKNetworkOperation*)createInviteWithForm:(SMCreateInviteForm*)form
                           completionBlock:(VWWRESTEngineInviteBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {

    return [self httpPostEndpoint:self.service.serviceInvitationsURI
                   jsonDictionary:[form httpParametersDictionary]
                  completionBlock:^(id responseJSON){
                     VWWInvite *invite;
                      [VWWRESTParser parseJSON:responseJSON invite:&invite];
                      completionBlock(invite);
                  }
                       errorBlock:^(NSError *error, id responseJSON){
                           errorBlock(error, responseJSON[@"message"]);
                           
                       }];
    }

}



-(MKNetworkOperation*)getInvitesWithForm:(SMPageForm*)form
                         completionBlock:(VWWRESTEngineInvitesBlock)completionBlock
                              errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {

    return [self httpGetEndpoint:[NSString stringWithFormat:@"%@", self.service.serviceInvitationsURI]
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id responseJSON){
                     NSArray *invites;
                    VWWPagination *page;
                     [VWWRESTParser parseJSON:responseJSON invites:&invites page:&page];
                     completionBlock(invites);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    }
}


-(MKNetworkOperation*)deleteInviteWithUUID:(NSString*)uuid
                           completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                                errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {

    return [self httpDeleteEndpoint:[NSString stringWithFormat:@"%@/%@", self.service.serviceInvitationsURI, uuid]
                     jsonDictionary:nil
                    completionBlock:^(id responseJSON){
                        completionBlock();
                    }
                         errorBlock:^(NSError *error, id responseJSON){
                             errorBlock(error, responseJSON[@"message"]);
                         }];
    }
}


-(MKNetworkOperation*)getInvitesReceivedWithForm:(SMPageForm*)form
                                 completionBlock:(VWWRESTEngineInvitesBlock)completionBlock
                                      errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {
    return [self httpGetEndpoint:[NSString stringWithFormat:@"%@", self.service.serviceInvitationsReceivedURI]
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id responseJSON){
                     NSArray *invites;
                    VWWPagination *page;
                     [VWWRESTParser parseJSON:responseJSON invites:&invites page:&page];
                     completionBlock(invites);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    }
}



-(MKNetworkOperation*)redeemInviteCode:(NSString*)inviteCode
                       completionBlock:(VWWRESTEngineEmptyBlock)completionBlock
                            errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {
    return [self httpPutEndpoint:[NSString stringWithFormat:@"%@/%@", self.service.serviceInvitationsURI, inviteCode]
                   jsonDictionary:nil
                  completionBlock:^(id responseJSON){
                      completionBlock();
                  }
                       errorBlock:^(NSError *error, id responseJSON){
                           errorBlock(error, responseJSON[@"message"]);
                       }];
    }
    
}


-(MKNetworkOperation*)getInviteCodeValid:(NSString*)inviteCode
                        completionBlock:(VWWRESTEngineInviteValidBlock)completionBlock
                             errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
        return [self httpGetEndpoint:[NSString stringWithFormat:@"%@?code=%@", self.service.serviceInvitationCodeValidateURI, inviteCode]
                      jsonDictionary:nil
                     completionBlock:^(id responseJSON){
                         BOOL valid;
                         [VWWRESTParser parseJSON:responseJSON inviteCodeIsValid:&valid];
                         completionBlock(valid);
                     }
                          errorBlock:^(NSError *error, id responseJSON){
                              errorBlock(error, responseJSON[@"message"]);
                          }];
    }
    
}



-(MKNetworkOperation*)getFeedbackWithCompletionBlock:(VWWRESTEngineFeedbackBlock)completionBlock
                                                 errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    
    @autoreleasepool {
        
        return [self httpGetEndpoint:self.service.serviceFeedbackURI
                      jsonDictionary:nil
                     completionBlock:^(id responseJSON){
                         NSArray *feedback;
                         [VWWRESTParser parseJSON:responseJSON feedback:&feedback];
                         completionBlock(feedback);
                     }
                          errorBlock:^(NSError *error, id responseJSON){
                              errorBlock(error, responseJSON[@"message"]);
                          }];
    }
    
}

@end
