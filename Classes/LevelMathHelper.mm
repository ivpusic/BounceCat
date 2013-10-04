//
//  LevelMathHelper.m
//  BounceCat
//
//  Created by Ivan on 3/23/13.
//
//

#import "LevelMathHelper.h"

@implementation LevelMathHelper

/**
 Method for calculating symetric vector to sourceVector, by middle middleVector
 @param sourceVector source vector
 @param middleVector middle vector
 @returns symetric vector
 */
+ (b2Vec2) calculateSymetricVectorOf:(b2Vec2)sourceVector middleVector:(b2Vec2)middleVector
{
    b2Vec2 tmp = middleVector - sourceVector;
    float x = tmp.x - (-(middleVector.x));
    float y = tmp.y - (-(middleVector.y));
    return b2Vec2(x, y);
}

/**
 Generating random number to getting ratio in whis boxBover is divided
 @param minRange minimun random generated number
 @param maxRange maximum randon generated number
 @returns double random number
 */
+ (double) calculateRandomDoubleBetweenMin:(double)minRange Max:(double)maxRange
{
    return ((double)arc4random() / ARC4RANDOM_MAX)
    * (maxRange - minRange)
    + minRange;
}

@end
