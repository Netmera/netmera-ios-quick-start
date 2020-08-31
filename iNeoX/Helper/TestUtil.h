//
//  TestUtil.h
//  Netmera
//
//  Created by Yavuz Nuzumlali on 12/01/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestUtil : NSObject

+ (NSString *)loremTextWithLength:(NSUInteger)length;
+ (NSString *)randomLoremText;
+ (NSString *)randomString;
+ (NSNumber *)randomNumber;

@end
