//
//  ZCLiveHeaderView.m
//  LiveHeader
//
//  Created by user on 16/7/26.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ZCLiveHeaderView.h"
#import "ZCSpectatorCell.h"
@interface ZCLiveHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNumLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *liveShowId;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightMoneyLabel;


@property (nonatomic, strong) UITapGestureRecognizer *nightMoneyTap;

@property (nonatomic, strong) UITapGestureRecognizer *headerImageViewTap;
@end



@implementation ZCLiveHeaderView

+ (ZCLiveHeaderView *)liveHeaderView{
    return [[NSBundle mainBundle] loadNibNamed:@"ZCLiveHeaderView" owner:nil options:nil].lastObject;
}
- (void)awakeFromNib{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZCSpectatorCell" bundle:nil] forCellWithReuseIdentifier:@"ZCSpectatorCell"];
 
    UITapGestureRecognizer *nightMoneyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nightMoneyClick)];
    self.nightMoneyTap = nightMoneyTap;
    [self.nightMoneyLabel addGestureRecognizer:nightMoneyTap];
    
    UITapGestureRecognizer *headerImageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerImageViewClick)];
    self.headerImageViewTap = headerImageViewTap;
    [self.headerImageView addGestureRecognizer:headerImageViewTap];
    
}
- (void)headerImageViewClick{
    NSLog(@"headerImageViewTap");
    if ([self.delegate respondsToSelector:@selector(liveHeaderViewDidSelectLiveUser)]) {
        [self.delegate liveHeaderViewDidSelectLiveUser];
    }
}

- (void)nightMoneyClick{
    NSLog(@"nightMoneyTap");
    if ([self.delegate respondsToSelector:@selector(liveHeaderViewDidSelectNightMoney)]) {
        [self.delegate liveHeaderViewDidSelectNightMoney];
    }
}

//添加关注按钮
- (IBAction)attention:(UIButton *)sender {
    NSLog(@"attentionClick");
    if ([self.delegate respondsToSelector:@selector(liveHeaderViewDidSelectAttention)]) {
        [self.delegate liveHeaderViewDidSelectAttention];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZCSpectatorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZCSpectatorCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"SpectatorClick");
    if ([self.delegate respondsToSelector:@selector(liveHeaderViewDidSelectSpectatorWithSpectatorInfo:)]) {
        [self.delegate liveHeaderViewDidSelectSpectatorWithSpectatorInfo:nil];
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CGFloat w = 42;
    CGFloat h = 40;
    return CGSizeMake(w, h);
}

@end
