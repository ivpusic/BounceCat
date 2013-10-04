//
//  LevelJSONInfoHelper.h
//  BounceCat
//
//  Created by Ivan on 3/13/13.
//
//

#import <Foundation/Foundation.h>

@interface LevelInfoJSONHelper : NSObject

- (NSDictionary*)getGroupInfoFromFile:(NSString*)jsonFileName forLevel:(NSString*)levelName;

@end
