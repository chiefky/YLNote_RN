//
//  YLFilmTabView.m
//  YLNote
//
//  Created by tangh on 2022/5/25.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLFilmTabView.h"
#import "YLDefaultMacro.h"
#import "YLNote-Swift.h"

@interface YLFilmTabView ()

@property (weak, nonatomic) IBOutlet UILabel *tabLabel;
//@property (weak, nonatomic) IBOutlet UIView *underlineView;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;

@property (copy, nonatomic) NSString *tabName;


@end

@implementation YLFilmTabView

- (instancetype)initWithName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"YLFilmTabView" ofType:@"nib"];
    if (path) {
        self = (YLFilmTabView *)[[NSBundle  mainBundle]loadNibNamed:@"YLFilmTabView" owner:self options:nil ].firstObject;
        self.tabName = name;
        self.tabLabel.text = name;
        self.tabLabel.font = [UIFont boldSystemFontOfSize:17.0];
    } else {
        self = [super init];
    }
    
    return self;
}

- (IBAction)tapClickAction:(id)sender {
    
    NSLog(@"%@ is clicked",self.tabName);
    self.selected = YES;
    if (self.tabClickHandler) {
        self.tabClickHandler();
    }
}

- (void)setSelected:(BOOL)selected {
    BOOL oldValue = _selected;
    if (oldValue != selected) {
        _selected = selected;
    }
}
//- (void)changeTabThemeColor:(UIColor *)color {
//    self.tabLabel.textColor = color ?: UIColorFromHex(@"#B8860B");
//    self.underlineView.backgroundColor = color ?:  UIColorFromHex(@"#B8860B");
//}

@end
