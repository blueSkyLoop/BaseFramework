//
//  UILabel+Extend.m
//  BaseFramework
//
//  Created by Mantis-man on 16/1/16.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "UILabel+Extend.h"

@implementation UILabel (Extend)

- (void)labelWithdrawDeleteLine
{
    NSUInteger length = [self.text length];
    
    if (0 == length)
    {
        return;
    }
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, length)];
    [self setAttributedText:attri];
}

@end
