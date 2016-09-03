//
//  ZCGiftsShowView.m
//  LiveHeader
//
//  Created by user on 16/7/26.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ZCGiftsShowView.h"
#import "ZCGIftShowView.h"
#import "UserGiftModel.h"


#define GIFTSHOWVIEW_HEIGHT 50



/*
 
 ZCGIftShowView show  0.5
 ZCGIftShowView close 0.25
 ZCGIftShowView numLabelShow 0.35

 */

@interface ZCGiftsShowView ()<ZCGIftShowViewDelegate>

@property (nonatomic, strong) ZCGIftShowView *upGiftView;

@property (nonatomic, strong) ZCGIftShowView *downGiftView;


@property (nonatomic, strong)NSMutableArray *gifts;

@property (nonatomic, strong)NSMutableArray *locationGifts;


@property (nonatomic, assign) BOOL isLocationUserUseUp;
@property (nonatomic, assign) BOOL isLocationUserUseDown;




@end

@implementation ZCGiftsShowView

- (NSMutableArray *)gifts{
    if (!_gifts) {
        _gifts = [NSMutableArray array];
    }
    return _gifts;
}
- (NSMutableArray *)locationGifts{
    if (!_locationGifts) {
        _locationGifts = [NSMutableArray array];
    }
    return _locationGifts;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self  = [super initWithFrame:frame]) {
        
        ZCGIftShowView *upGiftView = [ZCGIftShowView giftShowView];
        upGiftView.delegate = self;
        self.upGiftView = upGiftView;
        upGiftView.frame = CGRectMake(0, 0, frame.size.width, GIFTSHOWVIEW_HEIGHT);
        
        [self addSubview:upGiftView];
        
        ZCGIftShowView *downGiftView = [ZCGIftShowView giftShowView];
        downGiftView.delegate = self;
        self.downGiftView = downGiftView;
        downGiftView.frame = CGRectMake(0, GIFTSHOWVIEW_HEIGHT + 10, frame.size.width, GIFTSHOWVIEW_HEIGHT);
        [self addSubview:downGiftView];
        
    }
    return self;
}


