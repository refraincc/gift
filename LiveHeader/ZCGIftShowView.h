//
//  ZCGIftShowView.h
//  LiveHeader
//
//  Created by user on 16/7/26.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserGiftModel,ZCGIftShowView;

@protocol ZCGIftShowViewDelegate <NSObject>

- (void)giftShowViewDidCloseWith:(UserGiftModel *)model giftShowView:(ZCGIftShowView *)giftShowView;

@end


@interface ZCGIftShowView : UIView

@property (nonatomic, copy)NSDictionary *giftDict;

@property (nonatomic, strong)UserGiftModel *giftModel;

@property (nonatomic, weak)id<ZCGIftShowViewDelegate> delegate;

@property (assign, nonatomic)BOOL isShow;

+ (ZCGIftShowView *)giftShowView;
- (void)numLabelShow;
- (void)show;
- (void)close;
- (void)continuationNumLabelShow;

@end
