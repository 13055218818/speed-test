//
//  CSChatKeyBoard.m
//  ColorStar
//
//  Created by gavin on 2020/10/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSChatKeyBoard.h"
#import "CSColorStar.h"

@interface ChatHandleButton : UIButton
@end
@implementation ChatHandleButton

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = Frame(0, 0, 60, 60);  //图片 60.60
    self.titleLabel.frame   = Frame(0, MaxY(self.imageView.frame)+5,Width(self.imageView.frame), 12); //固定高度12
}

@end

//记录当前键盘的高度 ，键盘除了系统的键盘还有咱们自定义的键盘，互相来回切换
static CGFloat keyboardHeight         = 0;
static const CGFloat defaultInputHeight     = 35; //默认输入框 35

@interface CSChatKeyBoard ()<UITextViewDelegate>

//消息回调
@property (nonatomic, copy) ChatTextMessageSendBlock textCallback;
@property (nonatomic, copy) ChatAudioMesssageSendBlock audioCallback;
@property (nonatomic, copy) ChatPictureMessageSendBlock pictureCallback;
@property (nonatomic, copy) ChatVideoMessageSendBlock videoCallback;
@property (nonatomic, copy) CSKeyBoardFrameChangeBlock  frameCallback;
@property (nonatomic, strong) id target;

 //表情键盘
@property (nonatomic, strong) UIView *facesKeyboard;
//自定义键盘容器
@property (nonatomic, strong) UIView *keyBoardContainer;
//顶部消息操作栏
@property (nonatomic, strong) UIView *messageBar;
//表情容器
@property (nonatomic, strong) UIScrollView *emotionScrollView;
//表情键盘底部操作栏
@property (nonatomic, strong) UIView *emotionBottonBar;
//指示器
@property (nonatomic, strong) UIPageControl *emotionPgControl;
//表情按钮
@property (nonatomic, strong) UIButton *swtFaceButton;
//输入框
@property (nonatomic, strong) UITextView *msgTextView;
//表情资源
@property (nonatomic, strong) NSDictionary *emotionDict;

@end

@implementation CSChatKeyBoard


//表情资源plist (因为表情存在版权问题 , 所以这里的表情只用一个来代替)
- (NSDictionary *)emotionDict
{
    if (!_emotionDict) {
        _emotionDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"CSChatEmotions" ofType:@"plist"]];
    }
    return _emotionDict;
}

//pageControl
- (UIPageControl *)emotionPgControl
{
    if (!_emotionPgControl) {
        _emotionPgControl = [[UIPageControl alloc]init];
        _emotionPgControl.pageIndicatorTintColor = UICOLOR_RGB_Alpha(0xcecece, 1);
        _emotionPgControl.currentPageIndicatorTintColor = UICOLOR_RGB_Alpha(0x999999, 1);
    }
    return _emotionPgControl;
}


//表情键盘底部操作栏 (表情键盘底部的操作栏 , 可以添加更多的操作按钮 ,类似微信那样 , 只需要再添加 和facesKeyboard handleKeyboard平级的view即可 , 几个键盘来回切换)
- (UIView *)emotionBottonBar
{
    if (!_emotionBottonBar) {
        _emotionBottonBar = [[UIView alloc]init];
        _emotionBottonBar.backgroundColor = UIMainWhiteColor;
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.titleLabel.font = FontSet(14);
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [sendButton setTitleColor:UICOLOR_RGB_Alpha(0x333333, 1) forState:UIControlStateNormal];
        sendButton.frame = Frame(ScreenW - 75, 5, 60, 30);
        [sendButton addTarget:self action:@selector(sendEmotionMessage:) forControlEvents:UIControlEventTouchUpInside];
        ViewBorder(sendButton, UICOLOR_RGB_Alpha(0x333333, 1), 1);
        ViewRadius(sendButton, 5);
        [_emotionBottonBar addSubview:sendButton];
    }
    return _emotionBottonBar;
}

