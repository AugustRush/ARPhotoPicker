//
//  ARPhotoPickerAssetsToolBar.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARPhotoPickerAssetsToolBar : UIToolbar

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *numberButton;

- (void)setNumber:(NSUInteger)number;

@end
