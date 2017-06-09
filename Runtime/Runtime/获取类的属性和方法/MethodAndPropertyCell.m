//
//  MethodAndPropertyCell.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "MethodAndPropertyCell.h"

@implementation MethodAndPropertyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTextLable:(UILabel *)textLable{
    _textLable = textLable;
    _textLable.text = textLable.text;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
