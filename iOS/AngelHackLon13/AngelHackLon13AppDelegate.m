//
//  AngelHackLon13AppDelegate.m
//  AngelHackLon13
//
//  Created by Joshua Balfour on 26/10/2013.
//  Copyright (c) 2013 Josh Balfour. All rights reserved.
//

#import "AngelHackLon13AppDelegate.h"
#import "AngelHackLon13CollectionViewController.h"
#import "AngelHackLon13IntroViewController.h"

@implementation AngelHackLon13AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
  /*  rvc = [[UIView alloc] initWithFrame:CGRectMake(0, self.window.frame.size.height-50, self.window.frame.size.width, 50)];
    [rvc setBackgroundColor:[UIColor greenColor]];
    [self.window.rootViewController.view addSubview:rvc];

    
    
    
    temperature.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    temperature = [[UILabel alloc] initWithFrame:CGRectMake(rvc.center.x-50,-65,100,100)];
    
    temperature.layer.cornerRadius = 50;
    temperature.backgroundColor = [UIColor blueColor];
    [temperature setText:@"50°"];
    [temperature setTextColor:[UIColor whiteColor]];
    [temperature setTextAlignment:NSTextAlignmentCenter];
    [temperature setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50]];
    
    [rvc addSubview:temperature];
*/

    /*
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.window.frame.size.width, 150)];

    [title setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30]];
    [title setText:@"Yet to be Named Hack"];
    
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(150, 200)];
    aFlowLayout.sectionInset = UIEdgeInsetsMake(140, 5, 0, 5);
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    AngelHackLon13CollectionViewController *table = [[AngelHackLon13CollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];
    [table.view addSubview:title];
    [self.window setRootViewController:table];
    */
    AngelHackLon13IntroViewController *intro = [[AngelHackLon13IntroViewController alloc] init];
    
    
    
    nav = [[UINavigationController alloc] initWithRootViewController:intro];
    nav.navigationBar.hidden = YES;
    
    [self.window setRootViewController:nav];
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

@end
