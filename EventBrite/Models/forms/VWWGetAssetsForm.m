//
// VWWGetAssetsForm.m
//  Heartstream
//
//  Created by Zakk Hoyt on 8/27/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWGetAssetsForm.h"

@implementationVWWGetAssetsForm
- (NSDictionary *)httpParametersDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [self setObject:self.page forKey:@"page" inDictionary:dictionary];
    [self setObject:self.perPage forKey:@"per_page" inDictionary:dictionary];
    [self setObject:self.uuid forKey:@"user" inDictionary:dictionary];
    return dictionary;
}

-(NSString*)description{
    
    return [NSString stringWithFormat:@"uuid: %@"
            @"page: %@"
            @"per_page: %@",
            self.uuid,
            self.page,
            self.perPage];
}

@end
