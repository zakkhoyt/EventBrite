//
//  VWWCoreData.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VWWEventsSummary.h"
#import "VWWEventOrganizer.h"
#import "VWWEventTicket.h"
#import "VWWEventVenue.h"
#import "VWWEventsSearch.h"
@interface VWWCoreData : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(VWWCoreData*)sharedInstance;
- (void) deleteAllObjects: (NSString *) entityDescription;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
