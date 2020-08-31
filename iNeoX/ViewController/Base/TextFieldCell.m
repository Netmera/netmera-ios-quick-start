//
//  TextFieldCell.m
//  Netmera
//
//  Created by Yavuz Nuzumlali on 21/04/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if(self) {
    _textField = [[UITextField alloc] init];
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    _textField.borderStyle = UITextBorderStyleNone;
    [[self contentView] addSubview:_textField];
    [[self contentView] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tf]|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"tf" : _textField}]];
    [[self contentView] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tf]-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"tf" : _textField}]];
  }
  return self;
}

@end
