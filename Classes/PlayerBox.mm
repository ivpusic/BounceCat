//
//  PlayerBox.m
//  BounceCat
//
//  Created by Ivan on 3/7/13.
//
//

#import "PlayerBox.h"

@implementation PlayerBox

@synthesize cover;

- (id) initWithLayer:(CCLayer *)levelLayer withWorld:(b2World*)instanceWorld atPosition:(b2Vec2)playerBoxPosition
{
    if (self = [super init]) {
        classWorld = instanceWorld;
        
        //body and bodyDef
        b2BodyDef bodyDef;
        bodyDef.type = b2_staticBody;
        bodyDef.position.Set(playerBoxPosition.x / PTM_RATIO, playerBoxPosition.y / PTM_RATIO);
        boxBody = classWorld->CreateBody( &bodyDef );
        
        int numLeftSideBox = 4;
        b2Vec2 leftSideBox[] = {
            b2Vec2(-13.2f / PTM_RATIO, 19.0f / PTM_RATIO),
            b2Vec2(-13.4f / PTM_RATIO, -17.0f / PTM_RATIO),
            b2Vec2(-12.0f / PTM_RATIO, -16.9f / PTM_RATIO),
            b2Vec2(-12.1f / PTM_RATIO, 18.6f / PTM_RATIO)
        };
        
        int numBottomBox = 4;
        b2Vec2 bottomBox[] = {
            b2Vec2(-12.2f / PTM_RATIO, -17.9f / PTM_RATIO),
            b2Vec2(14.7f / PTM_RATIO, -18.0f / PTM_RATIO),
            b2Vec2(14.8f / PTM_RATIO, -17.4f / PTM_RATIO),
            b2Vec2(-11.8f / PTM_RATIO, -17.3f / PTM_RATIO)
        };
        
        int numRightSideBox = 4;
        b2Vec2 rightSideBox[] = {
            b2Vec2(31.8f / PTM_RATIO, 18.7f / PTM_RATIO),
            b2Vec2(32.0f / PTM_RATIO, -17.9f / PTM_RATIO),
            b2Vec2(32.8f / PTM_RATIO, -17.8f / PTM_RATIO),
            b2Vec2(32.5f / PTM_RATIO, 18.7f / PTM_RATIO)
        };
        
        //two shapes
        b2PolygonShape boxShape;
        
        boxShape.Set(leftSideBox, numLeftSideBox);
        fixtureDef.shape = &boxShape;
        boxBody->CreateFixture(&fixtureDef);
        
        boxShape.Set(bottomBox, numBottomBox);
        fixtureDef.shape = &boxShape;
        boxBody->CreateFixture(&fixtureDef);
        
        boxShape.Set(rightSideBox, numRightSideBox);
        fixtureDef.shape = &boxShape;
        boxBody->CreateFixture(&fixtureDef);
        
        
        /*
         * Create box cover
         */
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(playerBoxPosition.x / PTM_RATIO, playerBoxPosition.y / PTM_RATIO);
        //boxBody = classWorld->CreateBody( &bodyDef );
        
        int numBoxCover = 4;
        b2Vec2 boxCover[] = {
            b2Vec2(-28.7f / PTM_RATIO, 18.7f / PTM_RATIO),
            b2Vec2(-28.9f / PTM_RATIO, 17.6f / PTM_RATIO),
            b2Vec2(37.0f / PTM_RATIO, 17.3f / PTM_RATIO),
            b2Vec2(36.8f / PTM_RATIO, 18.7f / PTM_RATIO)
        };
        
        boxShape.Set(boxCover, numBoxCover);
        fixtureDef.density = 0.1;
        fixtureDef.friction = 0.1;
        fixtureDef.shape = &boxShape;
        //boxBody->CreateFixture(&fixtureDef);
        
        cover = [[BoxCover alloc] initWithLayer:levelLayer world:instanceWorld atPosition:playerBoxPosition];
        
    }
    
    return self;
}


@end
