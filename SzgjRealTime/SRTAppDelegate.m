//
//  SRTAppDelegate.m
//  SzgjRealTime
//
//  Created by user on 13-4-3.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTAppDelegate.h"

#import "SRTBusNumViewController.h"

#import "SRTStationViewController.h"
#import "SRTMoreViewController.h"
#import "SRTFavoriteViewController.h"

@implementation SRTAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[[SRTBusNumViewController alloc] initWithNibName:@"SRTBusNumViewController" bundle:nil] autorelease];
    UIViewController *viewController2 = [[[SRTStationViewController alloc] initWithNibName:@"SRTStationViewController" bundle:nil] autorelease];
    UIViewController *viewController3 = [[[SRTFavoriteViewController alloc] initWithNibName:@"SRTFavoriteViewController" bundle:nil] autorelease];
    UIViewController *viewController4 = [[[SRTMoreViewController alloc] initWithNibName:@"SRTMoreViewController" bundle:nil] autorelease];    
    
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
   
    NSMutableArray *tabNavCtrlArray = [[NSMutableArray alloc] initWithCapacity:2];
    UINavigationController *tmpNavCtrl1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    //[tmpNavCtrl1 setNavigationBarHidden:TRUE];
    UINavigationController *tmpNavCtrl2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    //[tmpNavCtrl2 setNavigationBarHidden:TRUE];
    
    UINavigationController *tmpNavCtrl3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    //[tmpNavCtrl3 setNavigationBarHidden:TRUE];
    UINavigationController *tmpNavCtrl4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
    //[tmpNavCtrl4 setNavigationBarHidden:TRUE];
    [tabNavCtrlArray addObject:tmpNavCtrl1];
    [tabNavCtrlArray addObject:tmpNavCtrl2];
    [tabNavCtrlArray addObject:tmpNavCtrl3];
    [tabNavCtrlArray addObject:tmpNavCtrl4];
    self.tabBarController.viewControllers = tabNavCtrlArray;
    [tmpNavCtrl1 release];
    [tmpNavCtrl2 release];
    [tmpNavCtrl3 release];
    [tmpNavCtrl4 release];
    [tabNavCtrlArray release];


    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
