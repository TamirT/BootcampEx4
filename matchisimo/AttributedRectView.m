//
//  AttributedRectView.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "AttributedRectView.h"
#import "AttributedShapeView.h"
#import "SetRect.h"
#import "SetColor.h"
#import "SetShade.h"

@interface AttributedRectView()

@property (strong, nonatomic) AttributedShapeView * shapeView;

@end

@implementation AttributedRectView

-(instancetype)initWithColors:(UIColor *)fill : (UIColor *)stroke{

  self = [super init];

  SetRect *setRect = [[SetRect alloc] init];

  self.shapeView = [[AttributedShapeView alloc] initWithProperties:setRect :stroke :fill];

  return self;
}

-(void)drawRect:(CGRect)rect{

  self.shapeView.frame = rect;
  [self addSubview:self.shapeView];
  [self.shapeView setNeedsDisplay];
}


@end
