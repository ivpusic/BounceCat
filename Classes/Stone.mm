//
//  Stone.m
//  BounceCat
//
//  Created by Ivan on 3/9/13.
//
//

#import "Stone.h"


@implementation Stone

@synthesize stoneBody;
@synthesize stoneFixture;
@synthesize stoneSprite;

- (id) initWithLayer:(CCLayer *)levelLayer withWorld:(b2World*)instanceWorld atPosition:(b2Vec2)position
{
    if (self = [super init]) {
        localWorld = instanceWorld;
        localLevelLayer = levelLayer;
        
        [self createStoneSprite];
        [self createStonePhysicsWithPosition:position];
    }
    return self;
}

- (void) createStonePhysicsWithPosition:(b2Vec2)position
{
    winSize = [[CCDirector sharedDirector] winSize];
    // Create paddle body
    stoneBodyDef.type = b2_dynamicBody;
    stoneBodyDef.position = position;
    stoneBodyDef.userData = (__bridge void*)stoneSprite;
    
    stoneBody = localWorld->CreateBody(&stoneBodyDef);
    
    // Create paddle shape
    b2CircleShape stoneShape;
    stoneShape.m_radius = 10 / PTM_RATIO;
    
    // Create shape definition and add to body
    b2FixtureDef stoneFixtureDef;
    stoneFixtureDef.shape = &stoneShape;
    stoneFixtureDef.density = 2.0f;
    stoneFixtureDef.friction = 0.4f;
    stoneFixtureDef.restitution = 0.6f;
    
    stoneFixtureDef.filter.categoryBits = STONE;
    stoneFixtureDef.filter.maskBits = PADDLE | ALL;
    
    stoneFixture = stoneBody->CreateFixture(&stoneFixtureDef);
}

- (void) createStoneSprite
{
    self.stoneSprite = [CCSprite spriteWithFile:@"stone.png"];
    [localLevelLayer addChild:stoneSprite];
}

- (void) dealloc
{
    stoneBodyDef.userData = NULL;
}

@end
