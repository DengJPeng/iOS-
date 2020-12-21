//
//  TimePickView.m
//  TaskManager
//
//  Created by 邓金鹏 on 2020/6/5.
//  Copyright © 2020 邓金鹏. All rights reserved.
//

#import "TimePickView.h"
@interface TimePickView()
@property(nonatomic,strong)UILabel *hourLabel;
@property(nonatomic,strong)UILabel *minuteLabel;
@property(nonatomic,strong)UIView *panV;
@property(nonatomic,assign)int selectedIndex;

@property(nonatomic,assign)CGFloat allAngle;
@property(nonatomic,strong)CAShapeLayer *shapelayer;
@property(nonatomic,strong)UIImageView *panImageV;
@property(nonatomic,copy)void(^comfirmBlock)(BOOL,NSString *);
@property(nonatomic,copy)NSString *currentHHMM;
@end
@implementation TimePickView


//- (void)drawRect:(CGRect)rect {
//
//
//
//
//}
-(instancetype)initWithFrame:(CGRect)frame CurentTime:(NSString *)currentHHMM ComfirmBlock:(void (^)(BOOL, NSString * _Nonnull))block
{
    if (self = [super initWithFrame:frame]) {
        self.comfirmBlock = block;
        self.currentHHMM = currentHHMM;
           [self setUpUI];
       
       }
       return self;
}

