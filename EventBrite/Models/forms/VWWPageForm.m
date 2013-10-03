//
//  VWWPageForm.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWPageForm.h"

@implementation VWWPageForm

-(id)init{
    self = [super init];
    if(self){
        _page = @(1);
        _perPage = @(kItemsPerPageMax);
    }
    return self;
}
- (NSDictionary *)httpParametersDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [self setObject:self.page forKey:@"page" inDictionary:dictionary];
    [self setObject:self.perPage forKey:@"per_page" inDictionary:dictionary];
    return dictionary;
}

@end
