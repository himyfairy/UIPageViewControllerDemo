//
//  AppDelegate.h
//  UIPageViewController
//
//  Created by 戚璐 on 2017/4/8.
//  Copyright © 2017年 戚璐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

