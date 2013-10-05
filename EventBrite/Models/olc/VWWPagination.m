//
//  VWWPagination.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWPagination.h"

#import "NSDictionary+TypedGetters.h"

@implementation VWWPagination

+ (id)paginationWithDictionary:(NSDictionary *)dictionary {
    return [[VWWPagination alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (dictionary == nil) {
        return nil;
    }

    self = [super init];
    if (!self) return self;

    _pageNumber = [dictionary intForKey:@"page_number"];
    _perPage = [dictionary intForKey:@"per_page"];
    _totalCount = [dictionary intForKey:@"total_count"];

    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    VWWPagination *copy = [[VWWPagination allocWithZone:zone] init];

    copy.pageNumber = self.pageNumber;
    copy.perPage = self.perPage;
    copy.totalCount = self.totalCount;

    return copy;
}

- (NSString *)description {
    return [self descriptionForKeys:@"pageNumber", @"perPage", @"totalCount", nil];
}

- (NSInteger)totalPagesCount {
    NSInteger addition = self.totalCount % self.perPage > 0;
    return self.totalCount / self.perPage + addition;
}

@end
