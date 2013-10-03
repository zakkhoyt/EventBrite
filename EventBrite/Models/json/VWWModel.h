//
//  SmileModel.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//


#import "NSDictionary+TypedGetters.h"

typedef void (^Completion)(NSError *error);
typedef void (^ArrayCompletion)(NSArray *data, NSError *error);


@interface VWWModel : NSObject

- (NSString *)descriptionForKeys:(NSString *)first, ...;

@end
