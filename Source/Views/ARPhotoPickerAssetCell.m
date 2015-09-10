//
//  ARPhotoPickerAssetCell.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerAssetCell.h"
#import <Photos/Photos.h>

@implementation ARPhotoPickerAssetCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.checkmarkImageView.image = [UIImage imageNamed:@"image_picker_selected"];
    }else {
        self.checkmarkImageView.image = nil;
    }
}

#pragma mark - public methods

- (void)configurationWithAsset:(PHAsset *)asset showCheckmark:(BOOL)show {
    self.checkmarkImageView.hidden = !show;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(160, 160) contentMode:PHImageContentModeAspectFill options:PHImageRequestOptionsVersionCurrent resultHandler:^(UIImage *result, NSDictionary *info) {
        self.imageView.image = result;
    }];
}

@end
