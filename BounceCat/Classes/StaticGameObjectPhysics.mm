//
//  StaticGameObject.m
//  BounceCat
//
//  Created by Ivan on 2/19/13.
//
//

#import "StaticGameObjectPhysics.h"

@implementation StaticGameObjectPhysics

@synthesize staticSpriteFixture;
@synthesize staticSpriteBody;

- (id) initWithWorld:(b2World*)instanceWorld levelLayerInstance:(CCLayer*)levelLayer spriteName:(NSString*)spriteFileName atPosition:(b2Vec2)spritePosition isSensor:(bool)isSensor
{
    if (self = [super init]) {
        
        staticSpriteOnMap = [CCSprite spriteWithFile:spriteFileName];
        staticSpriteOnMap.position = ccp(spritePosition.x, spritePosition.y);
        [levelLayer addChild:staticSpriteOnMap];
        
        staticSpriteWorld = instanceWorld;
        // Create paddle body
        staticBodyDef.type = b2_staticBody;
        staticBodyDef.position.Set(spritePosition.x / PTM_RATIO,
                                   spritePosition.y / PTM_RATIO);
        staticBodyDef.userData = (__bridge void*)staticSpriteOnMap;
        staticSpriteBody = staticSpriteWorld->CreateBody(&staticBodyDef);
        
        // Create paddle shape
        b2PolygonShape staticBodyShape;
        staticBodyShape.SetAsBox(staticSpriteOnMap.contentSize.width / PTM_RATIO / 2,
                                 staticSpriteOnMap.contentSize.height / PTM_RATIO / 2);
        
        // Create shape definition and add to body
        b2FixtureDef staticObjectFixtureDef;
        staticObjectFixtureDef.shape = &staticBodyShape;
        staticObjectFixtureDef.density = 0.0f;
        staticObjectFixtureDef.friction = 0.4f;
        staticObjectFixtureDef.restitution = 0.1f;
        
        staticObjectFixtureDef.isSensor = isSensor;
        
        staticSpriteFixture = staticSpriteBody->CreateFixture(&staticObjectFixtureDef);
    }
    
    return self;
}

- (void) dealloc
{
    staticBodyDef.userData = NULL;
}


@end