//表情滚动容器
- (UIScrollView *)emotionScrollView
{
    if (!_emotionScrollView) {
        _emotionScrollView = [[UIScrollView alloc]init];
        _emotionScrollView.backgroundColor = UIMainWhiteColor;
        _emotionScrollView.showsHorizontalScrollIndicator = NO;
        _emotionScrollView.pagingEnabled = YES;
        _emotionScrollView.delegate = self;
        //最多几列
        NSUInteger columnMaxCount = 8;
        //最多几行
        NSUInteger rowMaxCount = 3;
        //一页表情最多多少个
        NSUInteger emotionMaxCount = columnMaxCount *rowMaxCount;
        //左右边距
        CGFloat lrMargin = 15.f;
        //顶部边距
        CGFloat topMargin = 20.f;
        //宽高
        CGFloat widthHeight = 30.f;
        //中间间距
        CGFloat midMargin = (ScreenW - columnMaxCount*widthHeight - 2*lrMargin)/(columnMaxCount - 1);
        //计算一共多少页表情
        NSInteger pageCount = self.emotionDict.count / emotionMaxCount + (self.emotionDict.count %emotionMaxCount > 0 ? 1 : 0);
        //滑动范围
        _emotionScrollView.contentSize = CGSizeMake(pageCount *ScreenW, 0);
        
        //布局
        //当前第几个表情
        NSUInteger emotionIdx = 0;
        //index 当前第几页
        for (NSInteger index = 0; index < pageCount; index ++) {
            UIView *emotionContainer = [[UIView alloc]init];
            //添加表情按钮
            for (NSInteger i = 0; i < emotionMaxCount; i ++) {
                NSInteger row    = i % columnMaxCount;
                NSInteger colum = i / columnMaxCount;
                UIButton *emotionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                emotionBtn.tag = 999 + emotionIdx;
                NSString *emotionImgName = [self.emotionDict objectForKey:[NSString stringWithFormat:@"ChatEmotion_%li",emotionIdx]];
                if ([emotionImgName isEqualToString:@"[del_]"]) {
                    [emotionBtn setImage:LoadImage(emotionImgName) forState:UIControlStateNormal];
                }else{
                    [emotionBtn setTitle:emotionImgName forState:UIControlStateNormal];
                }
                
                emotionBtn.frame = Frame(lrMargin + row *(widthHeight + midMargin), topMargin + colum*(widthHeight + midMargin), widthHeight, widthHeight);
                [emotionBtn addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
                [emotionContainer addSubview:emotionBtn];
                emotionIdx ++ ;
            }
            [_emotionScrollView addSubview:emotionContainer];
        }
    }
    return _emotionScrollView;
}
//表情键盘
- (UIView *)facesKeyboard
{
    if (!_facesKeyboard) {
        _facesKeyboard = [[UIView alloc]init];
        _facesKeyboard.backgroundColor = UIMainWhiteColor;
        //添加表情滚动容器
        [_facesKeyboard addSubview:self.emotionScrollView];
        //添加底部操作栏
        [_facesKeyboard addSubview:self.emotionBottonBar];
        //指示器pageControl
        [_facesKeyboard addSubview:self.emotionPgControl];
    }
    return _facesKeyboard;
}

//自定义
- (UIView *)keyBoardContainer
{
    if (!_keyBoardContainer) {
        _keyBoardContainer = [[UIView alloc]init];
        [_keyBoardContainer addSubview:self.facesKeyboard];
    }
    return _keyBoardContainer;
}

//输入栏
- (UIView *)messageBar
{
    if (!_messageBar) {
        _messageBar = [[UIView alloc]init];
        _messageBar.backgroundColor = [UIColor blackColor];
        [_messageBar addSubview:self.msgTextView];
        [_messageBar addSubview:self.swtFaceButton];
    }
    return _messageBar;
}

//输入框
- (UITextView *)msgTextView
{
    if (!_msgTextView) {
        _msgTextView = [[UITextView alloc]init];
        _msgTextView.font = FontSet(14);
        _msgTextView.showsVerticalScrollIndicator = NO;
        _msgTextView.showsHorizontalScrollIndicator = NO;
        _msgTextView.returnKeyType = UIReturnKeySend;
        _msgTextView.enablesReturnKeyAutomatically = YES;
        _msgTextView.delegate = self;
        ViewRadius(_msgTextView, 5);
        //观察者监听高度变化
        [_msgTextView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return _msgTextView;
}



//表情切换按钮
- (UIButton *)swtFaceButton
{
    if (!_swtFaceButton) {
        _swtFaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_swtFaceButton setImage:LoadImage(@"表情") forState:UIControlStateNormal];
        [_swtFaceButton setImage:LoadImage(@"cs_live_keyboard_text") forState:UIControlStateSelected];
        [_swtFaceButton addTarget:self action:@selector(switchFaceKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _swtFaceButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.messageBar];
        [self addSubview:self.keyBoardContainer];
        //布局
        [self configUIFrame];
    }
    return self;
}

#pragma mark - 初始化布局
- (void)configUIFrame
{
    self.messageBar.frame = Frame(0, 0, ScreenW, defaultMsgBarHeight);  //消息栏
    self.swtFaceButton.frame = Frame(10, (Height(self.messageBar.frame) - 30)*0.5, 30, 30); ////表情键盘切换按钮
    self.msgTextView.frame = Frame(MaxX(self.swtFaceButton.frame)+15,(Height(self.messageBar.frame)-defaultInputHeight)*0.5, ScreenW - 70, defaultInputHeight); //输入框
     self.keyBoardContainer.frame = Frame(0,Height(self.messageBar.frame)+1, ScreenW,CTKEYBOARD_DEFAULTHEIGHT - Height(self.messageBar.frame)); //自定义键盘容器
    self.facesKeyboard.frame = self.keyBoardContainer.bounds ; //表情键盘部分
    
    //表情容器部分
    self.emotionScrollView.frame =Frame(0,0, ScreenW, Height(self.facesKeyboard.frame)-40); //表情滚动容器
    for (NSInteger index = 0; index < self.emotionScrollView.subviews.count; index ++) { //emotion容器
        UIView *emotionView = self.emotionScrollView.subviews[index];
        emotionView.frame = Frame(index *ScreenW, 0, ScreenW, Height(self.emotionScrollView.frame));
    }
    //页码
    self.emotionPgControl.numberOfPages = self.emotionScrollView.subviews.count;
    CGSize controlSize = [self.emotionPgControl sizeForNumberOfPages:self.emotionScrollView.subviews.count];
    self.emotionPgControl.frame = Frame((ScreenW - controlSize.width)*0.5,Height(self.emotionScrollView.frame)-controlSize.height, controlSize.width, controlSize.height); // pageControl
    self.emotionBottonBar.frame = Frame(0,MaxY(self.emotionScrollView.frame), ScreenW, 40); //底部操作栏  固定 40高度
}

#pragma mark - 系统键盘即将弹起
- (void)systemKeyboardWillShow:(NSNotification *)note
{
    //重置所有按钮selected
    [self reloadSwitchButtons];
    //获取系统键盘高度
    CGFloat systemKbHeight  = [note.userInfo[@"UIKeyboardBoundsUserInfoKey"]CGRectValue].size.height - kSafeAreaBottomHeight;
    //记录系统键盘高度
    keyboardHeight = systemKbHeight;
    //将自定义键盘跟随位移
    [self customKeyboardMove:self.containerHeight - systemKbHeight - Height(self.messageBar.frame)];
}

#pragma mark - 系统键盘即将消失
- (void)systemKeyboardWillHidden:(NSNotification *)note{
    //将自定义键盘跟随位移
    [self customKeyboardMove:self.containerHeight - Height(self.messageBar.frame)];
}

#pragma mark - 切换到表情键盘
- (void)switchFaceKeyboard:(UIButton *)swtFaceButton
{
    swtFaceButton.selected = !swtFaceButton.selected;
    //重置其他按钮seleted
    //更新记录键盘高度
    keyboardHeight = Height(self.keyBoardContainer.frame);
    
    if (swtFaceButton.selected) {
        _msgTextView.hidden = NO;
        [_msgTextView resignFirstResponder];
        //展示表情键盘
        [self.keyBoardContainer bringSubviewToFront:self.facesKeyboard];
        //自定义键盘位移
        [self customKeyboardMove:self.containerHeight - Height(self.frame)];
    }else{
        [_msgTextView becomeFirstResponder];
    }
}

#pragma mark - 自定义键盘位移变化
- (void)customKeyboardMove:(CGFloat)customKbY
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = Frame(0,customKbY, ScreenW, Height(self.frame));
    } completion:^(BOOL finished) {
//        if (self.frameCallback) {
//            self.frameCallback(self.frame);
//        }
    }];
    
    if (self.frameCallback) {
        self.frameCallback(self.frame);
    }
    
}

