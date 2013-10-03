//
//  SMPagination.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWModel.h"

@interface VWWPagination : VWWModel

@property (assign, nonatomic) NSInteger pageNumber;
@property (assign, nonatomic) NSInteger perPage;
@property (assign, nonatomic) NSInteger totalCount;
@property (readonly, nonatomic) NSInteger totalPagesCount;

+ (id)paginationWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
