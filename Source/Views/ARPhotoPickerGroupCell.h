//
//  ARPhotoPickerGroupCell.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAssetCollection;

@interface ARPhotoPickerGroupCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;

- (void)configurationCellWithCollection:(PHAssetCollection *)collection;

@end
