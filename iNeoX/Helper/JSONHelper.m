//
//  JSONHelper.m
//  Netmera
//
//  Created by Yavuz Nuzumlali on 27/11/15.
//  Copyright © 2015 Netmera. All rights reserved.
//

#import "JSONHelper.h"

@implementation JSONHelper

+ (NSDictionary *)dictionaryFromFile:(NSString *)fileName {
  NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
  NSData *jsonData = [NSData dataWithContentsOfFile:path];
  NSError *error = nil;
  if (jsonData) {
    return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
  }
  return nil;
}

@end
