//
//  Duct.m
//  BounceCat
//
//  Created by Ivan on 3/9/13.
//
//

#import "Duct.h"

@implementation Duct

- (id) initWithLayer:(CCLayer *)levelLayer world:(b2World *)levelWorld atPosition:(b2Vec2)ductPosition
{
    if(self = [super init]) {
        // Duct
        ductSprite = [CCSprite spriteWithFile:@"duct.png"];
        ductSprite.position = ccp(ductPosition.x - (ductSprite.contentSize.width / 2), ductPosition.y / 2);
        [levelLayer addChild:ductSprite];
        
        //body and fixture defs - the common parts
        b2BodyDef bodyDef;
        bodyDef.type = b2_staticBody;
        bodyDef.awake = true;
        
        int num = 4;
        b2Vec2 verts[] = {
            b2Vec2(-17.8f / PTM_RATIO, 45.8f / PTM_RATIO),
            b2Vec2(-17.9f / PTM_RATIO, -53.4f / PTM_RATIO),
            b2Vec2(-16.9f / PTM_RATIO, -53.6f / PTM_RATIO),
            b2Vec2(-16.4f / PTM_RATIO, 45.1f / PTM_RATIO)
        };
        
        int num1 = 4;
        b2Vec2 verts1[] = {
            b2Vec2(15.6f / PTM_RATIO, 44.1f / PTM_RATIO),
            b2Vec2(16.1f / PTM_RATIO, -53.9f / PTM_RATIO),
            b2Vec2(17.1f / PTM_RATIO, -54.1f / PTM_RATIO),
            b2Vec2(17.1f / PTM_RATIO, 43.6f / PTM_RATIO)
        };
        
        
        //two shapes
        b2PolygonShape boxShape;
        boxShape.Set(verts, num);
        
        b2PolygonShape circleShape;
        circleShape.Set(verts1, num1);
        
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &boxShape;
        
        
        bodyDef.position.Set((ductSprite.position.x) / PTM_RATIO, (ductSprite.position.y  + ductSprite.contentSize.height / 15) / PTM_RATIO);
        fixtureDef.shape = &circleShape;
        m_bodyB = levelWorld->CreateBody( &bodyDef );
        m_bodyB->CreateFixture( &fixtureDef );
        
        bodyDef.position.Set((ductSprite.position.x) / PTM_RATIO, (ductSprite.position.y  + ductSprite.contentSize.height / 15) / PTM_RATIO);
        fixtureDef.shape = &boxShape;
        m_bodyA = levelWorld->CreateBody( &bodyDef );
        m_bodyA->CreateFixture( &fixtureDef );
    }
    return self;
}


@end
