//
//  ZCGiftsView.h
//  ZCDemo
//
//  Created by user on 16/7/25.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <UIKit/UIKit.h>
#warning ZCGiftsView 固定高度237
@class ZCGiftsView;

@protocol ZCGiftsViewDelegate <NSObject>
//充值
- (void)giftsViewDidSelectRechargeable;
//赠送
- (void)giftsViewDidSelectPresentWithGiftModel:(id)model;

- (void)giftsViewDidPresentCompleteWithGiftModel:(id)model;

@end


@interface ZCGiftsView : UIView


@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, copy)NSArray *gifts;

@property (nonatomic, weak)id<ZCGiftsViewDelegate> delegate;



- (void)show;
- (void)close;


+ (ZCGiftsView *)giftsView;


@end
