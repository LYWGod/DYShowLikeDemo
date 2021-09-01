//
//  LikeView.m
//  DYShowLikeDemo
//
//  Created by stcn on 2021/9/1.
//  Copyright © 2021 LYW. All rights reserved.
//

#import "LikeView.h"

// 屏幕宽高
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
// 适配比例
#define ADAPTATIONRATIO     SCREEN_WIDTH / 750.0f


// 颜色
#define ColorRGBA(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]
#define ColorRGB(r, g, b)     ColorRGBA(r, g, b, 1.0)
#define ColorGray(v)          ColorRGB(v, v, v)

@interface LikeView()

@property (nonatomic, strong) UIImageView   *likeBeforeImgView;
@property (nonatomic, strong) UIImageView   *likeAfterImgView;

@property (nonatomic, strong) UILabel       *countLabel;

@end

@implementation LikeView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.likeBeforeImgView];
        [self addSubview:self.likeAfterImgView];
        [self addSubview:self.countLabel];
        
        CGFloat imgWH = ADAPTATIONRATIO * 80.0f;
        self.likeBeforeImgView.frame = CGRectMake(0, 0, imgWH, imgWH);
        self.likeAfterImgView.frame  = CGRectMake(0, 0, imgWH, imgWH);
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint imgCenter = self.likeBeforeImgView.center;
    imgCenter.x = self.frame.size.width / 2;
    self.likeBeforeImgView.center = imgCenter;
    self.likeAfterImgView.center  = imgCenter;
    
    [self.countLabel sizeToFit];
    
    CGFloat countX = (self.frame.size.width - self.countLabel.frame.size.width) / 2;
    CGFloat countY = self.frame.size.height - self.countLabel.frame.size.height;
    self.countLabel.frame = CGRectMake(countX, countY, self.countLabel.frame.size.width, self.countLabel.frame.size.height);
}

- (void)setupLikeState:(BOOL)isLike {
    self.isLike = isLike;
    
    if (isLike) {
        self.likeAfterImgView.hidden = NO;
    }else {
        self.likeAfterImgView.hidden = YES;
    }
}

- (void)setupLikeCount:(NSString *)count {
    self.countLabel.text = count;
    
    [self layoutSubviews];
}

- (void)startAnimationWithIsLike:(BOOL)isLike {
    if (self.isLike == isLike) return;
    
    self.isLike = isLike;
    
    if (isLike) {
        CGFloat length      = 30;
        CGFloat duration    = 0.5f;
        for (NSInteger i = 0; i < 6; i++) {
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.position = self.likeBeforeImgView.center;
            layer.fillColor = ColorRGB(232, 50, 85).CGColor;

            UIBezierPath *startPath = [UIBezierPath bezierPath];
            [startPath moveToPoint:CGPointMake(-2, -length)];
            [startPath addLineToPoint:CGPointMake(2, -length)];
            [startPath addLineToPoint:CGPointMake(0, 0)];
            layer.path = startPath.CGPath;

            layer.transform = CATransform3DMakeRotation(M_PI / 3.0f * i, 0, 0, 1.0);
            [self.layer addSublayer:layer];

            CAAnimationGroup *group = [CAAnimationGroup animation];
            group.removedOnCompletion = NO;
            group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            group.fillMode = kCAFillModeForwards;
            group.duration = duration;

            CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnim.fromValue = @(0.0f);
            scaleAnim.toValue = @(1.0f);
            scaleAnim.duration = duration * 0.2f;

            UIBezierPath *endPath = [UIBezierPath bezierPath];
            [endPath moveToPoint:CGPointMake(-2, -length)];
            [endPath addLineToPoint:CGPointMake(2, -length)];
            [endPath addLineToPoint:CGPointMake(0, -length)];

            CABasicAnimation *pathAnim = [CABasicAnimation animationWithKeyPath:@"path"];
            pathAnim.fromValue = (__bridge id)layer.path;
            pathAnim.toValue = (__bridge id)endPath.CGPath;
            pathAnim.beginTime = duration * 0.2f;
            pathAnim.duration = duration * 0.8f;

            [group setAnimations:@[scaleAnim, pathAnim]];
            [layer addAnimation:group forKey:nil];
        }
        self.likeAfterImgView.hidden = NO;
        self.likeAfterImgView.alpha = 0.0f;
        
        self.likeAfterImgView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        
        [UIView animateWithDuration:0.15 animations:^{
            self.likeAfterImgView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            self.likeAfterImgView.alpha = 1.0f;
            self.likeBeforeImgView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.likeAfterImgView.transform = CGAffineTransformIdentity;
            self.likeBeforeImgView.alpha = 1.0f;
        }];
    }else {
        self.likeAfterImgView.alpha = 1.0f;
        self.likeAfterImgView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        [UIView animateWithDuration:0.15 animations:^{
            self.likeAfterImgView.transform = CGAffineTransformMakeScale(0.3f, 0.3f);
        } completion:^(BOOL finished) {
            self.likeAfterImgView.transform = CGAffineTransformIdentity;
            self.likeAfterImgView.hidden = YES;
        }];
    }
}

#pragma mark - UITapGestureRecognizer
- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (self.isLike) {
        [self startAnimationWithIsLike:NO];
    }else {
        [self startAnimationWithIsLike:YES];
    }
}

#pragma mark - 懒加载
- (UIImageView *)likeBeforeImgView {
    if (!_likeBeforeImgView) {
        _likeBeforeImgView = [UIImageView new];
        _likeBeforeImgView.image = [UIImage imageNamed:@"icon_home_like_before"];
    }
    return _likeBeforeImgView;
}

- (UIImageView *)likeAfterImgView {
    if (!_likeAfterImgView) {
        _likeAfterImgView = [UIImageView new];
        _likeAfterImgView.image = [UIImage imageNamed:@"icon_home_like_after"];
    }
    return _likeAfterImgView;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.font = [UIFont systemFontOfSize:13.0f];
    }
    return _countLabel;
}

@end
