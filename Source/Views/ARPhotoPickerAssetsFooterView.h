//
//  ARPhotoPickerAssetsFooterView.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHFetchResult;

@interface ARPhotoPickerAssetsFooterView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

- (void)configurationWithAssetsResult:(PHFetchResult *)result;

@end
