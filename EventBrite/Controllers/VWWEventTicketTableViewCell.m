//
//  VWWEventTicketTableViewCell.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventTicketTableViewCell.h"
#import "VWWEventTicket.h"
#import "UIColor+VWW.h"
#import "VWWEvent.h"

@interface VWWEventTicketTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *displayPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityAvailableLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantitySoldLabel;

@property (weak, nonatomic) IBOutlet UIWebView *aboutWebView;
@end

@implementation VWWEventTicketTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark Public methods



-(void)setTicket:(VWWEventTicket *)ticket{
    _ticket = ticket;
    
    self.nameLabel.text = self.ticket.name;
    self.displayPriceLabel.text = [NSString stringWithFormat:@"Price: %@ %@", self.ticket.displayPrice, self.ticket.currency];
    if(self.ticket.quantityAvailable){
        self.quantityAvailableLabel.text = [NSString stringWithFormat:@"Available: %d", self.ticket.quantityAvailable.integerValue];
    }
    else{
        self.quantityAvailableLabel.text = @"Available: unknown";
    }

    
    if(self.ticket.quantitySold){
        self.quantitySoldLabel.text = [NSString stringWithFormat:@"Sold: %d", self.ticket.quantitySold.integerValue];
    }
    else{
        self.quantitySoldLabel.text = @"Sold: unknown";
    }
    
    if(self.ticket.about.length == 0){
        self.aboutWebView.hidden = YES;
    }
    else{
        self.aboutWebView.hidden = NO;
        [self.aboutWebView loadHTMLString:self.ticket.about baseURL:nil];
        self.aboutWebView.scrollView.showsHorizontalScrollIndicator = YES;
        self.aboutWebView.scrollView.showsVerticalScrollIndicator = YES;
    }
    
}

-(void)setEvent:(VWWEvent *)event{
    _event = event;
    
    
    self.backgroundColor = [UIColor colorFromHexString:_event.backgroundColor];

    
    for(UIView *view in self.subviews){
        if([view isKindOfClass:[UILabel class]]){
            UILabel *labelView = (UILabel*)view;

            labelView.backgroundColor = [UIColor colorFromHexString:self.event.backgroundColor];
            labelView.textColor = [UIColor colorFromHexString:self.event.boxTextColor];
        }
        else if([view isKindOfClass:[UIWebView class]]){
            UIWebView *webView = (UIWebView*)view;
            webView.backgroundColor = [UIColor colorFromHexString:self.event.backgroundColor];
        }
    }
    

//    self.titleLabel.textColor = [UIColor colorFromHexString:self.event.boxTextColor];

    
}
@end
