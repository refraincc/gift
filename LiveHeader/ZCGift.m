//
//  ZCGift.m
//  ZCDemo
//
//  Created by user on 16/7/25.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "ZCGift.h"

#define NOTSELECTIDX 99999


@interface ZCGift ()


@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UIButton *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *expLabel;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation ZCGift

+ (ZCGift *)gift{
    return [[NSBundle mainBundle] loadNibNamed:@"ZCGift" owner:nil options:nil].lastObject;
}


- (void)awakeFromNib{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(giftClick)];
    [self addGestureRecognizer:tap];
    self.tap = tap;
}

- (void)setIsSelect:(BOOL)isSelect{
    self.selectImageView.highlighted = isSelect;
}

- (void)giftClick{
    
    NSInteger idx = self.idx;
    
    if (self.selectImageView.highlighted == YES) {
        self.selectImageView.highlighted = NO;
        idx = NOTSELECTIDX;
    }
    
    if ([self.delegate respondsToSelector:@selector(giftDidSelectWithIdx:)]) {
        [self.delegate giftDidSelectWithIdx:idx];
    }
    
}


@end
