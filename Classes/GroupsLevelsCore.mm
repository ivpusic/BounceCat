//
//  GroupsLevelsCore.m
//  BounceCat
//
//  Created by Ivan on 3/25/13.
//
//

#import "GroupsLevelsCore.h"

@implementation GroupsLevelsCore

@synthesize paddle;
@synthesize stoneCatroon;

- (id) init
{
    if (self = [super init]) {
        contactListener = new MyContactListener();
        contactListener->levelLayer = self;
        
        paddleCollided = false;
    }
    
    return self;
}

- (void) resolvePaddleCollision:(b2Contact*)contact
{
    if ((contact->GetFixtureA() == self.paddle.paddleFixture && contact->GetFixtureB() != self.stoneCatroon.stoneFixture) ||
        (contact->GetFixtureA() != self.stoneCatroon.stoneFixture && contact->GetFixtureB() == self.paddle.paddleFixture)) {
        
        [self.paddle.paddleSprite setOpacity:PADDLE_COLLIDE_OPACITY];
        contact->SetEnabled(false);
    }
}

@end