#pragma mark - 监听输入框变化 (这里如果放到layout里自动让他布局 , 会稍显麻烦一些 , 所以自动手动控制一下)
//这里用contentSize计算较为简单和精确 , 如果计算文字高度 ,  还需要加上textView的内间距.
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGFloat oldHeight  = [change[@"old"]CGSizeValue].height;
    CGFloat newHeight = [change[@"new"]CGSizeValue].height;
    if (oldHeight <=0 || newHeight <=0) return;
    NSLog(@"------new ----%@",change[@"new"]);
    NSLog(@"-------old ---%@",change[@"old"]);
    if (newHeight != oldHeight) {
        NSLog(@"高度变化");
        //根据实时的键盘高度进行布局
        CGFloat inputHeight = newHeight > defaultInputHeight ? newHeight : defaultInputHeight;
        [self msgTextViewHeightFit:inputHeight];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //删除键监听
    if ([text isEqualToString:@""""]) {
        
        NSLog(@"----------------点击了系统键盘删除键");
        //系统键盘删除
        [self keyboardDelete];
        return NO;
        
    //发送键监听
    }else if ([text isEqualToString:@"\n"]){
        
        //发送普通文本消息
        [self sendTextMessage];
        return NO;
    }
    return YES;
}

#pragma mark - 切换按钮初始化
- (void)reloadSwitchButtons
{
    self.swtFaceButton.selected    = NO;
}

#pragma mark - 输入框高度调整
- (void)msgTextViewHeightFit:(CGFloat)msgViewHeight
{
    self.messageBar.frame = Frame(0, 0, ScreenW, msgViewHeight +MinY(self.msgTextView.frame)*2);
    self.msgTextView.frame = Frame(MinX(self.msgTextView.frame),(Height(self.messageBar.frame)-msgViewHeight)*0.5, Width(self.msgTextView.frame), msgViewHeight);
    self.keyBoardContainer.frame = Frame(0, MaxY(self.messageBar.frame), ScreenW, Height(self.keyBoardContainer.frame));
    self.frame = Frame(0,self.containerHeight - keyboardHeight-Height(self.messageBar.frame), ScreenW,Height(self.keyBoardContainer.frame) + Height(self.messageBar.frame));
}

#pragma mark - 点击表情
- (void)emotionClick:(UIButton *)emotionBtn
{
    //获取点击的表情
    NSString *emotionKey = [NSString stringWithFormat:@"ChatEmotion_%li",emotionBtn.tag - 999];
    NSString *emotionName = [self.emotionDict objectForKey:emotionKey];
    
    //判断是删除 ， 还是点击了正常的emotion表情
    if ([emotionName isEqualToString:@"[del_]"]) {
        
        //表情键盘删除
        [self keyboardDelete];
        
    }else{ //点击表情
        
        //获取光标所在位置
        NSInteger location = self.msgTextView.selectedRange.location;
        //变为可变字符串
        NSMutableString *txtStrM = [[NSMutableString alloc]initWithString:self.msgTextView.text];
        [txtStrM insertString:emotionName atIndex:location];
        self.msgTextView.text = txtStrM;
        //光标后移
        self.msgTextView.selectedRange = NSMakeRange(location + emotionName.length, 0);
        NSLog(@"--------当前点击了表情 : ------------------%@",emotionName);
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.emotionPgControl.currentPage = scrollView.contentOffset.x / ScreenW;
}

#pragma mark - 表情发送按钮点击
- (void)sendEmotionMessage:(UIButton *)emotionSendBtn
{
    [self sendTextMessage];
}

#pragma mark - 键盘删除内容
- (void)keyboardDelete
{
    
    NSMutableString *txtStrM = [[NSMutableString alloc]initWithString:self.msgTextView.text];
    //当前光标位置
    NSInteger location = self.msgTextView.selectedRange.location;
    if (!txtStrM.length) return;
    
    //正则检测是否存在表情
    NSRegularExpression *pression = [NSRegularExpression regularExpressionWithPattern:@"\\[[^\\[\\]]*\\]" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSArray *results = [pression matchesInString:self.msgTextView.text options:NSMatchingReportProgress range:NSMakeRange(0, self.msgTextView.text.length)];
    //检测光标前是否有表情
    __block BOOL deleteEmotion = NO;
    [results enumerateObjectsUsingBlock:^(NSTextCheckingResult  *_Nonnull checkResult, NSUInteger idx, BOOL * _Nonnull stop) {
        //光标前面有表情
        if (checkResult.range.location + checkResult.range.length == location) {
            
            NSLog(@"-------光标前是表情------------");
            [txtStrM replaceCharactersInRange:checkResult.range withString:@""];
            self.msgTextView.text = txtStrM;
            //光标前移
            self.msgTextView.selectedRange = NSMakeRange(location - checkResult.range.length, 0);
            deleteEmotion = YES;
            *stop = YES;
        }
    }];
    
    //如果光标前没有表情
    if (!deleteEmotion) {
        [self.msgTextView deleteBackward];
        return;
        [txtStrM replaceCharactersInRange:NSMakeRange(txtStrM.length-1, 1) withString:@""];
        self.msgTextView.text = txtStrM;
        //光标前移
        self.msgTextView.selectedRange = NSMakeRange(location - 1, 0);
    }
}

#pragma mark - 发送文本/表情消息
- (void)sendTextMessage
{
    if (self.msgTextView.text.length == 0) {
        return;
    }
    //回调
    if (_textCallback) {
        _textCallback(self.msgTextView.text);
         self.msgTextView.text = @"";
        //更新输入框
        [self msgTextViewHeightFit:defaultInputHeight];
    }
}

#pragma mark - 消息回调
- (void)textCallback:(ChatTextMessageSendBlock)textCallback audioCallback:(ChatAudioMesssageSendBlock)audioCallback picCallback:(ChatPictureMessageSendBlock)picCallback videoCallback:(ChatVideoMessageSendBlock)videoCallback target:(id)target
{
    _textCallback     = textCallback;
    _audioCallback   = audioCallback;
    _pictureCallback = picCallback;
    _videoCallback   = videoCallback;
    _target              = target;
}

- (void)frameChangeCallback:(CSKeyBoardFrameChangeBlock)frameCallback
{
    _frameCallback = frameCallback;
}

- (void)dealloc
{
    [self.msgTextView removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark - 键盘降落
- (void)keyboardResignFirstResponder:(NSNotification *)note
{
    if ([self.msgTextView isFirstResponder]) {
        [self.msgTextView resignFirstResponder];
        //按钮初始化刷新
        [self reloadSwitchButtons];
        [self customKeyboardMove:self.containerHeight - Height(self.messageBar.frame)];
    }
    
    if (self.swtFaceButton.selected) {
        [self reloadSwitchButtons];
        [self customKeyboardMove:self.containerHeight - Height(self.messageBar.frame)];
    }
    
}

@end
