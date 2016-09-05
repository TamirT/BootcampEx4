//
//  AttributedTriangleView.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "AttributedTriangleView.h"
#import "AttributedShapeView.h"
#import "SetTriangle.h"
#import "SetColor.h"
#import "SetShade.h"
#

@interface AttributedTriangleView()

@property (strong, nonatomic) AttributedShapeView * shapeView;

@end

@implementation AttributedTriangleView


-(instancetype)initWithColors:(UIColor *)fill : (UIColor *)stroke{

  self = [super init];

  SetTriangle *setTriangle = [[SetTriangle alloc] init];

  self.shapeView = [[AttributedShapeView alloc] initWithProperties:setTriangle :stroke :fill];

  return self;
}


-(void)drawRect:(CGRect)rect{

  //  [self.shapeView drawRect:rect];
  self.shapeView.frame = rect;
  [self addSubview:self.shapeView];
  [self.shapeView setNeedsDisplay];
}

@end
