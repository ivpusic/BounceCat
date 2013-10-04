//
//  BoxCover.h
//  BounceCat
//
//  Created by Ivan on 3/19/13.
//
//

#import "BreakableSprite.h"

@interface BoxCover : BreakableSprite {
}

- (id) initWithLayer:(CCLayer *)levelLayer world:(b2World*)instanceWorld atPosition:(b2Vec2)startPosition;

@end
