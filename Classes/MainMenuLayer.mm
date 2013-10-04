//
//  MainMenuLayer.m
//  BounceCat
//
//  Created by Ivan on 2/15/13.
//
//
#import "MainMenuLayer.h"

@implementation MainMenuLayer

@synthesize level1;

- (CCScene *) scene
{
    scene = [CCScene node];
    mainMenuLayer = [MainMenuLayer node];
    
    //CCScrollLayerTestLayer *scrollLayerTest = [[CCScrollLayerTestLayer alloc] init];
    
    [scene addChild: mainMenuLayer];
    //[scene addChild: scrollLayerTest];
    
    return scene;
}

- (id) init
{
    if(self = [super init]) {
        self.isTouchEnabled = YES;
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // Set background image
        CCSprite *background = [CCSprite spriteWithFile:@"mainmenu.jpg"];
        background.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:background];
        
        CCMenuItem *newGameMenuItem = [CCMenuItemImage itemWithNormalImage:@"Icon.png" selectedImage:@"Icon.png" target:self selector:@selector(menuItemTapped:)];
        
        CCMenuItem *newGameMenuItem2 = [CCMenuItemImage itemWithNormalImage:@"Icon.png" selectedImage:@"Icon.png" target:self selector:@selector(menuItemTapped2:)];
        
        CCMenu *bounceCatMainMenu = [CCMenu menuWithItems:newGameMenuItem, newGameMenuItem2, nil];
        [bounceCatMainMenu alignItemsVertically];
        
        [self addChild:bounceCatMainMenu];
    }
    
    return self;
}

- (void) menuItemTapped: (id) sender
{
    @autoreleasepool {
        level1 = [[Group1LevelScene alloc] initWithLevelName:@"Level1"];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:level1]];
    }
}

- (void) menuItemTapped2: (id) sender
{
    @autoreleasepool {
        level1 = [[Group1LevelScene alloc] initWithLevelName:@"Level2"];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:level1]];
    }
}

- (void) dealloc
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
}


@end
