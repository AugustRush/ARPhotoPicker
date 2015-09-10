//
//  ARPhotoPickerAssetsFooterView.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerAssetsFooterView.h"
#import <Photos/Photos.h>

@implementation ARPhotoPickerAssetsFooterView

- (void)awakeFromNib {

}

- (void)configurationWithAssetsResult:(PHFetchResult *)result {
    NSUInteger imagesCount = [result countOfAssetsWithMediaType:PHAssetMediaTypeImage];
    self.textLabel.text = [NSString stringWithFormat:@"%lu Images",imagesCount];
}

@end
