//
//  LevelMathHelper.h
//  BounceCat
//
//  Created by Ivan on 3/23/13.
//
//

#import "Box2D.h"
#include <stdlib.h>

#define ARC4RANDOM_MAX 0x100000000

@interface LevelMathHelper : NSObject

+ (b2Vec2) calculateSymetricVectorOf:(b2Vec2)sourceVector middleVector:(b2Vec2)middleVector;
+ (double) calculateRandomDoubleBetweenMin:(double)minRange Max:(double)maxRange;

@end
