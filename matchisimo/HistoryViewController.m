//
//  HIstoryViewController.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 28/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UITextView *presentedLog;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self updateText];
  // Do any additional setup after loading the view.
}

- (NSMutableAttributedString *)historyLogger{
  if(!_historyLogger){
    _historyLogger = [[NSMutableAttributedString alloc] init];
  }
  return _historyLogger;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)updateText{
  self.presentedLog.attributedText = self.historyLogger;
}

@end
