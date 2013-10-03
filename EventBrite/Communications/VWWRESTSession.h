//
//  VWWRESTSession.h
//  VWW
//
//  Created by Zakk Hoyt on 2/20/13.
//
//

#import <Foundation/Foundation.h>



typedef enum{
    VWWRESTSessionErrorUnknown = 1,
} VWWRESTSessionErrors;

@interface VWWRESTSession : NSObject

+(VWWRESTSession*)sharedInstance;


@end
