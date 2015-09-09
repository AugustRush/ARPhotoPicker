//
//  ARPhotoPickerController.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerGroupController.h"
#import <Photos/Photos.h>
#import "ARPhotoPickerGroupCell.h"

@interface ARPhotoPickerGroupController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) PHFetchResult *fetchResult;

@end

@implementation ARPhotoPickerGroupController

static NSString *reuseIdentifier = @"ARPhotoPickerGroupCell";

#pragma mark - lifeCycle methods

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setUp];
}

- (void)dealloc {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

- (void)_setUp {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ARPhotoPickerGroupCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:
                             PHAssetCollectionTypeAlbum
                             subtype:PHAssetCollectionSubtypeAny
                             options:nil];
    self.fetchResult = result;
}

- (void)setThumbnailWithCell:(ARPhotoPickerGroupCell *)cell assetsCollection:(PHAssetCollection *)collection {
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    if (fetchResult.count > 0) {
        PHAsset *asset = [fetchResult lastObject];
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(70, 70) contentMode:PHImageContentModeAspectFill options:PHImageRequestOptionsVersionCurrent resultHandler:^(UIImage *result, NSDictionary *info) {
            cell.collectionImageView.image = result;
        }];
    }
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ARPhotoPickerGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    PHAssetCollection *collection = [self.fetchResult objectAtIndex:indexPath.row];
    [self setThumbnailWithCell:cell assetsCollection:collection];
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

@end
