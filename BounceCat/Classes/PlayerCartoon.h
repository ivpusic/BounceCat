//
//  PlayerCartoon.h
//  BounceCat
//
//  Created by Ivan on 2/19/13.
//
//
#import "Box2D.h"
#import "cocos2d.h"
#import "CommonClassMembers.h"
#import "GamePartsCore.h"

@interface PlayerCartoon : GamePartsCore {
    // Cocos members

    __weak CCLayer *localLevelLayer;
    
    // Box2d members
    b2World *localWorld;
    b2BodyDef ballBodyDef;
}

@property (nonatomic) b2Body *playerCartoonBody;
@property (nonatomic, readonly) b2Fixture *playerCartoonFixture;
@property (nonatomic, strong) CCSprite *playerCartoonSprite;

- (id) initWithLayer:(CCLayer *)levelLayer world:(b2World*)instanceWorld atPosition:(b2Vec2)startPosition;
@end
