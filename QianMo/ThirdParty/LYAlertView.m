//

//

#define CONFIRM_BUTTON_TITLE @"确定"
#define CANCEL_BUTTON_TITLE @"取消"

#define Has_Not_Message @"请输入提示信息"

#import "LYAlertView.h"

@interface LYAlertView()
{
    AlertViewBlock _confirmBlock;
    AlertViewBlock _cancelBlock;
    AlertViewBlock _dismissBlock;
    ClickBtnBlock _clickBtnBlock;
}

@property (nonatomic,assign) NSInteger dismissSecond;

@end

@implementation LYAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle clickBtnBlock:(ClickBtnBlock)clickBtnBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.title = title? title : nil;
        
        if (title == nil)
        {
            NSString *tempStr = message? message : Has_Not_Message;
            NSString *messageStr = [NSString stringWithFormat:@"\n%@",tempStr];
            self.message = messageStr;
        }
        else
        {
            self.message = message;
        }
        self.delegate = self;
        if (clickBtnBlock == nil)
        {
            /*自动消失提示框*/
            /*创建timer，创建成功自动加到RunLoop队列里*/
            [NSTimer scheduledTimerWithTimeInterval:_dismissSecond?_dismissSecond:1.5f target:self selector:@selector(performDismissAlert:) userInfo:self repeats:NO];
        }
        else
        {
            _clickBtnBlock = clickBtnBlock;
        }
        
        if (leftBtnTitle && rightBtnTitle)
        {
            /*有确定按钮和取消按钮的提示框,第一个buttonIndex是0，第二个是1*/
            [self addButtonWithTitle:leftBtnTitle];
            [self addButtonWithTitle:rightBtnTitle];
        }
        else if (leftBtnTitle)
        {
            /*只有确定按钮的提示框*/
            [self addButtonWithTitle:leftBtnTitle];
        }
        else
        {
            /*只有取消按钮的提示框*/
            [self addButtonWithTitle:rightBtnTitle];
        }
    }
    return self;

}

- (id)initWithTitle:(NSString *)title message:(NSString *)message confirmBlock:(AlertViewBlock)confirmBlock cancelBlock:(AlertViewBlock)cancelBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.title = title? title : nil;
 
        if (title == nil)
        {
            NSString *tempStr = message? message : Has_Not_Message;
            NSString *messageStr = [NSString stringWithFormat:@"\n%@",tempStr];
            self.message = messageStr;
        }
        else
        {
            self.message = message;
        }
        self.delegate = self;
        if (confirmBlock == nil && cancelBlock == nil)
        {
            /*自动消失提示框*/
            /*创建timer，创建成功自动加到RunLoop队列里*/
            [NSTimer scheduledTimerWithTimeInterval:_dismissSecond?_dismissSecond:1.5f target:self selector:@selector(performDismissAlert:) userInfo:self repeats:NO];
        }
        else if (confirmBlock && cancelBlock)
        {
            /*有确定按钮和取消按钮的提示框,第一个buttonIndex是0，第二个是1*/
            _confirmBlock = confirmBlock;
            _cancelBlock = cancelBlock;
            [self addButtonWithTitle:CONFIRM_BUTTON_TITLE];
            [self addButtonWithTitle:CANCEL_BUTTON_TITLE];
        }
        else if (confirmBlock)
        {
            /*只有确定按钮的提示框*/
            _confirmBlock = confirmBlock;
            [self addButtonWithTitle:CONFIRM_BUTTON_TITLE];
        }
        else
        {
            /*只有取消按钮的提示框*/
            _cancelBlock = cancelBlock;
            [self addButtonWithTitle:CANCEL_BUTTON_TITLE];
        }
    }
    return self;
}

/*自动消失对话框，消失对话框函数*/
-(void)performDismissAlert:(NSTimer *)timer
{
    UIAlertView *alertView = (UIAlertView *)[timer userInfo];
    [alertView dismissWithClickedButtonIndex:0 animated:NO];
    if (_dismissBlock) {
        _dismissBlock(self);
    }
}

#pragma mark - AlertViewDelegate

/*点击按钮事件，只有一个按钮或两个按钮的情况下才会执行*/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_clickBtnBlock)
    {
        _clickBtnBlock(buttonIndex);
    }

    
    if ([self numberOfButtons] == 2)
    {
        if (buttonIndex == 0) {
            if (_confirmBlock)
            {
                _confirmBlock(self);
            }
        }
        else
        {
            if (_cancelBlock) {
                _cancelBlock(self);
            }
        }
    }
    else
    {
        if (_confirmBlock) {
            _confirmBlock(self);
        }
        else
        {
            _cancelBlock(self);
        }
    }
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message dismissSecond:(NSInteger)second dismissBlock:(AlertViewBlock)dismissBlock
{
    _dismissSecond = second;
    self = [self initWithTitle:title message:message confirmBlock:nil cancelBlock:nil];
    if (self)
    {
        _dismissBlock = dismissBlock;
    }
    
    return self;
}
@end
