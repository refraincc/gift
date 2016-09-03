//
//  UserGiftModel.h
//  LiveHeader
//
//  Created by user on 16/7/26.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserGiftModel : NSObject

@property (nonatomic, copy)NSString *userId;

@property (nonatomic, copy)NSString *giftId;

@property (assign, nonatomic)BOOL isShow;

@property (assign, nonatomic)NSInteger showCount;

@property (assign, nonatomic)BOOL isLocationUser;



@end
