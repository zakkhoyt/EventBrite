//
//  VWWEventAnnotationView.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventAnnotationView.h"
#import "VWWEventAnnotation.h"
#import "UIImageView+WebCache.h"
#import "VWWEvent.h"
#import "VWWEventAnnotation.h"

@implementation VWWEventAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        VWWEventAnnotation *eventAnnotation = (VWWEventAnnotation*)self.annotation;
//        VWWEvent *event = eventAnnotation.event;
        
        self.image = [UIImage imageNamed:@"vww_32.png"];
    }
    
    return self;
}


@end
