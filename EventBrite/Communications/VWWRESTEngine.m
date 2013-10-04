//
//  VWWEngine.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWRESTEngine.h"
#import "VWWRESTParser.h"
#import "VWWKeychain.h"
#import "VWWUtility.h"



#define VWW_LOG_CURL_COMMANDS 1

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
        NSLog(@"Releasing VWWRESTEngine");
        instance = nil;
    }
}

-(id)init{
    if(self){
        _service = [VWWRESTConfig sharedInstance];
        self = [super initWithHostName:_service.serviceEndpoint
                               apiPath:_service.serviceDataFormat
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
   VWWCredential *credential = [[VWWKeychain sharedKeychain] credentialForItemWithID:kVWWTokenKeychainItemID];
    if ([credential.password length]) {
        NSDictionary* headersDict = @{@"X-Auth-Token": credential.password};
        [operation addHeaders:headersDict];
    }

    [super prepareHeaders:operation];
    
    
    // detect if server has changed
    if([self.service.server isEqualToString:[VWWUserDefaults server]] == NO){
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
#if defined(VWW_LOG_CURL_COMMANDS)

        NSLog(@"Success! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        completionBlock(completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#if defined(VWW_LOG_CURL_COMMANDS)
        NSLog(@"Error! CURL command: %@", completedOperation.curlCommandLineString);
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
#if defined(VWW_LOG_CURL_COMMANDS)
        NSLog(@"Success! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        completionBlock(completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#if defined(VWW_LOG_CURL_COMMANDS)
         NSLog(@"Error! CURL command: %@", completedOperation.curlCommandLineString);
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
#if defined(VWW_LOG_CURL_COMMANDS)
        NSLog(@"Success! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        completionBlock(completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#if defined(VWW_LOG_CURL_COMMANDS)
        NSLog(@"Error! CURL command: %@", completedOperation.curlCommandLineString);
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
#if defined(VWW_LOG_CURL_COMMANDS)
        NSLog(@"Success! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        completionBlock(completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#if defined(VWW_LOG_CURL_COMMANDS)
        NSLog(@"Error! CURL command: %@", completedOperation.curlCommandLineString);
#endif
        [self examineHTTPError:completedOperation];
        errorBlock(error, completedOperation.responseJSON);
    }];
    
    [self enqueueOperation:operation];
    return operation;
    
}

-(void)examineHTTPError:(MKNetworkOperation*)completedOperation{
    NSLog(@"**************** SERVER ERROR %ld from curl command: %@", completedOperation.HTTPStatusCode, completedOperation.curlCommandLineString);
    if([VWWUserDefaults debugMode] == YES){
        NSString *alertText = [NSString stringWithFormat:@"JSON:\n%@\nCURL:\n%@", (NSString*)completedOperation.responseJSON, completedOperation.curlCommandLineString];
        [VWWUtility errorAlert:alertText title:[NSString stringWithFormat:@"Server code:%ld", completedOperation.HTTPStatusCode]];
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
        NSLog(@"Error reading json file: %@", file);
        return nil;
    }
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    id r = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if(error){
        NSLog(@"Error createing json object from json file: %@", file);
        return nil;
    }
    return r;
}


#pragma mark Public custom methods


#pragma mark Events
//-(MKNetworkOperation*)createEventWithForm:(VWWCreateEventForm*)form
//                          completionBlock:(VWWRESTEngineEventBlock)completionBlock
//                               errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
//    @autoreleasepool {
//        
//        return [self httpPostEndpoint:self.service.serviceEventsURI
//                       jsonDictionary:[form httpParametersDictionary]
//                      completionBlock:^(id responseJSON){
//                         VWWEvent *event;
//                          [VWWRESTParser parseJSON:responseJSON event:&event];
//                          completionBlock(event);
//                      }
//                           errorBlock:^(NSError *error, id responseJSON){
//                               errorBlock(error);
//                           }];
//    }
//}
//
//
//-(MKNetworkOperation*)getEventsWithForm:(VWWGetEventsForm*)form
//                        completionBlock:(VWWRESTEngineEventsBlock)completionBlock
//                             errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
//    @autoreleasepool {
//    
//    return [self httpGetEndpoint:self.service.serviceEventsURI
//                  jsonDictionary:[form httpParametersDictionary]
//                 completionBlock:^(id responseJSON){
//                     NSArray *events;
//                    VWWPagination *page;
//                     [VWWRESTParser parseJSON:responseJSON events:&events page:&page];
//                     completionBlock(events);
//                 }
//                      errorBlock:^(NSError *error, id responseJSON){
//                          errorBlock(error);
//                      }];
//    }
//}
//
-(MKNetworkOperation*)getEventSearchWithForm:(VWWGetEventSearchForm*)form
                             completionBlock:(VWWRESTEngineEventsBlock)completionBlock
                                  errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
    return [self httpGetEndpoint:self.service.serviceEventSearchURI
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id responseJSON){
                     NSLog(@"responseJSON: %@", responseJSON);
                     VWWError *error;
                     VWWEvents *events;
                     [VWWRESTParser parseJSON:responseJSON events:&events error:&error];
                     completionBlock(events);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error);
                      }];
    }
}

@end
