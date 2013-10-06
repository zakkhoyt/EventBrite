//
//  VWWEventDetailsViewController.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventDetailsViewController.h"
#import "VWWEvent.h"
#import "VWWEventVenue.h"
#import "VWWEventOrganizer.h"
#import "VWWEventTicket.h"
#import "UIColor+VWW.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

#import "VWWEventAboutViewController.h"
#import "VWWEventOrganizerViewController.h"
#import "VWWEventVenueViewController.h"
#import "VWWEventTicketsViewController.h"
#import "VWWUtility.h"


static NSString *kSegueDetailsToOrganizer = @"segueDetailsToOrganizer";
static NSString *kSegueDetailsToVenue = @"segueDetailsToVenue";
static NSString *kSegueDetailsToTickets = @"segueDetailsToTickets";
static NSString *kSegueDetailsToAbout = @"segueDetailsToAbout";

@interface VWWEventDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSMutableDictionary *tableData;
@property (nonatomic, strong) NSMutableArray *tableDataKeys;

@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@end

@implementation VWWEventDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableData = [@{}mutableCopy];
    self.tableDataKeys = [@[]mutableCopy];
    
    if(self.event.about){
        self.tableData[kEventDetailsTableViewTypeAbout] = self.event.about;
        [self.tableDataKeys addObject:kEventDetailsTableViewTypeAbout];
    }
    
    if(self.event.eventOrganizer){
        self.tableData[kEventDetailsTableViewTypeOrganizer] = self.event.eventOrganizer;
        [self.tableDataKeys addObject:kEventDetailsTableViewTypeOrganizer];
    }
    
    if(self.event.eventVenue){
        self.tableData[kEventDetailsTableViewTypeVenue] = self.event.eventVenue;
        [self.tableDataKeys addObject:kEventDetailsTableViewTypeVenue];
    }
    
    if(self.event.eventTickets){
        self.tableData[kEventDetailsTableViewTypeTickets] = self.event.eventTickets;
        [self.tableDataKeys addObject:kEventDetailsTableViewTypeTickets];
    }
    

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorFromHexString:self.event.backgroundColor];
    self.titleLabel.text = self.event.title;
    self.titleLabel.textColor = [UIColor colorFromHexString:self.event.boxTextColor];

    if(self.event.logo){
        NSURL *logoURL = [NSURL URLWithString:self.event.logo];
        [self.logoImageView setImageWithURL:logoURL];
    }

    self.startDateLabel.textColor = [UIColor colorFromHexString:self.event.boxTextColor];
    if(self.event.startDate.length){
        self.startDateLabel.text = [NSString stringWithFormat:@"When: %@", self.event.startDate];
    }
    else{
        self.startDateLabel.text = @"";
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:kSegueDetailsToAbout]){
        VWWEventAboutViewController *vc = segue.destinationViewController;
        vc.event = self.event;
    }
    else if([segue.identifier isEqualToString:kSegueDetailsToOrganizer]){
        VWWEventOrganizerViewController *vc = segue.destinationViewController;
        vc.event = self.event;
    }
    else if([segue.identifier isEqualToString:kSegueDetailsToVenue]){
        VWWEventVenueViewController *vc = segue.destinationViewController;
        vc.event = self.event;
    }
    else if([segue.identifier isEqualToString:kSegueDetailsToTickets]){
        VWWEventTicketsViewController *vc = segue.destinationViewController;
        vc.event = self.event;
    }
}



#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    cell.textLabel.text = self.tableDataKeys[indexPath.row];
    cell.textLabel.textColor = [UIColor colorFromHexString:self.event.boxTextColor];
    return cell;
}
// These two methods will help remove the extra table view cells
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}


#pragma mark IBActions
- (IBAction)shareButtonTouchUpInside:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.50];
    hud.labelText = @"Obtaining data...";

    [self.event shareEventWithViewController:self completion:^{
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    }];

}



- (IBAction)directionsButtonTouchupInside:(id)sender {
    [self.event directionsToEvent];
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if([cell.textLabel.text isEqualToString:kEventDetailsTableViewTypeAbout]){
        [self performSegueWithIdentifier:kSegueDetailsToAbout sender:self.tableDataKeys[indexPath.row]];
    }
    else if([cell.textLabel.text isEqualToString:kEventDetailsTableViewTypeOrganizer]){
        [self performSegueWithIdentifier:kSegueDetailsToOrganizer sender:self.tableDataKeys[indexPath.row]];
    }
    else if([cell.textLabel.text isEqualToString:kEventDetailsTableViewTypeVenue]){
        [self performSegueWithIdentifier:kSegueDetailsToVenue sender:self.tableDataKeys[indexPath.row]];
    }
    else if([cell.textLabel.text isEqualToString:kEventDetailsTableViewTypeTickets]){
        [self performSegueWithIdentifier:kSegueDetailsToTickets sender:self.tableDataKeys[indexPath.row]];
    }

    
//    if(indexPath.row)
}


@end
