//
//  PlayerCartoon.m
//  BounceCat
//
//  Created by Ivan on 2/19/13.
//
//

#import "PlayerCartoon.h"

@implementation PlayerCartoon

@synthesize playerCartoonFixture;
@synthesize playerCartoonSprite;
@synthesize playerCartoonBody;

- (id) initWithLayer:(CCLayer *)levelLayer world:(b2World*)instanceWorld atPosition:(b2Vec2)startPosition
{
    if (self = [super init]) {
        localLevelLayer = levelLayer;
        localWorld = instanceWorld;
        [self createPlayerCartoonAtPosition:startPosition];
        [self createPlayerCartoonPhysicsWithPosition:startPosition];
    }
    return self;
}

- (void) createPlayerCartoonPhysicsWithPosition:(b2Vec2)position
{
    // Create ball body
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(position.x / PTM_RATIO, position.y / PTM_RATIO);
    ballBodyDef.userData = (__bridge void*)playerCartoonSprite;
    ballBodyDef.bullet = YES;
    playerCartoonBody = localWorld->CreateBody(&ballBodyDef);
    
    // Create circle shape
    b2CircleShape circle;
    circle.m_radius = 15.0 / PTM_RATIO;
    
    // Create shape definition and add to body
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &circle;
    ballShapeDef.density = 5.0f;
    ballShapeDef.friction = 0.3f;
    ballShapeDef.restitution = 0.6f;
    playerCartoonFixture = playerCartoonBody->CreateFixture(&ballShapeDef);
}

- (void) createPlayerCartoonAtPosition:(b2Vec2)startPosition
{
    // Create ball
    playerCartoonSprite = [CCSprite spriteWithFile:@"player.png"];
    [localLevelLayer addChild:playerCartoonSprite];
}

- (void) dealloc
{
    ballBodyDef.userData = NULL;
}

@end
