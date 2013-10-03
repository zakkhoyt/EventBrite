//
//  SmileModel.h
//  SmileModel
//
//  Created by Aleksandar Tosovic on 4/23/12.
//  Copyright (c) 2012 Webshots. All rights reserved.
//



#import "NSDictionary+TypedGetters.h"

typedef void (^Completion)(NSError *error);
typedef void (^ArrayCompletion)(NSArray *data, NSError *error);


@interfaceVWWModel : NSObject

- (NSString *)descriptionForKeys:(NSString *)first, ...;

@end
