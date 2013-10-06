//
//  VWWEventTicketTableViewCell.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VWWEventTicket;
@class VWWEvent;

@interface VWWEventTicketTableViewCell : UITableViewCell
@property (nonatomic, strong) VWWEventTicket *ticket;
@property (nonatomic, strong) VWWEvent *event;
@end
