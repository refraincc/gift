//
//  ZCGiftsView.m
//  ZCDemo
//
//  Created by user on 16/7/25.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "ZCGiftsView.h"


#import "ZCGift.h"


#define ScreenSize [UIScreen mainScreen].bounds.size
#define showTime 0.25f

@interface ZCGiftsView () <UIScrollViewDelegate, ZCGiftDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//充值按钮
@property (weak, nonatomic) IBOutlet UIButton *rechargeableButton;
//连续点击按钮
@property (weak, nonatomic) IBOutlet UIButton *continuationButton;
@property (weak, nonatomic) IBOutlet UIButton *sendGiftButton;

@property (nonatomic, strong) UITapGestureRecognizer *superViewTapGesture;

@property (strong, nonatomic)NSMutableArray *giftViews;

//测试属性
@property (nonatomic, assign)NSInteger selectIdx;

@property (nonatomic, assign)BOOL isSelectGift;

@property (nonatomic, assign)CGFloat threeS;

@property (nonatomic, strong)NSTimer *timer;


@end

@implementation ZCGiftsView

- (NSMutableArray *)giftViews{
    
    
    if (!_giftViews) {
        _giftViews = [NSMutableArray array];
    }
    return _giftViews;
}

- (void)awakeFromNib{
    self.scrollView.delegate = self;
    
    self.rechargeableButton.layer.masksToBounds = YES;
    self.rechargeableButton.layer.cornerRadius = 5;
    self.rechargeableButton.layer.borderWidth = 1;
    self.rechargeableButton.layer.borderColor = [UIColor colorWithRed:241 / 255.0 green:72 / 255.0 blue:125 / 255.0 alpha:1.0].CGColor;
    self.continuationButton.hidden = YES;
    
}
- (void)setGifts:(NSArray *)gifts{
    _gifts = gifts;
    
    [self setupGiftsViewWithGifts:gifts];
    
    
}

- (void)setupGiftsViewWithGifts:(NSArray *)gifts{
    
    NSUInteger giftCount = gifts.count;
    BOOL lastSectionGifts =  giftCount % 8;
    NSUInteger section = giftCount / 8 + lastSectionGifts;
    
    self.pageControl.numberOfPages = section;
    
    
    CGFloat sectionViewX = 0;
    CGFloat sectionViewY = 0;
    CGFloat sectionViewW = self.bounds.size.width;
    CGFloat sectionViewH = self.scrollView.bounds.size.height;
    
    CGFloat giftW = self.bounds.size.width / 4;
    CGFloat giftH = 90;
    
    NSInteger giftIdx = 0;
    for (int i = 0; i < section; i++) {
        sectionViewX = ScreenSize.width * i;
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(sectionViewX, sectionViewY, sectionViewW, sectionViewH);
        view.backgroundColor = [UIColor clearColor];
        
        CGFloat giftX = 0;
        CGFloat giftY = 0;
        
        for (int k = 0; k < 2; k++) {
            for (int j = 0; j < 4 ; j++) {
               
                
                if (k == 1) {
                    giftY = 90;
                }
                
                ZCGift *gift = [ZCGift gift];
                gift.idx = giftIdx;
                giftX = j * giftW;
                gift.delegate = self;
                
                
                gift.frame = CGRectMake(giftX, giftY, giftW, giftH);
                
                [view addSubview:gift];
                
                [self.giftViews addObject:gift];
                
                giftIdx++;
                
                if (giftIdx == gifts.count) {
                    break;
                }
                
            }
        }
        
        
        [self.scrollView addSubview:view];
    }
    
    self.scrollView.contentSize = CGSizeMake(section * self.bounds.size.width, self.scrollView.bounds.size.height);
    

}

- (void)giftDidSelectWithIdx:(NSInteger)idx{
    
    
    for (int i = 0; i < self.gifts.count; i++) {
        
        ZCGift *gift =  self.giftViews[i];
        
        if (i == idx) {
            gift.isSelect = YES;
            self.selectIdx = idx;
            self.isSelectGift = YES;
        }else{
            gift.isSelect = NO;
        }
        
    }
    
    
    if (idx == 99999) {
        self.selectIdx = NO;
        self.selectIdx = idx;
    }
}

+ (ZCGiftsView *)giftsView{
    return [[NSBundle mainBundle] loadNibNamed:@"ZCGiftView" owner:nil options:nil].lastObject;
}


//充值按钮点击事件
- (IBAction)rechargeableButtonClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(giftsViewDidSelectRechargeable)]) {
        [self.delegate giftsViewDidSelectRechargeable];
    }
}
- (IBAction)continuationPresentClick:(UIButton *)sender {
    
    self.threeS = 3.0;
    
    
    if ([self.delegate respondsToSelector:@selector(giftsViewDidSelectPresentWithGiftModel:)]) {
        [self.delegate giftsViewDidSelectPresentWithGiftModel:nil];
    }
    
    
}
// 赠送按钮点击事件
- (IBAction)presentButtonClick:(UIButton *)sender {
    
    if (self.isSelectGift) {
        NSLog(@"%ld个礼物被点击了",self.selectIdx);
    }
    
    sender.hidden = YES;
    self.continuationButton.hidden = NO;
    
    
    if ([self.delegate respondsToSelector:@selector(giftsViewDidSelectPresentWithGiftModel:)]) {
        [self.delegate giftsViewDidSelectPresentWithGiftModel:nil];
    }
    
    self.threeS = 3.0;
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(time:) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
}
- (void)time:(NSTimer *)timer{
    self.threeS -= 0.1;
    
    [self.continuationButton setTitle:[NSString stringWithFormat:@"%0.1lf", self.threeS] forState:UIControlStateNormal];
    
    if (self.threeS <= 0) {
        self.continuationButton.hidden = YES;
        self.sendGiftButton.hidden = NO;
        [self.timer invalidate];
        self.timer = nil;
        
        if ([self.delegate respondsToSelector:@selector(giftsViewDidPresentCompleteWithGiftModel:)]) {
            [self.delegate giftsViewDidPresentCompleteWithGiftModel:nil];
        }
        
        
    }
    
}

- (UITapGestureRecognizer *)superViewTapGesture{
    if (!_superViewTapGesture) {
        _superViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverEvent:)];
        [self.superview addGestureRecognizer:_superViewTapGesture];
        _superViewTapGesture.enabled = NO;
    }
    return _superViewTapGesture;
}
- (void)show{
    self.superViewTapGesture.enabled = YES;
    
    _isShow = YES;
    [UIView animateWithDuration:showTime animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -self.bounds.size.height);
    }];
}

- (void)coverEvent:(UITapGestureRecognizer *)tap{
    [self close];
}


- (void)close{
    self.superViewTapGesture.enabled = NO;
    _isShow = NO;
    [UIView animateWithDuration:showTime animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger idx = scrollView.contentOffset.x / ScreenSize.width;
    self.pageControl.currentPage = idx;
}
@end
