//
//  Level1Scene.h
//  BounceCat
//
//  Created by Ivan on 3/13/13.
//
//

#import "cocos2d.h"
#import "Group1LevelLayer.h"
#import "LevelInfoJSONHelper.h"

@interface Group1LevelScene : CCScene {
    CCLayer *group1LevelLayer;
    LevelInfoJSONHelper *levelInfoJSONHelper;
}

- (id) initWithLevelName:(NSString*)levelName;

@end
