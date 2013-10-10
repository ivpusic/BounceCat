//
//  Level1Layer.h
//  BounceCat
//
//  Created by Ivan on 2/15/13.
//
//

#import "cocos2d.h"
#import "Box2D.h"


#import "StaticGameObjectPhysics.h"
#import "GLES-Render.h"

#import "PolygonSprite.h"
#import "BreakableSprite.h"
#import "GroupsLevelsCore.h"


@interface Group1LevelLayer : GroupsLevelsCore
{
    // Box2d members
    b2World *world;
    b2Body *groundBody;
    b2Fixture *bottomFixture;
    b2Fixture *ballFixture;
    b2Body *ballBody;
    b2RevoluteJoint *m_joint;
    b2Body *m_bodyA;
    b2Body *m_bodyB;
    
    // User defined members
    Duct *duct;
    PlayerBox *playerBox;
    PlayerCartoon *playerCatroon;
    BreakableSprite *breakableSprite;
    
    GLESDebugDraw *debugDraw;		// strong ref
    
    b2Vec2 objectPosition;
    std::vector<b2Body *>bodyesToDestroy;
}

@property (nonatomic, strong) StaticGameObjectPhysics *starPhysics, *starPhysics1, *starPhysics2;
@property (nonatomic, strong) StaticGameObjectPhysics *startBoxRight;
@property (nonatomic, strong) StaticGameObjectPhysics *barrierPhysics;
@property (nonatomic, assign) b2Fixture *bottomFixture;

- (id) initWithLevelOptions:(NSDictionary*)levelInfo;

@end
