//
//  GroupsLevelsCore.h
//  BounceCat
//
//  Created by Ivan on 3/25/13.
//
//

#import "cocos2d.h"
#import "Box2D.h"
#import "MyContactListener.h"
#import "CommonClassMembers.h"
#import "CommonLevelParts.h"
#import "LevelMathHelper.h"

#import "Paddle.h"
#import "Stone.h"

@interface GroupsLevelsCore : CCLayer {
    MyContactListener *contactListener;
    
    Paddle *paddleInCore;
    Stone *stoneInCore;
    
    bool paddleCollided;
    
    enum {
        PADDLE_COLLIDE_OPACITY  = 100,
        PADDLE_FULL_OPACITY     = 255
    };
    
}

@property (nonatomic) Stone *stoneCatroon;
@property (nonatomic, strong) Paddle *paddle;

- (void) resolvePaddleCollision:(b2Contact*)contact;

@end
