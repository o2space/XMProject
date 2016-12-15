//
//  AlbumCardFlowLayout.m
//  thegloballove
//
//  Created by wukexiu on 16/1/2.
//  Copyright © 2016年 biandewen. All rights reserved.
//

#import "AlbumCardFlowLayout.h"

@implementation AlbumCardFlowLayout
/*
-(id)init{
    self=[super init];
    if (self) {
        self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing=20.0;
        self.sectionInset=UIEdgeInsetsMake(0, 30, 0, 30);
    }
    return self;
}
*/
 
-(void)prepareLayout{
    [super prepareLayout];
    //NSLog(@"Screen Width:%f,Screen Height:%f",kScreen_Width,kScreen_Height);
    float proportion=kScreen_Width/IPHONE6_WIDTH;
    self.itemSize=CGSizeMake(273*proportion, 345*proportion);//292 369
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing=20;
    self.minimumLineSpacing=20;
    self.sectionInset=UIEdgeInsetsMake(25, (kScreen_Width-273*proportion)/2.0, 25, (kScreen_Width-273*proportion)/2.0);
    //self.sectionInset=UIEdgeInsetsMake(25, 20, 25, 20);
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);//collectionView落在屏幕中点的x坐标
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

//static CGFloat const ActiveDistance = 350.0;

static CGFloat const ScaleFactor = 0.07;

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat ActiveDistance=kScreen_Width;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        //NSLog(@"%f",distance);
        CGFloat normalizedDistance = distance / ActiveDistance;
        CGFloat zoom = 1 + ScaleFactor*(1 - ABS(normalizedDistance));
        attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
        attributes.zIndex = 1;
    }
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
