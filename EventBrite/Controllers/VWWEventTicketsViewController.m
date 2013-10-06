//
//  VWWEventTicketsViewController.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventTicketsViewController.h"
#import "VWWEvent.h"
#import "VWWEventTicket.h"
#import "VWWEventTicketTableViewCell.h"
#import "UIColor+VWW.h"

@interface VWWEventTicketsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tickets;
@end

@implementation VWWEventTicketsViewController

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
    self.tickets = self.event.eventTickets.allObjects;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.backgroundColor = [UIColor colorFromHexString:self.event.boxBackgroundColor];
    self.view.backgroundColor = [UIColor colorFromHexString:self.event.boxBackgroundColor];
    self.tableView.separatorColor = [UIColor colorFromHexString:self.event.boxTextColor];
    self.view.backgroundColor = [UIColor colorFromHexString:self.event.boxBackgroundColor];
}
//-(void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tickets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VWWEventTicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VWWEventTicketTableViewCell"];
    cell.ticket = self.tickets[indexPath.row];
    cell.event = self.event;
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

@end
