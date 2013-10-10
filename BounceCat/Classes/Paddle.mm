//
//  Paddle.m
//  BounceCat
//
//  Created by Ivan on 2/19/13.
//
//
#import "Paddle.h"

@implementation Paddle

@synthesize paddleFixture;
@synthesize paddleBody;
@synthesize paddleSprite;
@synthesize paddleMouseJoint;

- (id) initWithLayer:(CCLayer *)levelLayer withWorld:(b2World*)instanceWorld withGround:(b2Body*)groundBody atPosition:(b2Vec2)position
{
    localLevelLayer = levelLayer;
    
    if (self = [super init]) {
        localWorld = instanceWorld;
        [self createPaddleSprite];
        [self createPaddlePhysicsWithGround:groundBody andPosition:position];
    }
    return self;
}

- (void) createPaddlePhysicsWithGround:(b2Body*)groundBody andPosition:(b2Vec2)position
{
    winSize = [[CCDirector sharedDirector] winSize];
    // Create paddle body
    paddleBodyDef.type = b2_dynamicBody;
    paddleBodyDef.position.Set(winSize.width / 2 / PTM_RATIO, winSize.height / 2 / PTM_RATIO);
    paddleBodyDef.userData = (__bridge void*)paddleSprite;
    
    paddleBody = localWorld->CreateBody(&paddleBodyDef);

    // Create paddle shape
    b2PolygonShape paddleShape;
    paddleShape.SetAsBox(paddleSprite.contentSize.width / PTM_RATIO / 2, paddleSprite.contentSize.height / PTM_RATIO / 2);
    
    // Create shape definition and add to body
    b2FixtureDef paddleShapeDef;
    paddleShapeDef.shape = &paddleShape;
    paddleShapeDef.density = 2.0f;
    paddleShapeDef.friction = 0.4f;
    paddleShapeDef.restitution = 0.1f;
    
    paddleFixture = paddleBody->CreateFixture(&paddleShapeDef);
    
    b2MouseJointDef md;
    md.bodyA = groundBody;
    md.bodyB = paddleBody;
    md.target = position;
    md.collideConnected = true;
    md.maxForce = 1000.0f * paddleBody->GetMass();
    
    paddleMouseJoint = (b2MouseJoint *)localWorld->CreateJoint(&md);
    paddleBody->SetAwake(true);
}

- (void) createPaddleSprite
{
    paddleSprite = [CCSprite spriteWithFile:@"paddle.png"];
    [localLevelLayer addChild:paddleSprite];
}

/*
 * Rotate paddle to face of bunny
 */
- (void) rotatePaddle:(b2Vec2)paddlePosition
{
    b2Vec2 toTarget = paddlePosition - paddleBody->GetPosition();
    float desiredAngle = atan2f( -toTarget.x, toTarget.y );
    paddleBody->SetTransform( paddleBody->GetPosition(), desiredAngle);
}

- (void) dealloc
{
    paddleBodyDef.userData = NULL;
}


@end