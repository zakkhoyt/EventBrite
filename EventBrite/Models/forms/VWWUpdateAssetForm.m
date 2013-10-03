//
// VWWUpdateAssetForm.m
//  Smile
//
//  Created by Aleksandar Tosovic on 5/21/12.
//  Copyright (c) 2012 DFANY. All rights reserved.
//

#import "SMUpdateAssetForm.h"

@implementationVWWUpdateAssetForm


- (NSDictionary *)httpParametersDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [self setObject:self.externalID forKey:@"external_id" inDictionary:dictionary];
    [self setObject:self.height forKey:@"height" inDictionary:dictionary];
    [self setObject:self.width forKey:@"width" inDictionary:dictionary];
    [self setObject:self.isActive forKey:@"is_active" inDictionary:dictionary];
    [self setObject:self.isPrivate forKey:@"is_private" inDictionary:dictionary];
    [self setObject:self.isFavorite forKey:@"is_favorite" inDictionary:dictionary];
    [self setObject:self.originalFilename forKey:@"original_filename" inDictionary:dictionary];
    [self setObject:self.shortURL forKey:@"short_url" inDictionary:dictionary];
    [self setObject:self.sizeInKB forKey:@"size_in_kb" inDictionary:dictionary];
    [self setObject:self.thumbURL forKey:@"thumb_url" inDictionary:dictionary];
    [self setObject:self.title forKey:@"title" inDictionary:dictionary];
    [self setObject:self.URL forKey:@"url" inDictionary:dictionary];
    [self setObject:self.uuid forKey:@"uuid" inDictionary:dictionary];
    [self setObject:self.state forKey:@"state" inDictionary:dictionary];
    [self setObject:self.location forKey:@"location" inDictionary:dictionary];
    return dictionary;
}

@end
