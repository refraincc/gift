//
//  ZCLiveHeaderView.h
//  LiveHeader
//
//  Created by user on 16/7/26.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCLiveHeaderView;

@protocol ZCLiveHeaderViewDelegate <NSObject>
//用户点击任意观众代理事件
- (void)liveHeaderViewDidSelectSpectatorWithSpectatorInfo:(NSDictionary *)spectatorInfoct;
//用户点击关注按钮事件
- (void)liveHeaderViewDidSelectAttention;
//用户点击夜币事件
- (void)liveHeaderViewDidSelectNightMoney;
//用户点主播头像事件
- (void)liveHeaderViewDidSelectLiveUser;


@end



@interface ZCLiveHeaderView : UIView

+ (ZCLiveHeaderView *)liveHeaderView;

@property (nonatomic, copy)NSArray *list;

@property (nonatomic, copy)NSDictionary *dict;

@property (nonatomic, weak)id<ZCLiveHeaderViewDelegate> delegate;

@end
