//
//  ZCGIftShowView.m
//  LiveHeader
//
//  Created by user on 16/7/26.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ZCGIftShowView.h"
#import "UserGiftModel.h"
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define NUM_LABEL_TEXT_SCALE 2.5
#define NUM_LABEL_TEXT_FONT 20
@interface ZCGIftShowView ()


@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *giftImageViewLeadingConstraint;
@property (assign, nonatomic)NSInteger giftNum;
@property (assign, nonatomic)NSInteger countDownTime;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)NSTimer *numerShowTimer;
@end



@implementation ZCGIftShowView
+ (ZCGIftShowView *)giftShowView{
    return [[NSBundle mainBundle] loadNibNamed:@"ZCGIftShowView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    self.numLabel.transform = CGAffineTransformMakeScale(NUM_LABEL_TEXT_SCALE, NUM_LABEL_TEXT_SCALE);
    self.numLabel.alpha = 0.5;
    self.numLabel.hidden = YES;
    
    [self setupNumLabelTextWithNum:1];
}
- (void)setupNumLabelTextWithNum:(NSInteger )num{
    
    NSString *str = [NSString stringWithFormat:@"X%ld",num];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    
    for (int i = 0; i < str.length; i++) {
        
        // 添加表情
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        // 表情图片
        attch.image = [UIImage imageNamed:[str substringWithRange:NSMakeRange(i, 1)]];
        // 设置图片大小
        attch.bounds = CGRectMake(0, 0, 13, 17);
        
        // 创建带有图片的富文本
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        [attr appendAttributedString:string];
    }
    self.numLabel.attributedText = attr;
}


- (void)numLabelShow{
    self.countDownTime = 3;
    [self setupNumLabelTextWithNum:self.giftNum];
    self.giftNum++;
    self.numLabel.transform = CGAffineTransformMakeScale(NUM_LABEL_TEXT_SCALE, NUM_LABEL_TEXT_SCALE);
    self.numLabel.alpha = 0.5;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.numLabel.hidden = NO;
        self.numLabel.transform = CGAffineTransformIdentity;
        self.numLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
           self.numLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }completion:^(BOOL finished) {
            self.giftModel.showCount--;
        }];
    }];
}
- (void)countDown:(NSTimer *)timer{
    self.countDownTime--;
    if (self.countDownTime <= 0) {
        [self close];
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)show{
    
    self.isShow = YES;
    
    self.giftNum = 1;
    
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeTranslation(SCREEN_W, 0);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.giftImageViewLeadingConstraint.constant = 150;
            
            [self layoutIfNeeded];
            
        }completion:^(BOOL finished) {
            
            self.numerShowTimer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(numberShow:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.numerShowTimer forMode:NSRunLoopCommonModes];
            self.giftModel.showCount++;
            [self numLabelShow];
        }];
    }];
    
}
- (void)numberShow:(NSTimer *)timer{
    
    if (self.giftModel.showCount > 1) {
        
        [self numLabelShow];
    }
    
    if (self.giftModel.showCount < 1) {
        
        [timer invalidate];
        timer = nil;
    }
    
}
- (void)close{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        self.numLabel.hidden = YES;
        self.numLabel.transform = CGAffineTransformMakeScale(NUM_LABEL_TEXT_SCALE, NUM_LABEL_TEXT_SCALE);
        self.numLabel.alpha = 0.5;
        self.giftImageViewLeadingConstraint.constant = -80;
        self.giftNum = 1;
        
        [self setupNumLabelTextWithNum:self.giftNum];
        self.isShow = NO;
        self.countDownTime = 3;
        self.giftModel = nil;
        [self.numerShowTimer invalidate];
        self.numerShowTimer = nil;
        if ([self.delegate respondsToSelector:@selector(giftShowViewDidCloseWith:giftShowView:)]) {
            [self.delegate giftShowViewDidCloseWith:self.giftModel giftShowView:self];
        }
    }];
    
}
- (void)continuationNumLabelShow{
    self.giftModel.showCount++;
    
    
}
- (void)setGiftModel:(UserGiftModel *)giftModel{
    _giftModel = giftModel;
    
    self.nickNameLabel.text = giftModel.userId;
    self.countDownTime = (giftModel.showCount * 0.5) + 3;
}
@end
