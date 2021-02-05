//
//  CSBaseCollectionCell.h
//  ColorStar
//
//  Created by gavin on 2020/9/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSBaseCollectionCell : UICollectionViewCell

+ (NSString*)reuserIndentifier;

- (CGSize)collectionCellSize;

- (void)mockData;

- (void)configModel:(id)model;

@end


