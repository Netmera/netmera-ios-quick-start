//
//  JSONHelper.h
//  Netmera
//
//  Created by Yavuz Nuzumlali on 27/11/15.
//  Copyright © 2015 Netmera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONHelper : NSObject

+ (NSDictionary *)dictionaryFromFile:(NSString *)fileName;

@end
