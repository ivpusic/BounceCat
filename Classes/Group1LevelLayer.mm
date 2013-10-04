//
//  Level1Layer.m
//  BounceCat
//
//  Created by Ivan on 2/15/13.
//
//

#import "Group1LevelLayer.h"
#import "MainMenuLayer.h"

@implementation Group1LevelLayer

@synthesize starPhysics, starPhysics1, starPhysics2, barrierPhysics;
@synthesize startBoxRight;
@synthesize bottomFixture;
@synthesize paddle;
@synthesize stoneCatroon;

BOOL boxHitted;

- (id) initWithLevelOptions:(NSDictionary*)levelInfo
{
    if (self = [super init]) {
        
        /**
         Some Level properties
         */
        boxHitted = NO;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.isTouchEnabled = YES;
        
        /**
         Background image
         */
        CCSprite *backgroundLevel1 = [CCSprite spriteWithFile:[levelInfo objectForKey:@"background"]];
        backgroundLevel1.position = ccp(winSize.width / 2, winSize.height / 2);
        //[self addChild:backgroundLevel1];
        
        /**
         MainMenu button
         */
        CCMenuItem *pauseButton = [CCMenuItemImage itemWithNormalImage:@"pause.png" selectedImage:@"pause.png" target:self selector:@selector(switchToMainMenu:)];
        CCMenu *inGameMenu = [CCMenu menuWithItems:pauseButton, nil];
        inGameMenu.position = ccp(pauseButton.contentSize.width / 2, winSize.height - pauseButton.contentSize.height / 2);
        [self addChild:inGameMenu];
        
        /**
         Creating b2world
         */
        b2Vec2 gravity = b2Vec2(0.0f, -10.0f);
        world = new b2World(gravity);
        
        /**
         Turn ON debug mode for box2d
         */
        [self setupDebugDraw];
        
        NSDictionary *stonePosition = [levelInfo objectForKey:@"stonePosition"];

        /**
         Stone
         */
        stoneCatroon = [[Stone alloc] initWithLayer:self withWorld:world atPosition:b2Vec2(winSize.width / [stonePosition[@"width"] floatValue] / PTM_RATIO, winSize.height / [[stonePosition objectForKey:@"height"] floatValue] / PTM_RATIO)];
        
        
        /**
         Create world fixtures
         */
        b2BodyDef groundBodyDef;
        groundBodyDef.position.Set(0,0);
        groundBody = world->CreateBody(&groundBodyDef);
        
        b2EdgeShape groundBox;
        b2FixtureDef groundBoxDef;
        groundBoxDef.shape = &groundBox;
        
        groundBox.Set(b2Vec2(0,0), b2Vec2(winSize.width/PTM_RATIO,0));
        bottomFixture = groundBody->CreateFixture(&groundBoxDef);
        
        groundBox.Set(b2Vec2(0,0), b2Vec2(0, winSize.height/PTM_RATIO));
        groundBody->CreateFixture(&groundBoxDef);
        groundBox.Set(b2Vec2(0, winSize.height/PTM_RATIO), b2Vec2(winSize.width/PTM_RATIO,
                                                                  winSize.height/PTM_RATIO));
        groundBody->CreateFixture(&groundBoxDef);
        groundBox.Set(b2Vec2(winSize.width/PTM_RATIO, winSize.height/PTM_RATIO),
                      b2Vec2(winSize.width/PTM_RATIO, 0));
        groundBody->CreateFixture(&groundBoxDef);
        
        /**
         Init player position and player
         */
        objectPosition = b2Vec2(winSize.width / [levelInfo[@"playerPosition"][@"width"] floatValue], winSize.height / [levelInfo[@"playerPosition"][@"height"] floatValue]);
        playerCatroon = [[PlayerCartoon alloc] initWithLayer:self world:world atPosition:objectPosition];
        
        /**
         Paddle
         */
        NSDictionary *paddlePosition = [levelInfo objectForKey:@"paddlePosition"];
        paddle = [[Paddle alloc] initWithLayer:self withWorld:world withGround:(b2Body*)groundBody atPosition:b2Vec2(winSize.width / [[paddlePosition objectForKey:@"width"] floatValue] / PTM_RATIO, winSize.height / [[paddlePosition objectForKey:@"height"] floatValue] / PTM_RATIO)];
        /**
         Duct
         */
        objectPosition = b2Vec2(winSize.width / [levelInfo[@"ductPosition"][@"width"] floatValue], winSize.height / [levelInfo[@"ductPosition"][@"height"] floatValue]);
        duct = [[Duct alloc] initWithLayer:self world:world atPosition:objectPosition];
        
        /**
         Player box
         */
        objectPosition = b2Vec2(winSize.width / [levelInfo[@"playerBoxPosition"][@"width"] floatValue], winSize.height / [levelInfo[@"playerBoxPosition"][@"height"] floatValue]);
        playerBox = [[PlayerBox alloc] initWithLayer:self withWorld:world atPosition:objectPosition];
        
        /**
         Create barriers on map
         */
        NSDictionary *barriersDict = [levelInfo objectForKey:@"stoneBarriers"];
        for (NSString *barrierKey in barriersDict) {
            NSDictionary *barrierInfoDictObject = [barriersDict objectForKey:barrierKey];
            objectPosition = b2Vec2(winSize.width / [barrierInfoDictObject[@"width"] floatValue], winSize.height / [barrierInfoDictObject[@"height"] floatValue]);
            barrierPhysics = [[StaticGameObjectPhysics alloc] initWithWorld:world levelLayerInstance:self spriteName:@"stump1.png" atPosition:objectPosition isSensor:NO];
        }
        
        NSDictionary *starsDict = [levelInfo objectForKey:@"stars"];
        for (NSString *starKey in starsDict) {
            NSDictionary *starInfoDictObject = [starsDict objectForKey:starKey];
            objectPosition = b2Vec2(winSize.width / [starInfoDictObject[@"width"] floatValue], winSize.height / [starInfoDictObject[@"height"] floatValue]);
            starPhysics = [[StaticGameObjectPhysics alloc] initWithWorld:world levelLayerInstance:self spriteName:@"star.png" atPosition:objectPosition isSensor:YES];
        }
        
        /**
         Set ContactListener for detecting colision between particular bodys
         */
        world->SetContactListener(contactListener);
        
        [self schedule:@selector(tick:)];
    }
    return self;
}

