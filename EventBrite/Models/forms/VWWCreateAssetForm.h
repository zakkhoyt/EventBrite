//
//  SMCreateAssetForm.h
//  SmileModel
//
//  Created by Aleksandar Tosovic on 4/24/12.
//  Copyright (c) 2012 Webshots. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMHTTPForm.h"

@interface SMCreateAssetForm : SMHTTPForm

@property (copy, nonatomic) NSString *uuid;
@property (copy, nonatomic) NSString *externalID;
@property (copy, nonatomic) NSString *sourceUUID;
@property (assign, nonatomic) BOOL isActive;
@property (strong, nonatomic) NSNumber *isPrivate;
@property (copy, nonatomic) NSString *originalFilename;
@property (strong, nonatomic) NSURL *shortURL;
@property (assign, nonatomic) NSInteger sizeInKB;
@property (strong, nonatomic) NSURL *thumbURL;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *URL;
@property (assign, nonatomic) float height;
@property (assign, nonatomic) float width;
@property (copy, nonatomic) NSString *md5;
@property (strong, nonatomic) NSDate *photoTakenAt;
@property (nonatomic) BOOL isFavorite;
@property (nonatomic, strong) NSString *eventUUID;
@end