-(void)setUpUI
{
    
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        topView.backgroundColor = KMainTintColor;
        [self addSubview:topView];
        self.hourLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-60-5, 20, 60, 60 )];
      self.hourLabel.font = [UIFont systemFontOfSize:40];
    self.hourLabel.textColor = [UIColor whiteColor];
    self.hourLabel.textAlignment = NSTextAlignmentRight;
    self.hourLabel.text = [self.currentHHMM substringWithRange:NSMakeRange(0, 2)];
    [topView addSubview:self.hourLabel];
    UILabel *middleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-5, 20, 10, 60)];
    middleLabel.text = @":";
    middleLabel.font = [UIFont systemFontOfSize:40];
    middleLabel.textColor = [UIColor whiteColor];
    [topView addSubview:middleLabel];
    self.minuteLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2+5, 20, 60, 60)];
    self.minuteLabel.font = [UIFont systemFontOfSize:40];
    self.minuteLabel.text = [self.currentHHMM substringWithRange:NSMakeRange(3, 2)];
    self.minuteLabel.textColor = [UIColor lightGrayColor];
    self.hourLabel.textAlignment = NSTextAlignmentLeft;
     [topView addSubview:self.minuteLabel];
        
    
    
    
        UIView *panView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-100, 150, 200, 200)];
        panView.backgroundColor = [UIColor lightGrayColor];
        panView.layer.cornerRadius = 100;
        panView.layer.masksToBounds = YES;
        self.panV = panView;
        [self addSubview:panView];
        
       
    //    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200  ,200)];
    //    imageV.image = [UIImage imageNamed:@"timePick"];
    //    imageV.userInteractionEnabled = YES;
    //    [panView addSubview:imageV];
    //    self.panImageV = imageV;
        
        float dist = 100-15;//半径
        float dist2 = 100 - 20-20;

          for (int i= 1; i<=12;i++) {

              float angle = degreesToRadians((360 / 12) * i);

              float y = cos(angle) * dist;

              float x = sin(angle) * dist;
          

              UILabel *label= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
              label.textAlignment = NSTextAlignmentCenter;
              label.text = [NSString stringWithFormat:@"%d",i];
              label.textColor =  [UIColor blackColor];
              label.font = [UIFont systemFontOfSize:16];
             label.layer.cornerRadius = 15;
              label.layer.masksToBounds = YES;
              label.userInteractionEnabled = NO;
             CGPoint center = CGPointMake(100+ x, 100 - y);
             label.center = center;
              label.tag = i;

              [panView addSubview:label];
              
                     float y2 = cos(angle) * dist2;

                      float x2 = sin(angle) * dist2;
              
              
              UILabel *labe2= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
                    labe2.textAlignment = NSTextAlignmentCenter;
                    labe2.text = [NSString stringWithFormat:@"%d",i+12];
    //          if (i == 12) {
    //              labe2.text = @"24";
    //          }
              labe2.tag = 12+i;
                    labe2.textColor =  [UIColor blackColor];
               labe2.font = [UIFont systemFontOfSize:14];
        
                   labe2.layer.cornerRadius = 15;
                    labe2.layer.masksToBounds = YES;
                    labe2.userInteractionEnabled = NO;
                   CGPoint center1 = CGPointMake(100+ x2, 100 - y2);
                   labe2.center = center1;
                    [panView addSubview:labe2];
              
              
              
          }
        
    if (self.currentHHMM.length>=5) {
        self.selectedIndex = [[self.currentHHMM substringWithRange:NSMakeRange(0, 2)] intValue];
       [self changeUIWithIndex:self.selectedIndex];
    }else{
        self.currentHHMM = @"00:00";
    }
    
   
    
    UIButton *comfirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-30-40, self.frame.size.height-30-30, 40, 30)];
    [comfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [comfirmBtn setTitleColor:KMainTintColor forState:UIControlStateNormal];
    [comfirmBtn addTarget:self action:@selector(clickToConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: comfirmBtn];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-30-40-60-40, self.frame.size.height-30-30, 40, 30)];
       [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickToCancel:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitleColor:KMainTintColor forState:UIControlStateNormal];       [self addSubview: cancelBtn];
    
    
    UIButton *swithBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, self.frame.size.height-30-30, 30, 30)];
    
    
    
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.panImageV) {
        UITouch *touch1 = [touches anyObject];

          if (touch1.view != self.panV) {
              return;
          }
          
          CGPoint center = CGPointMake(CGRectGetMidX([touch1.view bounds]), CGRectGetMidY([touch1.view bounds]));
          CGPoint currentPoint = [touch1 locationInView:touch1.view];//当前手指的坐标
          CGPoint previousPoint = [touch1 previousLocationInView:touch1.view];//上一个坐标
          
          
          CGFloat distance2 =sqrt((currentPoint.x - 100)*(currentPoint.x - 100) + (currentPoint.y -100)*(currentPoint.y -100));
           
          CGFloat angle = M_PI/2.0 - atan2f(-currentPoint.y +center.y, currentPoint.x - center.x)  ;
          
          if (angle < 0) {
              angle = 2 *M_PI + angle;
          }
          CGFloat dushu = angle*(180/M_PI);
          
          int tt  = (int)roundf(angle/(2*M_PI/12));
          if (tt == 0) {
              tt = 12;
          }
          
          if (distance2 < 65) {
              tt = 12+ tt ;
             
          }
        
          [self changeUIWithIndex:tt];
        
    }else{
        

               UITouch *touch1 = [touches anyObject];
           
            CGPoint center = CGPointMake(CGRectGetMidX([touch1.view bounds]), CGRectGetMidY([touch1.view bounds]));
              CGPoint currentPoint = [touch1 locationInView:touch1.view];//当前手指的坐标
              CGPoint previousPoint = [touch1 previousLocationInView:touch1.view];//上一个坐标

            
            /**
             求得每次手指移动变化的角度
             atan2f 是求反正切函数 参考:http://blog.csdn.net/chinabinlang/article/details/6802686
             */
            CGFloat angle = atan2f(currentPoint.y - center.y, currentPoint.x - center.x) - atan2f(previousPoint.y - center.y, previousPoint.x - center.x);
            if (angle >= M_PI*2 ||angle<=-M_PI*2) {
                NSLog(@"正切值是：%f",angle);
                return;
            }else{

                if (angle>M_PI) {
                    return;
                }


                self.allAngle = self.allAngle + angle;
            }
        if (self.allAngle> 2 *M_PI) {
            self.allAngle = self.allAngle -2 *M_PI;
        }
        if (self.allAngle < 0) {
             self.allAngle = self.allAngle +2 *M_PI;
        }
        
            self.panImageV.transform = CGAffineTransformRotate(self.panImageV.transform, angle);
           // self.panImageV.transform = CGAffineTransformMakeRotation(tt * 2*M_PI/12);
            
//             self.allAngle = (2 *M_PI /60)*tt-M_PI/2.0;
        int tt = (self.allAngle +M_PI/2.0 )/(2 *M_PI /60);
        if (tt >= 60) {
            tt = tt - 60;
        }
        if ( tt < 0 ) {
            tt = tt + 60;
        }
        
        self.minuteLabel.text = [NSString stringWithFormat:@"%2d",tt];
        
        
    }
    
  
        

   
    
    
    
}





