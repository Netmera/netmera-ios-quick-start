//
//  IneoEncryptor.m
//  iNeo
//
//  Created by inomera on 27.03.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

#import "IneoEncryptor.h"

@implementation IneoEncryptor

- (NSString *)encryptValue:(NSString *)value {
  return [NSString stringWithFormat:@"***%@***", value];
}

@end
