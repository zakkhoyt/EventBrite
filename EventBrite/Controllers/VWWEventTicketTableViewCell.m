//
//  VWWEventTicketTableViewCell.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventTicketTableViewCell.h"
#import "VWWEventTicket.h"

@interface VWWEventTicketTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *displayPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityAvailableLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantitySoldLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
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
    self.displayPriceLabel.text = [NSString stringWithFormat:@"Price: %@", self.ticket.displayPrice];
    self.quantityAvailableLabel.text = [NSString stringWithFormat:@"%d available", self.ticket.quantityAvailable.integerValue];
    self.quantitySoldLabel.text = [NSString stringWithFormat:@"%d sold", self.ticket.quantitySold.integerValue];
    self.aboutLabel.text = self.ticket.about;
}

@end
