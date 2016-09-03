//
//  ZCUserInformationView.h
//  LiveHeader
//
//  Created by user on 16/7/27.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCUserInformationView;

@protocol ZCUserInformationViewDelegate <NSObject>
//点击主页
- (void)userInformationViewDidClickHomepageWithUserModel:(id)model;
//点击回复
- (void)userInformationViewDidClickCallBackWithUserModel:(id)model;
//点击私信
- (void)userInformationViewDidClickPrivateChatWithUserModel:(id)model;
//点击关注  返回是否关注
- (BOOL)userInformationViewDidClickAttentionWithUserModel:(id)model;

@end



@interface ZCUserInformationView : UIView
+ (ZCUserInformationView *)userInformationView;

@property (nonatomic, weak)id<ZCUserInformationViewDelegate> delegate;

- (void)showWithUserModel:(id)model;
@end
