//
//  AppDelegate.h
//  BloodDonationApp
//
//  Created by digifizz on 22/07/14.
//  Copyright (c) 2014 DIZIFIZZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,retain)UIViewController *viewcontroller;
@property(nonatomic,retain)UINavigationController *navigation;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)NSMutableArray *statearray;
@property(nonatomic,retain)NSMutableDictionary *reg1Dictionary;


@end
