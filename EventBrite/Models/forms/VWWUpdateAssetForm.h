//
// VWWUpdateAssetForm.h
//  Smile
//
//  Created by Aleksandar Tosovic on 5/21/12.
//  Copyright (c) 2012 DFANY. All rights reserved.
//

#import "SMHTTPForm.h"

@interfaceVWWUpdateAssetForm :VWWHTTPForm

@property (copy, nonatomic) NSString *externalID;
@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSNumber *width;
@property (strong, nonatomic) NSNumber *isActive;
@property (strong, nonatomic) NSNumber *isPrivate;
@property (strong, nonatomic) NSNumber *isFavorite;
@property (copy, nonatomic) NSString *originalFilename;
@property (strong, nonatomic) NSURL *shortURL;
@property (strong, nonatomic) NSNumber *sizeInKB;
@property (strong, nonatomic) NSURL *thumbURL;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *URL;
@property (copy, nonatomic) NSString *uuid;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *location;
@end
