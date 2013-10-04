//
//  AppDelegate.h
//  BounceCat
//
//  Created by Ivan on 2/15/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
    UIWindow *window_;
    UINavigationController *navController_;
    
    CCDirectorIOS   *__weak director_;                                                      // weak ref
}

@property (nonatomic, strong) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (weak, readonly) CCDirectorIOS *director;

@end