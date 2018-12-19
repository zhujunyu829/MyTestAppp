//
//  GLineView.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/19.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "GLineView.h"
@implementation GLineView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:rect];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(rect) / 2, CGRectGetHeight(rect))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:ZJYColorHex(@"898989").CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(rect)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:1], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

@end
