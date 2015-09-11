//
//  ARPhotoPickerAssetsToolBar.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerAssetsToolBar.h"

@implementation ARPhotoPickerAssetsToolBar

- (void)awakeFromNib {
    self.numberButton.hidden = YES;
    self.numberButton.clipsToBounds = YES;
    self.numberButton.layer.cornerRadius = 10.0;
}

- (void)setNumber:(NSUInteger)number {
    self.numberButton.hidden = number > 0 ? NO:YES;
    [self.numberButton setTitle:[NSString stringWithFormat:@"%lu",number] forState:UIControlStateNormal];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
