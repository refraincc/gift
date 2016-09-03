//
//  ZCUserInformationView.m
//  LiveHeader
//
//  Created by user on 16/7/27.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ZCUserInformationView.h"

#define SCRREN_W [UIScreen mainScreen].bounds.size.width

#define SCRREN_H [UIScreen mainScreen].bounds.size.height

#define SHOW_TIME 0.25

@interface ZCUserInformationView()

@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *yebiLabel;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendNumLabel;

@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
@property (weak, nonatomic) IBOutlet UIButton *privateChatButton;
@property (weak, nonatomic) IBOutlet UIButton *callBackButton;
@property (weak, nonatomic) IBOutlet UIButton *homePageButton;




@property (nonatomic, strong)UIButton *coverButton;


@property (nonatomic, strong)id userModel;

@end;


@implementation ZCUserInformationView
+ (ZCUserInformationView *)userInformationView{
    return [[NSBundle mainBundle] loadNibNamed:@"ZCUserInformationView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [self setupButtonWithButton:self.attentionButton];
    
    [self setupButtonWithButton:self.privateChatButton];
    
    [self setupButtonWithButton:self.callBackButton];
    
    [self setupButtonWithButton:self.homePageButton];
}

- (void)setupButtonWithButton:(UIButton *)button{
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10;
    button.layer.borderColor = [UIColor blueColor].CGColor;
    button.layer.borderWidth = 1;
}

- (IBAction)exitClick:(UIButton *)sender {
    
    [self back:nil];
    
    
}

- (IBAction)homepageClick:(UIButton *)sender {
    
    NSLog(@"主页");
    
    if ([self.delegate respondsToSelector:@selector(userInformationViewDidClickHomepageWithUserModel:)]) {
        [self.delegate userInformationViewDidClickHomepageWithUserModel:nil];
    }
}

- (IBAction)callBackClick:(UIButton *)sender {
    NSLog(@"回复");
    [self back:nil];
    if ([self.delegate respondsToSelector:@selector(userInformationViewDidClickCallBackWithUserModel:)]) {
        [self.delegate userInformationViewDidClickCallBackWithUserModel:nil];
    }
}

- (IBAction)privateChatClick:(UIButton *)sender {
    NSLog(@"私信");
    if ([self.delegate respondsToSelector:@selector(userInformationViewDidClickPrivateChatWithUserModel:)]) {
        [self.delegate userInformationViewDidClickPrivateChatWithUserModel:nil];
    }
}


- (IBAction)attentionClick:(UIButton *)sender {
    NSLog(@"关注");
    if ([self.delegate respondsToSelector:@selector(userInformationViewDidClickAttentionWithUserModel:)]) {
        [self.delegate userInformationViewDidClickAttentionWithUserModel:nil];
    }
}


- (void)showWithUserModel:(id)model{
    
    self.userModel = model;
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    
    UIButton *coverButton = [[UIButton alloc]init];
    self.coverButton = coverButton;
    coverButton.frame = CGRectMake(0, 0, SCRREN_W, SCRREN_H);
    coverButton.backgroundColor = [UIColor clearColor];
    [coverButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:coverButton];
    
    
    [window addSubview:self];
    
    
    self.frame = CGRectMake(0, 0, SCRREN_W - 40, 294);
    self.center = CGPointMake(SCRREN_W / 2, SCRREN_H + 187);
    
    
    [UIView animateWithDuration:SHOW_TIME animations:^{
        
        self.center = CGPointMake(SCRREN_W / 2, SCRREN_H / 2);
    }];
}

- (void)back:(UIButton *)button{
    [UIView animateWithDuration:SHOW_TIME animations:^{
        self.center = CGPointMake(SCRREN_W / 2, SCRREN_H + 187);
    }completion:^(BOOL finished) {
        [self.coverButton removeFromSuperview];
    }];
    
}


- (void)setUserModel:(id)userModel{
    _userModel = userModel;
}

@end
