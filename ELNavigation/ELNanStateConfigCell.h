//
//  ELNanStateConfigCell.h
//  ELNavigation
//
//  Created by 高欣 on 2019/12/21.
//  Copyright © 2019 getElementByYou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELNanStateConfigCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;

@property (nonatomic,copy) void (^SwitchSelectBlock) (BOOL select);

@end

NS_ASSUME_NONNULL_END
