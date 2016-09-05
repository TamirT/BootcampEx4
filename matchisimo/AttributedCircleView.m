//
//  AttributedCircleView.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "AttributedCircleView.h"
#import "AttributedShapeView.h"
#import "SetCircle.h"
#import "SetColor.h"
#import "SetShade.h"

@interface AttributedCircleView()

@property (strong, nonatomic) AttributedShapeView * shapeView;

@end

@implementation AttributedCircleView

-(instancetype)initWithColors:(UIColor *)fill : (UIColor *)stroke{

  self = [super init];

  SetCircle *setCircle = [[SetCircle alloc] init];

  self.shapeView = [[AttributedShapeView alloc] initWithProperties:setCircle :stroke :fill];

  return self;
}

-(void)drawRect:(CGRect)rect{

  self.shapeView.frame = rect;
  [self addSubview:self.shapeView];
  [self.shapeView setNeedsDisplay];
}




@end