-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    self.hourLabel.text = [NSString stringWithFormat:@"%02d",self.selectedIndex];
  
    if (!self.panImageV) {
          [self reloadMintuesView];
    }
  
    
    
}

-(void)reloadMintuesView
{
    for (id subView in self.panV.subviews) {
        [subView removeFromSuperview];
    }
    [self.shapelayer removeFromSuperlayer];
    
    self.hourLabel.textColor = [UIColor lightGrayColor];
    self.minuteLabel.textColor = [UIColor whiteColor];
       
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200  ,200)];
        imageV.image = [UIImage imageNamed:@"timePick"];
        imageV.userInteractionEnabled = YES;
        [self.panV addSubview:imageV];
        self.panImageV = imageV;
    
    
    
    float dist = 100-15;//半径
         

             for (int i= 1; i<=12;i++) {

                 float angle = degreesToRadians((360 / 12) * i);

                 float y = cos(angle) * dist;

                 float x = sin(angle) * dist;
             

                 UILabel *label= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
                 label.textAlignment = NSTextAlignmentCenter;
                 label.text = [NSString stringWithFormat:@"%d",i];
                 label.textColor =  [UIColor blackColor];
                 label.font = [UIFont systemFontOfSize:16];
                label.layer.cornerRadius = 15;
                 label.layer.masksToBounds = YES;
                 label.userInteractionEnabled = NO;
                CGPoint center = CGPointMake(100+ x, 100 - y);
                label.center = center;
                 label.tag = i;

                 [self.panV addSubview:label];
             }
    int tt = [[self.currentHHMM substringWithRange:NSMakeRange(3, 2)] intValue];
    
    self.allAngle = (2 *M_PI /60)*tt-M_PI/2.0;
    
    if (self.allAngle < 0) {
        self.allAngle = 2*M_PI + self.allAngle;
    }
    self.panImageV.transform = CGAffineTransformMakeRotation(self.allAngle);
    self.minuteLabel.text = [self.currentHHMM substringWithRange:NSMakeRange(3, 2)];
    
}


-(void)changeUIWithIndex:(int)index
{
    UILabel *preLabel = [self.panV viewWithTag:self.selectedIndex];
      if (preLabel && [preLabel isKindOfClass:[UILabel class]]) {
        preLabel.backgroundColor = [UIColor clearColor];
        preLabel.textColor = [UIColor blackColor];
      }
      if (self.shapelayer) {
                    [self.shapelayer removeFromSuperlayer];
                }
      self.selectedIndex = index;
     
         
           UILabel *selectLabel = [self.panV viewWithTag:index];
         
              selectLabel.backgroundColor = KMainTintColor;
              selectLabel.textColor = [UIColor whiteColor];
              // 线的路径
                UIBezierPath *linePath = [UIBezierPath bezierPath];
                // 起点
                [linePath moveToPoint:CGPointMake(100, 100)];
                // 其他点
                [linePath addLineToPoint:CGPointMake(selectLabel.center.x, selectLabel.center.y)];
              
            
              self.shapelayer = [CAShapeLayer layer];
              
              self.shapelayer.lineWidth = 1;
              self.shapelayer.strokeColor = KMainTintColor.CGColor;
              self.shapelayer.path = linePath.CGPath;
              self.shapelayer.fillColor = nil; // 默认为blackColor
          
              [self.panV.layer addSublayer:self.shapelayer];
    self.hourLabel.text = [NSString stringWithFormat:@"%02d",self.selectedIndex];
      
}
-(void)clickToCancel:(UIButton *)sender
{
    if (self.comfirmBlock) {
        self.comfirmBlock(NO, @"00:00");
    }
}
-(void)clickToConfirm:(UIButton *)sender
{
    
    
    
    if (self.comfirmBlock) {
         self.comfirmBlock(YES, [NSString stringWithFormat:@"%@:%@",self.hourLabel.text,self.minuteLabel.text]);
    }
}
@end
