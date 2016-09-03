//
//  ZCGift.h
//  ZCDemo
//
//  Created by user on 16/7/25.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCGift;

@protocol ZCGiftDelegate <NSObject>

- (void)giftDidSelectWithIdx:(NSInteger)idx;

@end



@interface ZCGift : UIView





+ (ZCGift *)gift;


@property (assign, nonatomic)BOOL isSelect;


@property (assign, nonatomic)NSInteger idx;


@property (nonatomic, weak)id<ZCGiftDelegate> delegate;




@end
