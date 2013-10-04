//
//  Stone.h
//  BounceCat
//
//  Created by Ivan on 3/9/13.
//
//

#import "Box2D.h"
#import "cocos2d.h"
#import "CommonClassMembers.h"
#import "GamePartsCore.h"

@interface Stone : GamePartsCore {
    // Cocos members
    __weak CCLayer *localLevelLayer;
    
    // Box2d members
    b2World *localWorld;
    b2BodyDef stoneBodyDef;
}

@property (nonatomic, readonly) b2Body *stoneBody;
@property (nonatomic, readonly) b2Fixture *stoneFixture;
@property (weak, nonatomic) CCSprite *stoneSprite;

- (id) initWithLayer:(CCLayer *)levelLayer withWorld:(b2World*)instanceWorld atPosition:(b2Vec2)position;

@end
