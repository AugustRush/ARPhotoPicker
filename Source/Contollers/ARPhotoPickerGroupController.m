//
//  ARPhotoPickerController.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerGroupController.h"
#import "ARPhotoPickerGroupCell.h"
#import "ARPhotoPickerAssetsController.h"

@interface ARPhotoPickerGroupController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) PHFetchResult *smartAlbumFetchResult;
@property (nonatomic, strong) PHFetchResult *anyAlbumFetchResult;

@end

@implementation ARPhotoPickerGroupController

static NSString * const reuseIdentifier = @"ARPhotoPickerGroupCell";

#pragma mark - lifeCycle methods

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _initConfigs];
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

- (void)_initConfigs {
#if TARGET_IPHONE_SIMULATOR
    _collectionType = PHAssetCollectionTypeSmartAlbum;
    _collectionSubType = PHAssetCollectionSubtypeSmartAlbumUserLibrary;
#else
    _collectionType = PHAssetCollectionTypeSmartAlbum;
    _collectionSubType = PHAssetCollectionSubtypeSmartAlbumUserLibrary;
#endif
}

- (void)_setUp {
    
    self.navigationItem.title = @"My Photos";
    self.smartAlbumFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:
                                  self.collectionType
                                                                          subtype:self.collectionSubType
                                                                          options:nil];;
    
    self.anyAlbumFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ARPhotoPickerGroupCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelItemClicked:)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    if (self.autoPushToUserPhotoLibrary && self.smartAlbumFetchResult.count > 0) {
        PHAssetCollection *collection = [self.smartAlbumFetchResult objectAtIndex:0];
        ARPhotoPickerAssetsController *assetsController = [[ARPhotoPickerAssetsController alloc] initWithAssetsCollection:collection];
        assetsController.title = collection.localizedTitle;
        [self.navigationController setViewControllers:@[self,assetsController]];
    }
}

#pragma mark - custom event methods

- (void)cancelItemClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.smartAlbumFetchResult.count;
    }
    return self.anyAlbumFetchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ARPhotoPickerGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        PHAssetCollection *collection = [self.smartAlbumFetchResult objectAtIndex:indexPath.row];
        [cell configurationCellWithCollection:collection];
    }else{
        PHAssetCollection *collection = [self.anyAlbumFetchResult objectAtIndex:indexPath.row];
        [cell configurationCellWithCollection:collection];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PHAssetCollection *collection = nil;
    if (indexPath.section == 0) {
        collection = [self.smartAlbumFetchResult objectAtIndex:indexPath.row];
    }else{
        collection = [self.anyAlbumFetchResult objectAtIndex:indexPath.row];
    }
    ARPhotoPickerAssetsController *assetsController = [[ARPhotoPickerAssetsController alloc] initWithAssetsCollection:collection];
    assetsController.title = collection.localizedTitle;
    [self.navigationController pushViewController:assetsController animated:YES];
}

@end
