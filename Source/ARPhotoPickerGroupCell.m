//
//  ARPhotoPickerGroupCell.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerGroupCell.h"
#import <Photos/Photos.h>

@implementation ARPhotoPickerGroupCell

- (void)awakeFromNib {

}

- (void)configurationCellWithCollection:(PHAssetCollection *)collection {
    self.titleLabel.text = collection.localizedTitle;
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    self.countLabel.text = [NSString stringWithFormat:@"%lu",fetchResult.count];
    if (fetchResult.count > 0) {
        PHAsset *asset = [fetchResult firstObject];
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(70, 70) contentMode:PHImageContentModeAspectFill options:PHImageRequestOptionsVersionCurrent resultHandler:^(UIImage *result, NSDictionary *info) {
            self.collectionImageView.image = result;
        }];
    }

}

@end
