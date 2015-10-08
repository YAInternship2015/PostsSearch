//
//  AppDelegate.m
//  PostesMarked
//
//  Created by Konstantin Kolontay on 9/26/15.
//  Copyright © 2015 Konstantin Kolontay. All rights reserved.
//

#import "AppDelegate.h"
#import "MagicalRecord/MagicalRecord.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#warning имя стора надо объявить константой
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"PostesMarked"];
    return YES;
}

@end
