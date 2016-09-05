//
//  SetColor.h
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorInterpreter.h"

@interface SetColor : NSObject <ColorInterpreter>

+ (UIColor *)getUIColor:(NSString *)colorOption;

@end

