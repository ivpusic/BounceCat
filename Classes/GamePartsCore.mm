//
//  GamePartsCore.m
//  BounceCat
//
//  Created by Ivan on 3/16/13.
//
//

#import "GamePartsCore.h"

@implementation GamePartsCore

- (id)init
{
    if (self = [super init]) {
        winSize = [[CCDirector sharedDirector] winSize];
    }
    return self;
}

@end
