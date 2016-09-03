//
//  ViewController.m
//  LiveHeader
//
//  Created by user on 16/7/26.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ViewController.h"
#import "ZCGiftsShowView.h"
#import "ZCLiveHeaderView.h"
#import "ZCGiftsView.h"
#import "UserGiftModel.h"
#import "ZCUserInformationView.h"
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

#define ScreenSize [UIScreen mainScreen].bounds.size

@interface ViewController ()<ZCGiftsViewDelegate, ZCLiveHeaderViewDelegate>

@property (nonatomic, strong)ZCGiftsShowView *giftShowView;

@property (nonatomic, strong)ZCLiveHeaderView *liveHeaderView;


@property (nonatomic, strong)ZCGiftsView *giftsView;

@property (nonatomic, strong)ZCUserInformationView *userInformationView;

@end

@implementation ViewController

- (ZCUserInformationView *)userInformationView{
    if (!_userInformationView) {
        _userInformationView = [ZCUserInformationView userInformationView];
    }
    return _userInformationView;
}

- (ZCGiftsView *)giftsView{
    if (!_giftsView) {
        _giftsView = [ZCGiftsView giftsView];
        _giftsView.frame = CGRectMake(0, ScreenSize.height, ScreenSize.width, 237);
        [self.view addSubview:_giftsView];
        _giftsView.delegate = self;
        [_giftsView setGifts:@[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1]];
    }
    return _giftsView;
}

- (void)giftsViewDidSelectPresentWithGiftModel:(id)model{
    NSLog(@"112");
}

- (IBAction)click3:(id)sender {
    
    UserGiftModel *model = [[UserGiftModel alloc]init];
    model.giftId = @"3";
    model.userId = @"left";
    model.showCount = 2;
    [self.giftShowView addGiftWithModel:model];
    
}
- (IBAction)click2:(id)sender {
    
    UserGiftModel *model = [[UserGiftModel alloc]init];
    model.giftId = @"2";
    model.userId = @"right";
    model.showCount = 4;
    [self.giftShowView addGiftWithModel:model];
    
    
}

- (IBAction)clicl:(UIButton *)sender {
    
//    !sender.isSelected ? [self.giftShowView show] : [self.giftShowView close];
//    
//    sender.selected = !sender.isSelected;
    
    
//    [self.giftsView show];
//    self.coverButton.hidden = NO;
    
//    
    UserGiftModel *model = [[UserGiftModel alloc]init];
    model.giftId = @"0";
    model.userId = @"hi";
    model.isLocationUser = YES;
    
    model.showCount = 1;
    [self.giftShowView addGiftWithModel:model];

    
    
//    [self.userInformationView showWithUserModel:nil];
    
    
}

- (void)liveHeaderViewDidSelectSpectatorWithSpectatorInfo:(NSDictionary *)spectatorInfoct{
    NSLog(@"liveHeaderViewDidSelectSpectatorWithSpectatorInfo");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    
    
    ZCGiftsShowView *giftShowView = [[ZCGiftsShowView alloc]initWithFrame:CGRectMake(-self.view.bounds.size.width, 300, self.view.bounds.size.width, 110)];
    
    
    [self.giftShowView show];
    
    [self.view addSubview:giftShowView];
    
    self.giftShowView = giftShowView;
//    [self.giftShowView show];
    
    
    ZCLiveHeaderView *liveHeaderView = [ZCLiveHeaderView liveHeaderView];
    self.liveHeaderView = liveHeaderView;
    liveHeaderView.frame = CGRectMake(0, 20, SCREEN_W, 80);
    liveHeaderView.delegate = self;
    [self.view addSubview:liveHeaderView];
    
    
    
//    NSOperation *op = [[NSOperation alloc]init];
//    op add
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1线程 %@", [NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2线程 %@", [NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3线程 %@", [NSThread currentThread]);
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"4线程 %@", [NSThread currentThread]);
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 2;
    
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    [op4 addDependency:op3];
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    
//    [queue str]
    
    
}

@end
