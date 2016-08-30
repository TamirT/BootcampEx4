//
//  CardViewController.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 28/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "CardViewController.h"

@interface CardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *msgBox;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) NSInteger gameType;
@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
