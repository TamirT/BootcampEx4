//
//  AttributedShapeView.h
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BezierPath.h"
#import "ShadeInterpreter.h"
#import "ColorInterpreter.h"

@interface AttributedShapeView : UIView

@property (strong, nonatomic) id<BezierPath> shape;
@property (strong, nonatomic) UIColor* stroke;
@property (strong, nonatomic) UIColor* fill;

-(instancetype)initWithProperties: (id<BezierPath>) shape : (UIColor*) stroke
                         : (UIColor*) fill;

@end
