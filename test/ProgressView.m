//
//  ProgressView.m
//  test
//
//  Created by liang wang on 2017/7/8.
//  Copyright © 2017年 liang wang. All rights reserved.
//

#import "ProgressView.h"
//角度转换为弧度
#define CircleDegreeToRadian(d) ((d)*M_PI)/180.0

@interface ProgressView ()

@property(nonatomic,strong)CAShapeLayer *backLayer;
@property(nonatomic,strong)CAShapeLayer *circleLayer;
@property(nonatomic,strong)CAGradientLayer *colorLayer;
@property(nonatomic,strong)NSTimer *timer;
@property (nonatomic, assign) CGFloat strokeWidth;/**<线宽*/
@property (nonatomic, assign) CGFloat startAngle;/**<起点角度。角度从水平右侧开始为0，顺时针为增加角度。直接传度数 如-90 */
@property (weak, nonatomic) IBOutlet UILabel *amountL;
@property(nonatomic,assign)NSTimeInterval animaTime;
@end

@implementation ProgressView
{
    NSInteger _amountCount;
}

+ (instancetype)progressViewForNib{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup{
    //设置中心点 半径 起点及终点
    _strokeWidth = 8.0;
    _animaTime = 2.0;
    _startAngle = CircleDegreeToRadian(-60);
    
    CGFloat maxWidth = self.frame.size.width<self.frame.size.height?self.frame.size.width:self.frame.size.height;
    CGPoint center = CGPointMake(maxWidth/2.0, maxWidth/2.0);
    CGFloat radius = maxWidth/2.0-_strokeWidth/2.0-1;
    CGFloat endA = 2*M_PI;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2 endAngle:endA clockwise:YES];
    self.backLayer = [CAShapeLayer layer];
    _backLayer.frame = self.bounds;
    _backLayer.fillColor = [UIColor clearColor].CGColor;
    _backLayer.lineWidth = _strokeWidth/2;
    _backLayer.strokeColor = [UIColor grayColor].CGColor;
    _backLayer.path = path.CGPath;
    [self.layer addSublayer:_backLayer];
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:_startAngle endAngle:-M_PI_2 clockwise:YES];
    
    self.circleLayer = [CAShapeLayer layer];
    _circleLayer.frame = self.bounds;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.lineWidth = _strokeWidth;
    _circleLayer.strokeColor = [UIColor greenColor].CGColor;
    _circleLayer.path = circlePath.CGPath;
    _circleLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_circleLayer];
    
    self.colorLayer = [CAGradientLayer layer];
    _colorLayer.frame = self.bounds;
    _colorLayer.colors = @[(id)[UIColor orangeColor].CGColor,(id)[UIColor redColor].CGColor];
    _colorLayer.locations = @[@(0.01),@(1.0)];
    _colorLayer.startPoint  = CGPointMake(0, 0);
    _colorLayer.endPoint = CGPointMake(0, 1);
    _colorLayer.mask = _circleLayer;
    [self.layer addSublayer:_colorLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = _animaTime;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.circleLayer addAnimation:animation forKey:@"strokeEnd"];
}


@end
