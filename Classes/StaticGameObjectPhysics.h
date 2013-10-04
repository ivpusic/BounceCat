//
//  StaticGameObject.h
//  BounceCat
//
//  Created by Ivan on 2/19/13.
//
//

#import "cocos2d.h"
#import "Box2D.h"
#import "CommonClassMembers.h"
#import "GamePartsCore.h"


@interface StaticGameObjectPhysics : GamePartsCore {
    CCSprite *staticSpriteOnMap;
    b2World *staticSpriteWorld;
    b2BodyDef staticBodyDef;
}

@property (nonatomic) b2Fixture *staticSpriteFixture;
@property (nonatomic) b2Body *staticSpriteBody;

- (id) initWithWorld:(b2World*)instanceWorld levelLayerInstance:(CCLayer*)levelLayer spriteName:(NSString*)spriteFileName atPosition:(b2Vec2)spritePosition isSensor:(bool)isSensor;
@end
