//

//

#import <UIKit/UIKit.h>

/*alertviewBlock */
typedef void (^AlertViewBlock)(id sender);
typedef void (^ClickBtnBlock)(NSInteger nIndex);

/*对AlertView的扩展，confirmBlock为真得时候有确定按钮，cancelBlock为真得时候有取消按钮，都不为真得时候是自动消失按钮*/

@interface LYAlertView : UIAlertView<UIAlertViewDelegate>

- (id)initWithTitle:(NSString *)title message:(NSString *)message leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle clickBtnBlock:(ClickBtnBlock)clickBtnBlock;

- (id)initWithTitle:(NSString *)title message:(NSString *)message confirmBlock:(AlertViewBlock)confirmBlock cancelBlock:(AlertViewBlock)cancelBlock;

- (id)initWithTitle:(NSString *)title message:(NSString *)message dismissSecond:(NSInteger)second dismissBlock:(AlertViewBlock)dismissBlock;
@end
