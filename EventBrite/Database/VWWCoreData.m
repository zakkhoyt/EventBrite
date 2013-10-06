//
//  VWWCoreData.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWCoreData.h"


@interface VWWCoreData ()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) dispatch_queue_t fetchingQueue;
@end

@implementation VWWCoreData


#pragma mark Overridden methods
-(id)init{
    self = [super init];
    if(self){
        _fetchingQueue = dispatch_queue_create("com.vaporwarewolf.eventbrite.fetcher", 0);
    }
    return self;
}

#pragma mark Public methods

+(VWWCoreData*)sharedInstance{
    static VWWCoreData *instance;
    if(instance == nil){
        instance = [[VWWCoreData alloc]init];
    }
    return instance;
}


- (void)deleteAllObjects{
////    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
////    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:_managedObjectContext];
////    [fetchRequest setEntity:entity];
////    
////    NSError *error;
////    NSArray *items = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
////    
////    for (NSManagedObject *managedObject in items) {
////    	[_managedObjectContext deleteObject:managedObject];
////    	NSLog(@"%@ object deleted",entityDescription);
////    }
////    if (![_managedObjectContext save:&error]) {
////    	NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
////    }
//    
//    
//    NSArray *stores = [_persistentStoreCoordinator persistentStores];
//    
//    for(NSPersistentStore *store in stores) {
//        [_persistentStoreCoordinator removePersistentStore:store error:nil];
//        [[NSFileManager defaultManager] removeItemAtPath:store.URL.path error:nil];
//    }
//    
//    _persistentStoreCoordinator = nil;
    
    VWWCoreData *coreData = [VWWCoreData sharedInstance];
    NSManagedObjectContext *context = [coreData managedObjectContext];

    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"VWWEventsSearch" inManagedObjectContext:context];

    NSError *cdError;
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&cdError];
    
    for (NSManagedObject *product in fetchedObjects) {
        [context deleteObject:product];
    }
    
    if (![context save:&cdError]) {
        NSLog(@"Whoops, couldn't save: %@", [cdError localizedDescription]);
        NSAssert(nil, @"Could not save managed context");
    }

}



- (void)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = _managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}



- (void)getPreviousSearchesWithCompletion:(VWWArrayBlock)completion{
    dispatch_async(self.fetchingQueue, ^{
        NSError *cdError;
        VWWCoreData *coreData = [VWWCoreData sharedInstance];
        NSManagedObjectContext *context = [coreData managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        //        NSEntityDescription *entity = [NSEntityDescription
        //                                       entityForName:@"VWWSearchResults" inManagedObjectContext:context];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"VWWEventsSearch" inManagedObjectContext:context];
        
        
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&cdError];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(fetchedObjects);
        });
        
    });
}


#pragma mark Private methods


- (NSManagedObjectContext *)managedObjectContext{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"EventBrite" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"EventBrite.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}





@end
