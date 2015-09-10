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

- (void)configurationWithAsset:(PHAsset *)asset {
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(160, 160) contentMode:PHImageContentModeAspectFill options:PHImageRequestOptionsVersionCurrent resultHandler:^(UIImage *result, NSDictionary *info) {
        self.imageView.image = result;
    }];
}

@end
