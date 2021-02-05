//
//  CSKeyBoardInputView.m
//  ColorStar
//
//  Created by gavin on 2020/12/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSKeyBoardInputView.h"

#define CSKeyBoardInputViewDefaultHeight  46;
#define CSKeyBoardInputTextDefaultHeight  30;

static CGFloat keyboardAnimationDuration = 0.5;

@interface CSKeyBoardInputView ()<UITextViewDelegate>

@property (nonatomic, strong)UITextView  * textview;

@property (nonatomic, strong)UIButton    * senderBtn;

@property (nonatomic, strong)UILabel     * placeHoldLabel;

@property (nonatomic, assign)CGRect        defaultFrame;

@property (nonatomic, strong)UIView     * bgView;

@end

@implementation CSKeyBoardInputView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.defaultFrame = frame;
        [self setupViews];
        [self addObserver];
        self.maxCount = 200;
    }
    return self;
}


- (void)setupViews{
    
    self.textview = [[UITextView alloc]initWithFrame:CGRectZero];
    self.textview.delegate = self;
    self.textview.font = kFont(11);
    self.textview.textColor = [UIColor blackColor];
    self.textview.frame = CGRectMake(12, 8, self.width - 50 - 12, 30);
    self.textview.layer.masksToBounds = YES;
    self.textview.layer.cornerRadius = 4.0f;
    self.textview.layer.borderColor = LoadColor(@"#DEDFE0").CGColor;
    self.textview.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    [self addSubview:self.textview];
    
    self.placeHoldLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.placeHoldLabel.textColor = LoadColor(@"#B4B6B7");
    self.placeHoldLabel.font = kFont(11);
    [self addSubview:self.placeHoldLabel];
    self.placeHoldLabel.frame = CGRectMake(20, 15, self.width - 100, 16);
    
    self.senderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.senderBtn setTitle:csnation(@"发布") forState:UIControlStateNormal];
    [self.senderBtn setTitleColor:LoadColor(@"#212121") forState:UIControlStateNormal];
    self.senderBtn.titleLabel.font = kFont(15.0f);
    [self.senderBtn addTarget:self action:@selector(senderClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.senderBtn];
    self.senderBtn.frame = CGRectMake(self.textview.right, self.textview.top, 50, 30);
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.bgView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClick)];
    [self.bgView addGestureRecognizer:tap];
    
    
}

- (void)addObserver{
    
    //键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)removeObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)startComment{
    [self.textview becomeFirstResponder];
}

- (void)endComment{
    
    [self.textview resignFirstResponder];
}

#pragma mark - Action Method

- (void)senderClick:(UIButton*)sender{
    
    NSString * content = self.textview.text.length > 0 ? self.textview.text : self.placeHolder;
    
    if (self.inputBlock) {
        self.inputBlock(content);
    }
}

- (void)bgViewClick{
    [self.textview resignFirstResponder];
}

#pragma mark - Private Method

- (void)resetViewUI{
    self.frame = self.defaultFrame;
    
}

#pragma mark - Setter Method

- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.placeHoldLabel.text = placeHolder;
}

#pragma mark - UITextViewDelegate Method

-(void)textViewDidChange:(UITextView *)textView{
    
    self.placeHoldLabel.hidden = textView.text.length > 0;
    
    if(self.maxCount>0){
        if(textView.text.length>=self.maxCount){
            textView.text = [textView.text substringToIndex:self.maxCount];
        }
    }
    
    CGFloat height = [self string:textView.text heightWithFont:textView.font constrainedToWidth:textView.bounds.size.width] + 2*8;
    CGFloat heightDefault = CSKeyBoardInputViewDefaultHeight;
    if(height >= heightDefault){
        [UIView animateWithDuration:0.3 animations:^{
            //调整frame
            CGRect frame = self.defaultFrame;
            frame.size.height = height;
            frame.origin.y = self.defaultFrame.origin.y - (height - self.defaultFrame.size.height);
            self.frame = frame;
            
            //调整textView frame
            textView.frame = CGRectMake(12, 8, textView.bounds.size.width, self.bounds.size.height - 2*8);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            [self resetViewUI];
        }];
    }
    
    
}


#pragma mark - NSNotification Method

- (void)keyboardWillAppear:(NSNotification *)notification{
    
    if(self.textview.isFirstResponder){
        NSDictionary *info = [notification userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
        keyboardAnimationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGSize keyboardSize = [value CGRectValue].size;
        NSLog(@"keyboardSize.height = %f",keyboardSize.height);
        
        [self.superview addSubview:self.bgView];
        [self.superview bringSubviewToFront:self];
        
        [UIView animateWithDuration:keyboardAnimationDuration animations:^{
            CGRect frame = self.frame;
            frame.origin.y = ScreenH - keyboardSize.height - frame.size.height;
            self.frame = frame;
            self.defaultFrame = self.frame;
        }];
    }
    
}

- (void)keyboardWillDisappear:(NSNotification *)notification{
    
    if(self.textview.isFirstResponder){
        [UIView animateWithDuration:keyboardAnimationDuration animations:^{
            CGRect frame = self.frame;
            frame.origin.y = ScreenH;
            self.frame = frame;
        } completion:^(BOOL finished) {
            self.textview.text = nil;
            [self.bgView removeFromSuperview];
        }];
    }
}


#pragma mark - other
- (CGFloat)string:(NSString *)string heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize textSize;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options:(NSStringDrawingUsesLineFragmentOrigin |
                                                 NSStringDrawingTruncatesLastVisibleLine)
                                     attributes:attributes
                                        context:nil].size;
    } else {
        textSize = [string sizeWithFont:textFont
                      constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                          lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:(NSStringDrawingUsesLineFragmentOrigin |
                                             NSStringDrawingTruncatesLastVisibleLine)
                                 attributes:attributes
                                    context:nil].size;
#endif
    
    return ceil(textSize.height);
    
}

@end
