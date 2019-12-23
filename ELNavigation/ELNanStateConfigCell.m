//
//  ELNanStateConfigCell.m
//  ELNavigation
//
//  Created by 高欣 on 2019/12/21.
//  Copyright © 2019 getElementByYou. All rights reserved.
//

#import "ELNanStateConfigCell.h"

@implementation ELNanStateConfigCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)switchSelect:(UISwitch *)sender {
    self.SwitchSelectBlock(sender.on);
}

@end
