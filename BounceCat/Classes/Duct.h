//
//  Duct.h
//  BounceCat
//
//  Created by Ivan on 3/9/13.
//
//

#import "cocos2d.h"
#import "Box2D.h"
#import "CommonClassMembers.h"
#import "GamePartsCore.h"

@interface Duct : GamePartsCore {
    CCSprite *ductSprite;
    b2Body *m_bodyB;
    b2Body *m_bodyA;
}

- (id) initWithLayer:(CCLayer *)levelLayer world:(b2World *)levelWorld atPosition:(b2Vec2)ductPosition;

@end
