//
//  VWWResultsTableViewController.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWResultsTableViewController.h"
#import "VWWSession.h"
#import "VWWResultsTableViewCell.h"
#import "VWWEventDetailsViewController.h"
#import "VWWEventsSearch.h"
#import "VWWSearchResults.h"

static NSString *kSegueTableToDetails = @"segueTableToDetails";

@interface VWWResultsTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VWWSession *session;
@property (nonatomic, strong) NSArray *events;
@end

@implementation VWWResultsTableViewController

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
	self.session = [VWWSession sharedInstance];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    VWWEventsSearch *search = self.session.currentEventsSearch;
    self.events = search.searchResults.events.allObjects;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:kSegueTableToDetails]){
        VWWEventDetailsViewController *vc = segue.destinationViewController;
        vc.event = sender;
    }
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VWWResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VWWResultsTableViewCell"];
    cell.event = self.events[indexPath.row];
    return cell;
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VWWResultsTableViewCell *cell = (VWWResultsTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:kSegueTableToDetails sender:cell.event];
}



@end

