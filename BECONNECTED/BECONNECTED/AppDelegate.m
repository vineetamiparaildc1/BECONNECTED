//
//  AppDelegate.m
//  BECONNECTED
//
//  Created by indianic on 30/07/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import <Parse.h>
#import <UIKit/UIKit.h>
#import "NotificationsViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self.window makeKeyAndVisible];
    [NSThread sleepForTimeInterval:0.5];
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"LoginUserID"];

    if(!(savedValue==nil))
    {
        [self.window.rootViewController performSegueWithIdentifier:@"pushview" sender:self];
    }
    
    // Override point for customization after application launch.
    
    //GoogleMaps
    [GMSServices provideAPIKey:@"AIzaSyAkeYgI0hpRKY6ykfZE0lmlgJMx_ISfCBs"];
    
    //Twitter
    [Fabric with:@[TwitterKit]];
    
       [Parse setApplicationId:@"rNxKqeFz6fCWFOD90Rmfa6iWAuhV678cwT2sT81x" clientKey:@"aJpm6VWLLGTxBbtzJv43nMq74zDUuxnwF8jKDVi3"];
    
    PFACL *aACL = [PFACL ACL];
    [aACL setPublicReadAccess:YES];
    [aACL setPublicWriteAccess:YES];
    
    [PFACL setDefaultACL:aACL withAccessForCurrentUser:YES];
    
    //Facebook
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//Facebook
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}
@end