- (void)show{
    [self.upGiftView show];
    [self.downGiftView show];
}
- (void)test{
    
    /*
     */
    
}
- (void)test2{
    /*
    [self.gifts addObject:model];
    
    
    UserGiftModel *upModel = self.upGiftView.giftModel;
    UserGiftModel *downModel = self.downGiftView.giftModel;
    
    BOOL upGiftContinuation = NO;
    BOOL downGiftContinuation = NO;
    for (UserGiftModel * giftModel in self.gifts) {
        if ([giftModel.userId isEqualToString:model.userId] && [giftModel.giftId isEqualToString:model.giftId]) {
            
            
            if ([upModel.userId isEqualToString:model.userId] && [upModel.giftId isEqualToString:model.giftId] && self.upGiftView.giftModel) {
                upGiftContinuation = YES;
            }
            if ([downModel.userId isEqualToString:model.userId] && [downModel.giftId isEqualToString:model.giftId] && self.downGiftView.giftModel) {
                downGiftContinuation = YES;
            }
        }
    }
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (UserGiftModel *giftModel in self.gifts) {
        [dict setObject:giftModel forKey:[NSString stringWithFormat:@"%@%@",giftModel.userId,giftModel.giftId]];
    }
    self.gifts = [[dict allValues] mutableCopy];
    
    if (self.gifts.count == 1 && !self.upGiftView.giftModel) {
        self.upGiftView.giftModel = self.gifts[0];
        self.upGiftView.giftModel.isShow = YES;
        [self.upGiftView show];
    }
    if (self.gifts.count >= 2 && !self.downGiftView.giftModel) {
        self.downGiftView.giftModel = self.gifts[1];
        self.downGiftView.giftModel.isShow = YES;
        [self.downGiftView show];
    }
    
    if (upGiftContinuation) {
        
        [self.upGiftView continuationNumLabelShow];
    }
    if (downGiftContinuation) {
        [self.downGiftView continuationNumLabelShow];
    }
    
    NSInteger len = 0;
    if (self.gifts.count == 1) {
        len = 1;
    }
    if (self.gifts.count >= 2) {
        len = 2;
    }
    
    
    //    NSRange range = NSMakeRange(0, len);
    
    //    self.existGifts = [[self.gifts subarrayWithRange:range] mutableCopy];
    
    
    for (UserGiftModel *gift in self.gifts) {
        
        if (![upModel.userId isEqualToString:gift.userId] && ![upModel.giftId isEqualToString:gift.giftId] && ![downModel.userId isEqualToString:gift.userId] && ![downModel.giftId isEqualToString:gift.giftId]) {
            [self.existGifts addObject:gift];
        }
    }
     
     */
    
    /*
     if (!self.gifts.count) {
     [self.gifts addObject:model];
     [self.upGiftView show];
     self.upGiftView.giftModel = model;
     //        model.isUp = YES;
     _upIsUse = YES;
     return;
     }
     BOOL isExist = YES;
     BOOL isExist2 = NO;
     BOOL upGiftContinuation = NO;
     BOOL downGiftContinuation = NO;
     for (UserGiftModel * giftModel in self.gifts) {
     if (![giftModel.userId isEqualToString:model.userId] || ![giftModel.giftId isEqualToString:model.giftId] ) {
     isExist = NO;
     }
     if ([giftModel.userId isEqualToString:model.userId] && [giftModel.giftId isEqualToString:model.giftId]) {
     giftModel.showCount++;
     isExist2 = YES;
     UserGiftModel *upModel = self.upGiftView.giftModel;
     UserGiftModel *downModel = self.downGiftView.giftModel;
     
     if ([upModel.userId isEqualToString:model.userId] && [upModel.giftId isEqualToString:model.giftId]) {
     upGiftContinuation = YES;
     }
     if ([downModel.userId isEqualToString:model.userId] && [downModel.giftId isEqualToString:model.giftId] && self.downGiftView.giftModel) {
     downGiftContinuation = YES;
     }
     }
     }
     if (upGiftContinuation) {
     
     [self.upGiftView continuationNumLabelShow];
     }
     if (downGiftContinuation) {
     [self.downGiftView continuationNumLabelShow];
     }
     if (!isExist && !isExist2){
     [self.gifts addObject:model];
     }
     if (self.gifts.count == 2) {
     [self.gifts addObject:model];
     [self.downGiftView show];
     self.downGiftView.giftModel = model;
     //        model.isUp = NO;
     _downIsUse = YES;
     }
     
     
     
     NSMutableDictionary *dict = [NSMutableDictionary dictionary];
     for (UserGiftModel *giftModel in self.gifts) {
     [dict setObject:giftModel forKey:[NSString stringWithFormat:@"%@%@",giftModel.userId,giftModel.giftId]];
     }
     self.gifts = [[dict allValues] mutableCopy]; */
}
- (void)addGiftWithModel:(UserGiftModel *)model{
    
    if (model.isLocationUser) {
        
        UserGiftModel *upModel = self.upGiftView.giftModel;
        UserGiftModel *downModel = self.downGiftView.giftModel;
        
        if (upModel && [upModel.userId isEqualToString:model.userId] && [upModel.giftId isEqualToString:model.giftId]) {
            [self.upGiftView continuationNumLabelShow];
            return;
        }
        
        if (downModel && [downModel.userId isEqualToString:model.userId] && [downModel.giftId isEqualToString:model.giftId]) {
            [self.downGiftView continuationNumLabelShow];
            return;
        }
        
        if (!self.upGiftView.isShow) {
            self.upGiftView.giftModel = model;
            [self.upGiftView show];
            self.upGiftView.isShow = YES;
            if (model.isLocationUser) {
                self.isLocationUserUseUp = YES;
            }
            return;
        }
        
        if (!self.downGiftView.isShow) {
            self.downGiftView.giftModel = model;
            [self.downGiftView show];
            self.downGiftView.isShow = YES;
            if (model.isLocationUser) {
                self.isLocationUserUseDown = YES;
            }
            return;
        }
        
        
        [self.locationGifts addObject:model];
        NSInteger showCount = 1;
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (UserGiftModel *giftModel in self.locationGifts) {
            if ([giftModel.userId isEqualToString:model.userId] && [giftModel.giftId isEqualToString:model.giftId]) {
                showCount++;
                giftModel.showCount = showCount;
            }
            [dict setObject:giftModel forKey:[NSString stringWithFormat:@"%@%@",giftModel.userId,giftModel.giftId]];
            
        }
        self.locationGifts = [[dict allValues] mutableCopy];
        
        
    }else{
        
        if (!self.upGiftView.isShow) {
            self.upGiftView.giftModel = model;
            [self.upGiftView show];
            self.upGiftView.isShow = YES;
            if (model.isLocationUser) {
                self.isLocationUserUseUp = YES;
            }
            return;
        }
        
        if (!self.downGiftView.isShow) {
            self.downGiftView.giftModel = model;
            [self.downGiftView show];
            self.downGiftView.isShow = YES;
            if (model.isLocationUser) {
                self.isLocationUserUseDown = YES;
            }
            return;
        }
        
        [self.gifts addObject:model];
        
        if (model.isLocationUser) {
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            for (UserGiftModel *giftModel in self.gifts) {
                [dict setObject:giftModel forKey:[NSString stringWithFormat:@"%@%@",giftModel.userId,giftModel.giftId]];
            }
            self.gifts = [[dict allValues] mutableCopy];
        }

    }
    
}

