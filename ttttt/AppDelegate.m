//
//  AppDelegate.m
//  ttttt
//
//  Created by Tamer Alaa on 9/16/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"
#import "Flurry.h"
#import "AddProductDetailViewController.h"


@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
        
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    //[navigationController.navigationBar setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsDefault];
    //navigationController.navigationBar.tintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueleather.png"]];
    navigationController.navigationBar.tintColor = [UIColor colorWithRed:48.0f/255.0f green:74.0f/255.0f blue:147.0f/255.0f alpha:1];
    TestViewController *controller = (TestViewController *)navigationController.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
    /*
    //The SideBar
    NSMutableArray *vcs = [NSMutableArray array];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:red];
    AddProductDetailViewController *edit
    NSDictionary *view = [NSDictionary dictionaryWithObjectsAndKeys:nav, @"vc", [NSString stringWithFormat:@"Red %i", i], @"title", nil];
    [vcs addObject:view];
    SHSidebarController *sidebar = [[SHSidebarController alloc] initWithArrayOfVC:vcs];
   */

    /*
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            //UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
            //UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
            //splitViewController.delegate = (id)navigationController.topViewController;
            
            UINavigationController *masterNavigationController = splitViewController.viewControllers[0];
            TestViewController *controller = (TestViewController *)masterNavigationController.topViewController;
            controller.managedObjectContext = self.managedObjectContext;
        } else {
            UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
            TestViewController *controller = (TestViewController *)navigationController.topViewController;
            controller.managedObjectContext = self.managedObjectContext;
        }
*/
    //How to Open Internal Catalogues
    
    /*
    NSURL *url = (NSURL *)[launchOptions valueForKey:UIApplicationLaunchOptionsURLKey];
    if (url != nil && [url isFileURL]) {
        [controller handleOpenURL:url];
    }
     */
    //Test flight 
    //[TestFlight takeOff:@"9ef781d3801dde3e80803c4cd007dc88_MTE3NzY5MjAxMi0wOC0wNCAxNTo1OTo1Ny4zNjg5MjU"];
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [Flurry startSession:@"S4R4TRC7HXCKJYNGNP8Z"];
    [Flurry logPageView];
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    CLLocation *location = locationManager.location;
    [Flurry setLatitude:location.coordinate.latitude
              longitude:location.coordinate.longitude
     horizontalAccuracy:location.horizontalAccuracy
       verticalAccuracy:location.verticalAccuracy];
    return YES;
}

void uncaughtExceptionHandler(NSException *exception) {
    [Flurry logError:@"Uncaught" message:@"Crash!" exception:exception];
}

//How to Open Internal Catalogues
-(BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    TestViewController *controller = (TestViewController *)navigationController.topViewController;
    
    if (url != nil && [url isFileURL]) {
        [controller handleOpenURL:url];
    }
    return YES;
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.

- (NSManagedObjectContext *)managedObjectContext
{
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

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ttttt" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ttttt.sqlite"];
    
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


/*
#pragma ICloud Part 

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if((_persistentStoreCoordinator != nil)) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    NSPersistentStoreCoordinator *psc = _persistentStoreCoordinator;
    
    // Set up iCloud in another thread:
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // ** Note: if you adapt this code for your own use, you MUST change this variable:
        NSString *iCloudEnabledAppID = @"6VJ733SKX8.com.springmoon.Shoplog";
        
        // ** Note: if you adapt this code for your own use, you should change this variable:
        NSString *dataFileName = @"ttttt.sqlite";
        
        // ** Note: For basic usage you shouldn't need to change anything else
        
        NSString *iCloudDataDirectoryName = @"Data.nosync";
        NSString *iCloudLogsDirectoryName = @"Logs";
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *localStore = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:dataFileName];
        NSURL *iCloud = [fileManager URLForUbiquityContainerIdentifier:nil];
        
        if (iCloud) {
            
            NSLog(@"iCloud is working");
            
            NSURL *iCloudLogsPath = [NSURL fileURLWithPath:[[iCloud path] stringByAppendingPathComponent:iCloudLogsDirectoryName]];
            
            NSLog(@"iCloudEnabledAppID = %@",iCloudEnabledAppID);
            NSLog(@"dataFileName = %@", dataFileName);
            NSLog(@"iCloudDataDirectoryName = %@", iCloudDataDirectoryName);
            NSLog(@"iCloudLogsDirectoryName = %@", iCloudLogsDirectoryName);
            NSLog(@"iCloud = %@", iCloud);
            NSLog(@"iCloudLogsPath = %@", iCloudLogsPath);
            
            if([fileManager fileExistsAtPath:[[iCloud path] stringByAppendingPathComponent:iCloudDataDirectoryName]] == NO) {
                NSError *fileSystemError;
                [fileManager createDirectoryAtPath:[[iCloud path] stringByAppendingPathComponent:iCloudDataDirectoryName]
                       withIntermediateDirectories:YES
                                        attributes:nil
                                             error:&fileSystemError];
                if(fileSystemError != nil) {
                    NSLog(@"Error creating database directory %@", fileSystemError);
                }
            }
            
            NSString *iCloudData = [[[iCloud path]
                                     stringByAppendingPathComponent:iCloudDataDirectoryName]
                                    stringByAppendingPathComponent:dataFileName];
            
            NSLog(@"iCloudData = %@", iCloudData);
            
            NSMutableDictionary *options = [NSMutableDictionary dictionary];
            [options setObject:[NSNumber numberWithBool:YES] forKey:NSMigratePersistentStoresAutomaticallyOption];
            [options setObject:[NSNumber numberWithBool:YES] forKey:NSInferMappingModelAutomaticallyOption];
            [options setObject:iCloudEnabledAppID            forKey:NSPersistentStoreUbiquitousContentNameKey];
            [options setObject:iCloudLogsPath                forKey:NSPersistentStoreUbiquitousContentURLKey];
            
            [psc lock];
            
            [psc addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:[NSURL fileURLWithPath:iCloudData]
                                    options:options
                                      error:nil];
            
            [psc unlock];
        }
        else {
            
            NSLog(@"iCloud is NOT working - using a local store");
            NSMutableDictionary *options = [NSMutableDictionary dictionary];
            [options setObject:[NSNumber numberWithBool:YES] forKey:NSMigratePersistentStoresAutomaticallyOption];
            [options setObject:[NSNumber numberWithBool:YES] forKey:NSInferMappingModelAutomaticallyOption];
            
            [psc lock];
            
            [psc addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:localStore
                                    options:options
                                      error:nil];
            [psc unlock];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SomethingChanged" object:self userInfo:nil];
        });
    });
    
    return _persistentStoreCoordinator;
}
- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        NSManagedObjectContext* moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        [moc performBlockAndWait:^{
            [moc setPersistentStoreCoordinator: coordinator];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mergeChangesFrom_iCloud:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:coordinator];
        }];
        _managedObjectContext = moc;
    }
    
    return _managedObjectContext;
}

- (void)mergeChangesFrom_iCloud:(NSNotification *)notification {
    
	NSLog(@"Merging in changes from iCloud...");
    
    NSManagedObjectContext* moc = [self managedObjectContext];
    
    [moc performBlock:^{
        
        [moc mergeChangesFromContextDidSaveNotification:notification];
        
        NSNotification* refreshNotification = [NSNotification notificationWithName:@"SomethingChanged"
                                                                            object:self
                                                                          userInfo:[notification userInfo]];
        
        [[NSNotificationCenter defaultCenter] postNotification:refreshNotification];
    }];
}
 */
#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
