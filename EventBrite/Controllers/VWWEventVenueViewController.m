//
//  VWWEventVenueViewController.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventVenueViewController.h"
#import "VWWEvent.h"
#import "VWWEventVenue.h"
#import "VWWEventAnnotation.h"
#import "VWWEventAnnotationView.h"
#import "VWWUtility.h"
#import "MBProgressHUD.h"

@interface VWWEventVenueViewController ()


@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation VWWEventVenueViewController

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
    
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = self.event.eventVenue.latitude.floatValue;
    mapRegion.center.longitude = self.event.eventVenue.longitude.floatValue;
    mapRegion.span.latitudeDelta = 0.01;
    mapRegion.span.longitudeDelta = 0.01;
    [self.mapView setRegion:mapRegion animated:NO];
    [self addAnnotationsForEvents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private methods

-(void)addAnnotationsForEvents{
    VWWEvent *event = self.event;
    VWWEventAnnotation *annotation = [[VWWEventAnnotation alloc] init];
    annotation.event = event;
    VWWEventVenue *venue = event.eventVenue;
    annotation.coordinate = CLLocationCoordinate2DMake(venue.latitude.floatValue, venue.longitude.floatValue);
    [self.mapView addAnnotation:annotation];
}

#pragma mark IBActions
- (IBAction)directionsButtonTouchUpInside:(id)sender {
    [self.event directionsToEvent];
}

- (IBAction)shareLocationButton:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.50];
    hud.labelText = @"Obtaining data...";

    [self.event shareEventLocationWithViewController:self completion:^{
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    }];
}

#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    NSLog(@"annotation: %@", [annotation class]);
    if([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    
    
    VWWEventAnnotationView *annotationView = [[VWWEventAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Event"];
    annotationView.canShowCallout = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"map_29"] forState:UIControlStateNormal];
    
    annotationView.rightCalloutAccessoryView = button;
    annotationView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    return annotationView;
}

@end
