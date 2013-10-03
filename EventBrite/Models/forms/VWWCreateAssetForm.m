//
// VWWCreateAssetForm.m
//  SmileModel
//
//  Created by Aleksandar Tosovic on 4/24/12.
//  Copyright (c) 2012 Webshots. All rights reserved.
//

#import "SMCreateAssetForm.h"

@implementationVWWCreateAssetForm


- (NSDictionary *)httpParametersDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    [self setObject:self.uuid forKey:@"uuid" inDictionary:dictionary];
    [self setObject:self.externalID forKey:@"external_id" inDictionary:dictionary];
    [self setObject:self.sourceUUID forKey:@"source_uuid" inDictionary:dictionary];
    [self setObject:self.originalFilename forKey:@"original_filename" inDictionary:dictionary];
    [self setObject:self.shortURL forKey:@"short_url" inDictionary:dictionary];
    [self setObject:self.thumbURL forKey:@"thumb_url" inDictionary:dictionary];
    [self setObject:self.title forKey:@"title" inDictionary:dictionary];
    [self setObject:self.URL forKey:@"url" inDictionary:dictionary];
    [self setObject:self.md5 forKey:@"md5" inDictionary:dictionary];
    [self setObject:self.photoTakenAt forKey:@"photo_taken_at" inDictionary:dictionary];
    [self setBool:self.isActive forKey:@"is_active" inDictionary:dictionary];
    [self setObject:self.isPrivate forKey:@"is_private" inDictionary:dictionary];
    [self setBool:self.isFavorite forKey:@"is_favorite" inDictionary:dictionary];
    [self setObject:self.eventUUID forKey:@"event_uuid" inDictionary:dictionary];

    dictionary[@"height"] = [NSString stringWithFormat:@"%d", (int)self.height];
    dictionary[@"size_in_kb"] = [NSString stringWithFormat:@"%d", self.sizeInKB];
    dictionary[@"width"] = [NSString stringWithFormat:@"%d", (int)self.width];

    return dictionary;
}

@end
