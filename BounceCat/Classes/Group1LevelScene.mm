//
//  Level1Scene.m
//  BounceCat
//
//  Created by Ivan on 3/13/13.
//
//

#import "Group1LevelScene.h"

@implementation Group1LevelScene


- (id) initWithLevelName:(NSString*)levelName
{
    if (self = [super init]) {
        levelInfoJSONHelper = [[LevelInfoJSONHelper alloc] init];
        group1LevelLayer = [[Group1LevelLayer alloc] initWithLevelOptions:[levelInfoJSONHelper getGroupInfoFromFile:@"Group1LevelDef" forLevel:levelName]];
        
        [self addChild:group1LevelLayer];
    }
    return self;
}

@end
