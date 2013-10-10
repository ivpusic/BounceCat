//
//  LevelJSONInfoHelper.m
//  BounceCat
//
//  Created by Ivan on 3/13/13.
//
//

#import "LevelInfoJSONHelper.h"

@implementation LevelInfoJSONHelper

/**
 Method for loading Level information from JSON file
 @param jsonFileName File name which containts info about some LevelGroup info
 @param levelName Name of level for which we will load info
 @returns Dict with key/value pairs. They contain level informations
 */
- (NSDictionary*)getGroupInfoFromFile:(NSString*)jsonFileName forLevel:(NSString*)levelName
{
    NSDictionary *keys;
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonFileName
                                                         ofType:@"json"];
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    if (jsonData) {
        
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"ERROR WITH PARSING JSON IN FILE LevelInfoJSONHelper. Error is: %@", [error localizedDescription]);
            
            // Handle Error and return
            return nil;
            
        }
        keys = [jsonObjects objectForKey:levelName];
        
    } else {
        NSLog(@"ERROR WITH PARSING JSON IN FILE LevelInfoJSONHelper. Error is: %@", [error localizedDescription]);
    }
    
    return keys;
}

@end
