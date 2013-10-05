//
//  VWWResultsTableViewCell.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWResultsTableViewCell.h"
#import "VWWEvent.h"
#import "UIImageView+WebCache.h"


@interface VWWResultsTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@end

@implementation VWWResultsTableViewCell

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
-(void)setEvent:(VWWEvent *)event{
    _event = event;
//    
//    self.eventTitleLabel.text = _event.title;
//    self.distanceLabel.text = _event.distance;
//    [self.logoImageView setImageWithURL:_event.logo];

}
@end
