//
//  VWWHomePreviousSearchTableViewCell.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWHomePreviousSearchTableViewCell.h"
#import "VWWEventsSearch.h"
#import "VWWSearchResults.h"
#import "VWWEventsSummary.h"

@interface VWWHomePreviousSearchTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *keywordsLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsCountLabel;
@end

@implementation VWWHomePreviousSearchTableViewCell

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
#pragma mark Public methods{
-(void)setEventsSearch:(VWWEventsSearch *)eventsSearch{
    _eventsSearch = eventsSearch;
//    VWWSearchResults *results = _eventsSearch.searchResults;
//    
//    VWWEventsSummary *summary = _eventsSearch.searchResults.eventsSummary;
}

@end
