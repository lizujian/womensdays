//
//  WDAppDelegate.m
//  womensdays
//
//  Created by Ирина Завилкина on 12.04.13.
//  Copyright (c) 2013 zavilkina. All rights reserved.
//

#import "WDAppDelegate.h"

#import "WDMainViewController.h"
#import "WDDaysViewController.h"
#import "WDСhartViewController.h"
#import "WDSexViewController.h"

@implementation WDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecordHelpers setupCoreDataStack];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];

    WDMainViewController *mainViewController = [[WDMainViewController alloc] initWithNibName:@"WDMainViewController" bundle:nil];
    WDDaysViewController *daysViewController = [[WDDaysViewController alloc] initWithNibName:@"WDDaysViewController" bundle:nil];
    WDChartViewController *chartViewController = [[WDChartViewController alloc] initWithNibName:@"WDChartViewController" bundle:nil];
    WDSexViewController *sexViewController = [[WDSexViewController alloc] initWithNibName:@"WDSexViewController" bundle:nil];
    
    UINavigationController *mainNavController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    mainNavController.navigationBar.barStyle = UIBarStyleBlack;
    UINavigationController *daysNavController = [[UINavigationController alloc] initWithRootViewController:daysViewController];
    daysNavController.navigationBar.barStyle = UIBarStyleBlack;
    UINavigationController *graphsNavController = [[UINavigationController alloc] initWithRootViewController:chartViewController];
    graphsNavController.navigationBar.barStyle = UIBarStyleBlack;
    UINavigationController *sexNavController = [[UINavigationController alloc] initWithRootViewController:sexViewController];
    sexNavController.navigationBar.barStyle = UIBarStyleBlack;

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:0.906 green:0.490 blue:0.490 alpha:1.000];
    self.tabBarController.viewControllers = @[mainNavController, daysNavController, graphsNavController, sexNavController];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];

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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (BOOL)saveContext
{
    NSManagedObjectContext *context = [NSManagedObjectContext defaultContext];
    
    @try
    {
        NSError *error = nil;
    
        if ([context save:&error])
            return YES;
        else
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            
            IZAlertView *alertView = [[IZAlertView alloc] initWithTitle:NSLocalizedString(@"AlertCoreDataErrorTitle", @"")
                                                                message:error.localizedDescription];
            [alertView show];
            
            [self rollbackContext];
            
            return NO;
        }
    } @catch (NSException *exception)
    {
        
        IZAlertView *alertView = [[IZAlertView alloc] initWithTitle:NSLocalizedString(@"AlertCoreDataErrorTitle", @"")
                                                            message:exception.description];
        [alertView show];
        
        return NO;
    }

}

- (void)rollbackContext
{
    NSManagedObjectContext *context = [NSManagedObjectContext defaultContext];

    @try
    {
        [context rollback];
    } @catch (NSException *exception)
    {
        IZAlertView *alertView = [[IZAlertView alloc] initWithTitle:NSLocalizedString(@"AlertCoreDataErrorTitle", @"")
                                                            message:exception.reason];
        [alertView show];
    }
}

@end
