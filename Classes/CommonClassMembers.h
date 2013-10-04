//
//  CommonClassMembers.h
//  BounceCat
//
//  Created by Ivan on 3/7/13.
//
//

#define PTM_RATIO 32.0

enum colissionFilter {
    STARS =             0x0001,
    BOUNDARY =          0x0002,
    STONE =             0x0004,
    PADDLE =            0x0008,
    ALL =               0xFFFF,
};