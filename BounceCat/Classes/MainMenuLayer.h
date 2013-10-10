//
//  MainMenuLayer.h
//  BounceCat
//
//  Created by Ivan on 2/15/13.
//
//

#import "cocos2d.h"
#import "Group1LevelScene.h"
#import "CCScrollLayerTestLayer.h"

@interface MainMenuLayer : CCLayer {
    MainMenuLayer *mainMenuLayer;
    CCScene *scene;
}

@property (nonatomic) CCScene *level1;

- (CCScene *) scene;

@end
