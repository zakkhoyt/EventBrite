//
//  VWWEventDetailsViewController.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VWWEvent;

@interface VWWEventDetailsViewController : UIViewController
@property (nonatomic, strong) VWWEvent *event;
@end
