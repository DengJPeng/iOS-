//
//  TimePickView.h
//  TaskManager
//
//  Created by 邓金鹏 on 2020/6/5.
//  Copyright © 2020 邓金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimePickView : UIView

/// 时间选择器
/// @param frame
/// @param currentHHMM    小时:分钟  默认是@“00:00”
/// @param block <#block description#>
-(instancetype)initWithFrame:(CGRect)frame CurentTime:(NSString *)currentHHMM ComfirmBlock:(void(^)(BOOL isComfirm,NSString *timeStr ))block;
@end

NS_ASSUME_NONNULL_END
