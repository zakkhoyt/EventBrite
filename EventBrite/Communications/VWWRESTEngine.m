//
//  VWWEngine.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWRESTEngine.h"
#import "VWWRESTParser.h"

#import "VWWUtility.h"
#import "VWWCoreData.h"
#import "VWWEventsSummary.h"

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


-(void)prepareHeaders:(MKNetworkOperation *)operation {
    // Read stored token from keychain system

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
    NSLog(@"**************** SERVER ERROR %ld from curl command: %@", (long)completedOperation.HTTPStatusCode, completedOperation.curlCommandLineString);
    if([VWWUserDefaults debugMode] == YES){
        NSString *alertText = [NSString stringWithFormat:@"JSON:\n%@\nCURL:\n%@", (NSString*)completedOperation.responseJSON, completedOperation.curlCommandLineString];
        [VWWUtility errorAlert:alertText title:[NSString stringWithFormat:@"Server code:%ld", (long)completedOperation.HTTPStatusCode]];
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

-(MKNetworkOperation*)getEventSearchWithForm:(VWWGetEventSearchForm*)form
                             completionBlock:(VWWRESTEngineEventsSearchBlock)completionBlock
                                  errorBlock:(VWWRESTEngineErrorBlock)errorBlock{
    @autoreleasepool {
    return [self httpGetEndpoint:self.service.serviceEventSearchURI
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id responseJSON){
                     VWWError *error;
                     
//                     VWWSearchResults *searchResults;
//                     [VWWRESTParser parseJSON:responseJSON
//                                         form:form
//                                searchResults:&searchResults
//                                        error:&error];
                     
                     VWWEventsSearch *eventsSearch;
                     [VWWRESTParser parseJSON:responseJSON
                                         form:form
                                 eventsSearch:&eventsSearch
                                        error:&error];
                     
                     completionBlock(eventsSearch);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error);
                      }];
    }
}

@end
