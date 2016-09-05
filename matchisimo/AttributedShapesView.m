//
//  AttributedShapesView.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "AttributedShapesView.h"

@interface AttributedShapesView()

@property (strong, nonatomic) NSMutableArray *attributedShapeViews;
@property (nonatomic) NSUInteger instancesNum;
@end

@implementation AttributedShapesView

-(instancetype)initWithProperties:(NSArray *)attributedShapeViews{

  self = [super init];
  self.attributedShapeViews = [[NSMutableArray alloc] init];
  self.instancesNum = [attributedShapeViews count];
  for(NSUInteger i = 0 ; i <  self.instancesNum; i++){
    [self.attributedShapeViews addObject:attributedShapeViews[i]];
  }

  return self;
}

- (void)drawRect:(CGRect)rect{

  CGFloat oneShapeWidth = rect.size.width / 3;
  CGFloat height = rect.size.height;

  CGFloat origin = 0.0f;

  for(UIView *view in self.attributedShapeViews){
    CGRect shapeFrame = CGRectMake(origin, height / 4,  oneShapeWidth , height / 2) ;
    view.frame = shapeFrame;
    [self addSubview:view];
    [view setNeedsDisplay];
    origin = origin + oneShapeWidth;
  }

}

@end
