//
//  ViewController.m
//  HorologeMade
//
//  Created by 展恒 on 15/12/22.
//  Copyright © 2015年 赵百川. All rights reserved.
//

#import "ViewController.h"
#import "drawview.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view drawRect:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    drawview *clock = [[drawview alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20, self.view.frame.size.width-20)];
    [self.view addSubview:clock];
    
    
//    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    btn.frame = CGRectMake(20, 20, 100, 200);
//    btn.titleLabel.text =  @"niiii";
//    [btn addTarget:self action:@selector(actiona:) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor blackColor];
//    
//    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)drawRectangle
{ // 定义矩形的rect
    CGRect rectangle = CGRectMake(100, 290, 120, 25);
    
    // 获取当前图形，视图推入堆栈的图形，相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 在当前路径下添加一个矩形路径
    CGContextAddRect(ctx, rectangle);
    
    // 设置试图的当前填充色
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    
    // 绘制当前路径区域
    CGContextFillPath(ctx);
    
}
- (void)drawEllipse {
    
    // 获取当前图形，视图推入堆栈的图形，相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 定义其rect
    CGRect rectangle = CGRectMake(10, 100, 300, 280);
    
    // 在当前路径下添加一个椭圆路径
    CGContextAddEllipseInRect(ctx, rectangle);
    
    // 设置当前视图填充色
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    
    // 绘制当前路径区域
    CGContextFillPath(ctx);
}
- (void)drawTriangle {
    
    // 获取当前图形，视图推入堆栈的图形，相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 创建一个新的空图形路径。
    CGContextBeginPath(ctx);
    
    /**
     *  @brief 在指定点开始一个新的子路径 参数按顺序说明
     *
     *  @param c 当前图形
     *  @param x 指定点的x坐标值
     *  @param y 指定点的y坐标值
     *
     */
    CGContextMoveToPoint(ctx, 160, 220);
    
    /**
     *  @brief 在当前点追加直线段，参数说明与上面一样
     */
    CGContextAddLineToPoint(ctx, 190, 260);
    CGContextAddLineToPoint(ctx, 130, 260);
    
    // 关闭并终止当前路径的子路径，并在当前点和子路径的起点之间追加一条线
    CGContextClosePath(ctx);
    
    // 设置当前视图填充色
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    
    // 绘制当前路径区域
    CGContextFillPath(ctx);
}
- (void)drawCurve {
    
    // 获取当前图形，视图推入堆栈的图形，相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 创建一个新的空图形路径。
    CGContextBeginPath(ctx);
    
    /**
     *  @brief 在指定点开始一个新的子路径 参数按顺序说明
     *
     *  @param c 当前图形
     *  @param x 指定点的x坐标值
     *  @param y 指定点的y坐标值
     *
     */
    CGContextMoveToPoint(ctx, 160, 100);
    
    /**
     *  @brief 在指定点追加二次贝塞尔曲线，通过控制点和结束点指定曲线。
     *         关于曲线的点的控制见下图说明，图片来源苹果官方网站。参数按顺序说明
     *  @param c   当前图形
     *  @param cpx 曲线控制点的x坐标
     *  @param cpy 曲线控制点的y坐标
     *  @param x   指定点的x坐标值
     *  @param y   指定点的y坐标值
     *
     */
    CGContextAddQuadCurveToPoint(ctx, 160, 50, 190, 50);
    
    // 设置图形的线宽
    CGContextSetLineWidth(ctx, 20);
    
    // 设置图形描边颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor brownColor].CGColor);
    
    // 根据当前路径，宽度及颜色绘制线
    CGContextStrokePath(ctx);
}
- (void)drawCircleAtX:(float)x Y:(float)y {
    
    // 获取当前图形，视图推入堆栈的图形，相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 创建一个新的空图形路径。
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    
    /**
     *  @brief 在当前路径添加圆弧 参数按顺序说明
     *
     *  @param c           当前图形
     *  @param x           圆弧的中心点坐标x
     *  @param y           曲线控制点的y坐标
     *  @param radius      指定点的x坐标值
     *  @param startAngle  弧的起点与正X轴的夹角，
     *  @param endAngle    弧的终点与正X轴的夹角
     *  @param clockwise   指定1创建一个顺时针的圆弧，或是指定0创建一个逆时针圆弧
     *
     */
    CGContextAddArc(ctx, x, y, 20, 0, 2 * M_PI, 1);
    
    //绘制当前路径区域
    CGContextFillPath(ctx);
}
- (void)drawRect:(CGRect)rect {
    
    UIFont *font = [UIFont systemFontOfSize:40.f];
    NSString *myString = @"Some String";
    [myString drawAtPoint:CGPointMake(40, 180) withAttributes:font];
    
    
    
    
    // 绘制椭圆
    [self drawEllipse];
    
    // 绘制三角
    [self drawTriangle];
    
    // 绘制矩形
    [self drawRectangle];
    
    // 绘制曲线
    [self drawCurve];
    
    // 绘制圆形
    [self drawCircleAtX:120 Y:170];
    
    [self drawCircleAtX:200 Y:170];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
