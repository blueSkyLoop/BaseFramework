//
//  ZPSegmentedControl.m
//  EduChat
//
//  Created by Beelin on 15/12/8.
//  Copyright © 2015年 ZP. All rights reserved.
//

#import "OOSegmentedControl.h"


@interface OOSegmentedControl ()
@property (nonatomic,strong) UIView *indexLine;
@property (assign, nonatomic) CGFloat indexLineW;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, assign) NSInteger index;//指定选中哪个按钮
@end
@implementation OOSegmentedControl

+ (instancetype)segmentedControlWithFrame:(CGRect)frame Titles:(NSArray *)titles index:(NSInteger)index{
    OOSegmentedControl *control = [[OOSegmentedControl alloc] initWithFrame:frame];
    control.index = index;
    control.backgroundColor = [UIColor whiteColor];
    //setup
    [control setupUI:titles];
    return control;
}

- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
/**
 *  文字
 **/
-(void)setupUI:(NSArray *)titles
{
    if (titles==nil) {
        return;
    }
    
    _indexLineW = SCREEN_WIDTH/titles.count;
    
    //下标线
    [self addSubview:({
        self.indexLine = ({
            UIView *indexLine = [[UIView alloc]init];
            indexLine.backgroundColor  = self.tintColor ? self.tintColor : ColorMain;
            indexLine.frame = CGRectMake(0, self.bounds.size.height- 1.5, SCREEN_WIDTH/titles.count,1.5);;
            indexLine;
        });
    })];
    
    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:ColorBody forState:UIControlStateNormal];
        [btn setTitleColor:self.tintColor ? self.tintColor : ColorMain forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(didSelect:) forControlEvents:UIControlEventTouchDown];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.frame = CGRectMake(i*SCREEN_WIDTH/titles.count, 0, SCREEN_WIDTH/titles.count, self.bounds.size.height);
        [self insertSubview:btn belowSubview:self.indexLine];
        
        [self.btnArray addObject:btn];
        
        if (self.index == -1) continue;//-1将表示初始化不需要默认下标
        if (i == self.index) [self didSelect:btn];
        
        //竖分隔线
        /*
        UIView *lineS = [[UIView alloc]init];
        lineS.frame = CGRectMake(self.bounds.size.width/titles.count*i , 5, 0.5,self.bounds.size.height-10);
        lineS.backgroundColor  = Color_Separator;
        [self addSubview:lineS];
         */
    }
    
    //横分隔线
    [self insertSubview:({
        UIView *line = [[UIView alloc]init];
        line.frame = CGRectMake(0, self.bounds.size.height- 1.5, self.bounds.size.width,1.5);
        line.backgroundColor  = ColorSeparator;
        line;
        
    }) belowSubview:self.indexLine];
    
   
}

-(void)didSelect:(UIButton*)sender
{
    self.selectBtn.selected = NO;
    sender.selected = YES;
    self.selectBtn = sender;
    
    [UIView animateWithDuration:.25 animations:^{
        CGFloat x = self.indexLineW * self.selectBtn.tag;
        self.indexLine.frame = CGRectMake(x, self.bounds.size.height-1.5,_indexLineW, 1.5);
    }];
    
    //call back
    !self.clickButtonBlock ?: self.clickButtonBlock(sender.tag);
    //delegate
    if ([self.delegate respondsToSelector:@selector(segmentedControlIndexButtonView:lickBtnAtTag:)]) {
        [self.delegate segmentedControlIndexButtonView:self lickBtnAtTag:sender.tag];
    }
}


#pragma mark - Public Method
- (void)setupSelectButtonIndex:(NSInteger)index{
    [self.btnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            UIButton *sender = obj;
            self.selectBtn.selected = NO;
            sender.selected = YES;
            self.selectBtn = sender;
            
            [UIView animateWithDuration:.25 animations:^{
                CGFloat x = self.indexLineW * self.selectBtn.tag;
                self.indexLine.frame = CGRectMake(x, self.bounds.size.height-1.5,_indexLineW, 1.5);
            }];
            *stop = YES;
        }
    }];
}

@end
