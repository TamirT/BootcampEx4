//
//  AttributedShapeView.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "AttributedShapeView.h"

@interface AttributedShapeView()


@end

@implementation AttributedShapeView


-(instancetype)initWithProperties: (id<BezierPath>) shape : (UIColor*) stroke
                                 : (UIColor*) fill{

  self = [super init];

  self.shape = shape;
  self.fill = fill;
  self.stroke = stroke;

  return self;
}

- (void)drawRect:(CGRect)rect{

  UIBezierPath *path = [self.shape drawPath:self.frame];

  [self.stroke setStroke];
  [path stroke];
  [self.fill setFill];
  [path fill];
}



@end
