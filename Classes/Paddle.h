//
//  Paddle.h
//  BounceCat
//
//  Created by Ivan on 2/19/13.
//
//

#import "Box2D.h"
#import "cocos2d.h"
#import "CommonClassMembers.h"
#import "GamePartsCore.h"

@interface Paddle : GamePartsCore {
    // Cocos members
    __weak CCLayer *localLevelLayer;
    
    // Box2d members
    b2World *localWorld;
    b2BodyDef paddleBodyDef;
}

@property (nonatomic, readonly) b2Body *paddleBody;
@property (nonatomic, readonly) b2Fixture *paddleFixture;
@property (nonatomic, strong) CCSprite *paddleSprite;
@property (nonatomic, assign) b2MouseJoint *paddleMouseJoint;

- (id) initWithLayer:(CCLayer *)levelLayer withWorld:(b2World*)instanceWorld withGround:(b2Body*)groundBody atPosition:(b2Vec2)position;
- (void) rotatePaddle:(b2Vec2)paddlePosition;

@end
