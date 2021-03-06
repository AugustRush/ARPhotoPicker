//
//  ARPhotoPickerAssetCell.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAsset;

@interface ARPhotoPickerAssetCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkmarkImageView;

- (void)configurationWithAsset:(PHAsset *)asset showCheckmark:(BOOL)show;

@end
