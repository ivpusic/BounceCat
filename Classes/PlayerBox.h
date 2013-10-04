//
//  PlayerBox.h
//  BounceCat
//
//  Created by Ivan on 3/7/13.
//
//

#import "Box2D.h"
#import "CommonClassMembers.h"
#import "GamePartsCore.h"
#import "BoxCover.h"

@interface PlayerBox : GamePartsCore {
    b2World *classWorld;
    b2Body *boxBody;
    b2FixtureDef fixtureDef;
}

@property BoxCover *cover;

- (id) initWithLayer:(CCLayer *)levelLayer withWorld:(b2World*)instanceWorld atPosition:(b2Vec2)playerBoxPosition;

@end
