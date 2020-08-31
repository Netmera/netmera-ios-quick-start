//
//  TestUtil.m
//  Netmera
//
//  Created by Yavuz Nuzumlali on 12/01/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import "TestUtil.h"

@implementation TestUtil

static NSString *text = @"Lorem ipsum dolor sit amet, at duis omnes scaevola usu, omittantur efficiantur quo id, sea eu inermis accusam. Ei natum dissentias mel, ei possit option sea, numquam definitionem duo ea. Falli oratio alterum no mel, modo lorem labitur sea ne, in sea atqui possit audire! Ei qui minim dictas dicunt, eam corpora scripserit ad, est disputando repudiandae ne. Te sit indoctum tincidunt, no vix doctus dolorem? Ut pro audiam mandamus, ne mnesarchum instructior usu. In quo vide pertinacia, te dicunt phaedrum constituam has. Ad est mandamus accusamus, ex simul possit accommodare usu. Qui an urbanitas expetendis mnesarchum, zril definiebas no ius, iriure pertinacia adipiscing vix te. Hinc graeco in eos, zril indoctum nam at. Dolor quaestio sed no, mei molestie erroribus corrumpit in. Vix cu ubique inermis persequeris.";

+ (NSString *)loremTextWithLength:(NSUInteger)length {
  return [text substringToIndex:length];
}

+ (NSString *)randomLoremText {
  NSUInteger length = arc4random_uniform(10) + 5;
  NSUInteger location = arc4random_uniform((int)(text.length - length));
  return [text substringWithRange:NSMakeRange(location, length)];
}

+ (NSString *)randomString {
  NSUInteger length = arc4random_uniform(10) + 5;
  char string[length + 1];
  for (int i = 0; i < length; i++) {
    string[i] = 'A' + arc4random_uniform(26);

  }
  string[length] = '\0';
  NSString *str = [NSString stringWithCString:string encoding:NSUTF8StringEncoding];
  return str;
}

+ (NSNumber *)randomNumber {
  return [NSNumber numberWithDouble:(double)(arc4random_uniform(500) + 1) / (arc4random_uniform(2) + 1)];
}

@end
