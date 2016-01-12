//
//  drawview.m
//  HorologeMade
//
//  Created by 展恒 on 16/1/12.
//  Copyright © 2016年 赵百川. All rights reserved.
//

#import "drawview.h"

@implementation drawview
{   //半径
    CGFloat _radius;
    //半径 时 分 秒
    CGFloat _hourR;
    CGFloat _minR;
    CGFloat _secR;
    //表示当前角度
    CGFloat _hourDegree;
    CGFloat _minDegree;
    CGFloat _secDegree;
    //时间label
    UILabel *_timelabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _radius = frame.size.width < frame.size.height ? frame.size.width/2 : frame.size.height/2;
        _hourR = _radius-5;
        _minR = _radius - 20;
        _secR = _radius - 35;
        
    }
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"hh"];
    float hour = [[dateFormatter stringFromDate:date] floatValue];
    [dateFormatter setDateFormat:@"mm"];
    float min = [[dateFormatter stringFromDate:date]floatValue];
    [dateFormatter setDateFormat:@"ss"];
    float sec = [[dateFormatter stringFromDate:date] floatValue];
    _secDegree = sec*360/60;
    _minDegree = min*360/60 + sec*360/60/60;
    _hourDegree = hour*360/12 + min*360/12/60 + sec*360/12/60/60;
    //当前时间
    _timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _radius-10, 2*_radius, 20)];
    _timelabel.backgroundColor = [UIColor clearColor];
    _timelabel.textAlignment = NSTextAlignmentCenter;
    _timelabel.highlighted = YES;
    _timelabel.highlightedTextColor = [UIColor yellowColor];
    _timelabel.textColor = [UIColor whiteColor];
    _timelabel.shadowColor = [UIColor redColor];
    [self addSubview:_timelabel];
    
    _timelabel.transform = CGAffineTransformRotate(_timelabel.transform, M_PI / 180);//顺时针旋转90度
    //一秒钟转一圈,由 360次/s 得 nstimeinterval = 1.0/360 60秒秒针转一圈
    float time = 60;
    [NSTimer scheduledTimerWithTimeInterval:time*1.0/360.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    return self;
}
- (void)timerAction
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    _timelabel.text = [dateFormatter stringFromDate:date];
    /*
     12小时制
     _secDegree = sec*360/60
     _minDegree = min*360/60
     _hourDegree = hour*360/12
     
     
     */
    
    _secDegree ++;
    _minDegree += 60.0/360/60*360.0/60;
    _hourDegree += 60.0/360/60/60*360.0/12;
    
    if (_secDegree >= 360) {//一圈 一分钟校验一次
        _secDegree = 0;
        [dateFormatter setDateFormat:@"hh"];
        float hour = [[dateFormatter stringFromDate:date] floatValue];
        [dateFormatter setDateFormat:@"mm"];
        float min = [[dateFormatter stringFromDate:date]floatValue];
        [dateFormatter setDateFormat:@"ss"];
        float sec = [[dateFormatter stringFromDate:date] floatValue];
        _secDegree = sec*360/60;
        _minDegree = min*360/60 + sec*360/60/60;
        _hourDegree = hour*360/12 + min*360/12/60 + sec*360/12/60/60;

    }
    
    [self setNeedsDisplay];//
    
    
    
}
//将度转换成弧度
CGFloat degreeToRadian(CGFloat degree)
{
    return M_PI / 180 *degree;
    
}
- (void)drawRect:(CGRect)rect
{
    //绘制圆弧轨迹
    CGContextRef contextSEC1 = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(contextSEC1, 1, 0.5, 0.5, 0.3);//改变画笔颜色
    CGContextSetLineWidth(contextSEC1, 5.0);//线的宽度
    CGContextAddArc(contextSEC1, _radius, _radius, _secR,degreeToRadian(0), degreeToRadian(360), 0);
    CGContextStrokePath(contextSEC1);
    CGContextRef contextMIN1 = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(contextMIN1, 0.5, 0.5, 1, 0.3);//改变画笔颜色
    CGContextSetLineWidth(contextMIN1, 5.0);//线的宽度
    CGContextAddArc(contextMIN1, _radius, _radius, _minR, degreeToRadian(0), degreeToRadian(360), 0);
    CGContextStrokePath(contextMIN1);
    CGContextRef contextHOUR1 = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(contextHOUR1, 0.5, 1, 0.5, 0.3);//改变画笔颜色
    CGContextSetLineWidth(contextHOUR1, 5.0);//线的宽度
    CGContextAddArc(contextHOUR1, _radius, _radius, _hourR, degreeToRadian(0), degreeToRadian(360), 0);
    CGContextStrokePath(contextHOUR1);
    //绘制刻度
    //时
    CGContextRef contextRefHOUR = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(contextRefHOUR, 0, 1, 0, 1);//画笔色
    CGContextSetLineWidth(contextRefHOUR, 7.0);//线的宽度
    CGContextAddArc(contextRefHOUR, _radius, _radius, _hourR, degreeToRadian(0), degreeToRadian(_hourDegree), 0);
    CGContextStrokePath(contextRefHOUR);
    
    //分
    CGContextRef contextMIN = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(contextMIN, 0, 0, 1, 1);
    CGContextSetLineWidth(contextMIN, 7.0);
    CGContextAddArc(contextMIN, _radius, _radius, _minR, degreeToRadian(0), degreeToRadian(_minDegree), 0);
    CGContextStrokePath(contextMIN);
    
    //秒
    CGContextRef contextSEC = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(contextSEC, 1, 0, 0, 1);
    CGContextSetLineWidth(contextSEC, 7.0);
    CGContextAddArc(contextSEC, _radius, _radius, _secR, degreeToRadian(0), degreeToRadian(_secDegree), 0);
    CGContextStrokePath(contextSEC);
    
    
}

@end