/**
 Overriding method for drawing (user for debug mode in box2d)
 */
- (void) draw
{
	[super draw];
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	kmGLPushMatrix();
	world->DrawDebugData();
	kmGLPopMatrix();
}

/**
 Method for setting options for debug mode in box2d
 */
- (void)setupDebugDraw { //SCENE4 DRAW METHOD
    debugDraw = new GLESDebugDraw(PTM_RATIO);
    world->SetDebugDraw(debugDraw);
    uint32 flags = 0;
    flags += b2Draw::e_shapeBit;
    flags += b2Draw::e_jointBit;
    //flags += b2Draw::e_centerOfMassBit;
    //flags += b2Draw::e_aabbBit;
    //flags += b2Draw::e_pairBit;
    debugDraw->SetFlags(flags);
}

- (void)dealloc {
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    
    delete world;
    world = NULL;
    
    delete debugDraw;
    
    delete contactListener;
    contactListener = NULL;
}

- (void)tick:(ccTime) dt {
    @autoreleasepool {
        world->Step(dt, 10, 10);
        for(b2Body *b = world->GetBodyList(); b; b=b->GetNext()) {
            if (b->GetUserData() != NULL) {
                CCSprite *sprite = (__bridge CCSprite *)b->GetUserData();
                sprite.position = ccp(b->GetPosition().x * PTM_RATIO,
                                      b->GetPosition().y * PTM_RATIO);
                sprite.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
            }
        }
        /**
         Paddle rotation
         */
        [paddle rotatePaddle:stoneCatroon.stoneBody->GetPosition()];
        
        /**
         We assume that we need to reset paddle opacity
         */
        bool resetPaddleOpacity = true;
        
        //check contacts
        std::vector<MyContact>::iterator pos;
        for(pos = contactListener->_contacts.begin();
            pos != contactListener->_contacts.end(); ++pos) {
            MyContact contact = *pos;
            
            /**
             if paddle is still colliding, don't reset opacity
             */
            if (contact.fixtureA == paddle.paddleFixture || contact.fixtureB == paddle.paddleFixture) {
                resetPaddleOpacity = false;
            }
            
            /**
             Ball and world botton colision
             */
            if (((contact.fixtureA == bottomFixture && contact.fixtureB == stoneCatroon.stoneFixture) ||
                 (contact.fixtureA == stoneCatroon.stoneFixture && contact.fixtureB == bottomFixture)) && boxHitted == NO) {
                playerCatroon.playerCartoonBody->ApplyLinearImpulse(b2Vec2(5, 300), playerCatroon.playerCartoonBody->GetWorldCenter());
                //playerCatroon.playerCartoonBody->ApplyAngularImpulse(1.5f);
                boxHitted = YES;
            }
            
            /**
             Collision between player and box cover
             */
            if (((contact.fixtureA == playerBox.cover.polygonSpriteFixture && contact.fixtureB == playerCatroon.playerCartoonFixture) ||
                 (contact.fixtureA == playerCatroon.playerCartoonFixture && contact.fixtureB == playerBox.cover.polygonSpriteFixture))) {
                
                // calculate random divide ratio
                double randomBoxCoverDivideRatio = [LevelMathHelper calculateRandomDoubleBetweenMin:4 Max:15];
                
                // calculate begin and end cut points
                b2Vec2 beginPoint = contact.maniFoldInfo->localPoint;
                b2Vec2 endPoint;
                
                b2Vec2 bodyLocalCenter = playerBox.cover.body->GetLocalCenter();
                
                b2Vec2 beginPointTmp = playerBox.cover.body->GetWorldPoint(beginPoint);
                b2Vec2 bodyLocalCenterTmp = playerBox.cover.body->GetWorldPoint(bodyLocalCenter);
                
                // For more realistic effect of breaking box cover
                if (beginPointTmp.x > bodyLocalCenterTmp.x)
                    endPoint = [LevelMathHelper calculateSymetricVectorOf:contact.maniFoldInfo->localPoint middleVector:bodyLocalCenter + b2Vec2(playerBox.cover.body->GetLocalCenter().x / randomBoxCoverDivideRatio, 0)];
                else
                    endPoint = [LevelMathHelper calculateSymetricVectorOf:contact.maniFoldInfo->localPoint middleVector:playerBox.cover.body->GetLocalCenter() - b2Vec2(playerBox.cover.body->GetLocalCenter().x / randomBoxCoverDivideRatio, 0)];
                
                // cut object
                [playerBox.cover splitPolygonSpriteOnLayer:self beginCutPoint:beginPoint endCutPoint:endPoint];
            }
            
            /**
             Colission between player and star
             */
            if ((contact.fixtureA == starPhysics.staticSpriteFixture && contact.fixtureB == stoneCatroon.stoneFixture) ||
                 (contact.fixtureA == stoneCatroon.stoneFixture && contact.fixtureB == starPhysics.staticSpriteFixture)) {
                bodyesToDestroy.push_back(starPhysics.staticSpriteBody);
            }
            
            if ((contact.fixtureA == starPhysics.staticSpriteFixture && contact.fixtureB == paddle.paddleFixture) ||
                (contact.fixtureA == paddle.paddleFixture && contact.fixtureB == starPhysics.staticSpriteFixture)) {
                [paddle.paddleSprite setOpacity:PADDLE_COLLIDE_OPACITY];
            }
        }
        
        
        /**
         Delete bodyes and prites which are marked for deleting
         */
        std::vector<b2Body *>::iterator posDelete;
        for(posDelete = bodyesToDestroy.begin(); posDelete != bodyesToDestroy.end(); ++posDelete) {
            
            b2Body *body = *posDelete;
            
            if (body->GetUserData() != NULL) {
                CCSprite *starSprite = (__bridge CCSprite*)body->GetUserData();
                [self removeChild:starSprite cleanup:YES];
            }
            
            if (body != NULL) {
                world->DestroyBody(body);
            }

            starPhysics = nil;
        }
        
        /**
         Set paddle opacity to full (255) if paddle isn't colliding with anything
         */
        if (resetPaddleOpacity) {
            [paddle.paddleSprite setOpacity:PADDLE_FULL_OPACITY];
        }
        
        bodyesToDestroy.clear();
        world->DrawDebugData();
    }
}

/**
 Set paddle location to point on which was user clicked
 @param touches Set of recieved touces
 */
- (void) setPaddleLocationToTouch:(NSSet *)touches {
    if (paddle.paddleMouseJoint == NULL) return;
    
    UITouch *myTouch = [touches anyObject];
    CGPoint location = [myTouch locationInView:[myTouch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    b2Vec2 locationWorld = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
    
    paddle.paddleMouseJoint->SetTarget(locationWorld);
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setPaddleLocationToTouch:touches];
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setPaddleLocationToTouch:touches];
}

-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    return;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    return;
}

- (void) switchToMainMenu: (id) sender
{
    CCScene *menu = [[MainMenuLayer alloc] scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:menu]];
}

@end






