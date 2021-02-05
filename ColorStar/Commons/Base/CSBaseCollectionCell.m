//
//  CSBaseCollectionCell.m
//  ColorStar
//
//  Created by gavin on 2020/9/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseCollectionCell.h"

@implementation CSBaseCollectionCell

+ (NSString*)reuserIndentifier{
    return [NSString stringWithFormat:@"CSCollectionReuseIdentifier_%@",NSStringFromClass([self class])];
}

- (CGSize)collectionCellSize{
    return CGSizeZero;
}

- (void)mockData{
    
}

- (void)configModel:(id)model{
    
}
@end
