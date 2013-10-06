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

@interface VWWEventTicketsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

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
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *tickets = self.event.eventTickets.allObjects;
    NSMutableString *ticketsString = [[NSMutableString alloc]initWithString:@""];
    for(VWWEventTicket *ticket in tickets){
        [ticketsString appendFormat:@"%@\n", ticket.description];
    }
    self.infoLabel.text = ticketsString;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