- (void)giftShowViewDidCloseWith:(UserGiftModel *)model giftShowView:(ZCGIftShowView *)giftShowView{
    
    
    if (self.locationGifts.count) {
        
        if (!self.upGiftView.isShow) {
            self.upGiftView.giftModel = self.locationGifts[0];
            [self.locationGifts removeObjectAtIndex:0];
            [self.upGiftView show];
            self.upGiftView.isShow = YES;
        }
        
        if (!self.downGiftView.isShow) {
            self.downGiftView.giftModel = self.locationGifts[0];
            [self.locationGifts removeObjectAtIndex:0];
            [self.downGiftView show];
            self.downGiftView.isShow = YES;
            
        }
        return;
    }else{
        
        if (!self.gifts.count) return;
        
        if (!self.upGiftView.isShow) {
            self.upGiftView.giftModel = self.gifts[0];
            [self.gifts removeObjectAtIndex:0];
            [self.upGiftView show];
            self.upGiftView.isShow = YES;
            
        }
        
        if (!self.downGiftView.isShow) {
            self.downGiftView.giftModel = self.gifts[0];
            [self.gifts removeObjectAtIndex:0];
            [self.downGiftView show];
            self.downGiftView.isShow = YES;
            
        }
        
    }
    
    
    
    
    
//    [self.gifts removeObject:model];
    
    /*
    if (giftShowView == self.upGiftView) {
        self.upGiftView.giftModel = nil;
        UserGiftModel *model = self.downGiftView.giftModel;
        UserGiftModel *newModel = nil;
        for (UserGiftModel *giftModel in self.gifts) {
            if (![model.userId isEqualToString:giftModel.userId] || ![model.giftId isEqualToString:giftModel.giftId]) {
                newModel = giftModel;
                break;
            }
        }
        if (newModel) {
            
            if (self.upGiftView.isShow && !self.downGiftView.isShow) {
                self.downGiftView.giftModel = newModel;
                [self.downGiftView show];
            }
            if (!self.upGiftView.isShow && self.downGiftView.isShow) {
                self.upGiftView.giftModel = newModel;
                [self.upGiftView show];
            }
        }
    }
    if (giftShowView == self.downGiftView){
        self.downGiftView.giftModel = nil;
        UserGiftModel *model = self.upGiftView.giftModel;
        UserGiftModel *newModel = nil;
        for (UserGiftModel *giftModel in self.gifts) {
            if (![model.userId isEqualToString:giftModel.userId] || ![model.giftId isEqualToString:giftModel.giftId]) {
                newModel = giftModel;
                break;
            }
        }
        if (newModel) {
            
            if (self.upGiftView.isShow && !self.downGiftView.isShow) {
                self.downGiftView.giftModel = newModel;
                [self.downGiftView show];
            }
            if (!self.upGiftView.isShow && self.downGiftView.isShow) {
                self.upGiftView.giftModel = newModel;
                [self.upGiftView show];
            }
            
        }
    } */
    
}
@end
