#import <Foundation/Foundation.h>
#import "MGLTypes.h"

NS_ASSUME_NONNULL_BEGIN

@class MGLColor;

typedef NSString *MGLExpressionStyleFunction NS_STRING_ENUM;
typedef NSString *MGLExpressionInterpolationMode NS_STRING_ENUM;

extern MGL_EXPORT const MGLExpressionStyleFunction MGLExpressionStyleFunctionZoomLevel;
extern MGL_EXPORT const MGLExpressionStyleFunction MGLExpressionStyleFunctionHeatmapDensity;

extern MGL_EXPORT const MGLExpressionInterpolationMode MGLInterpolateCurveTypeLinear;
extern MGL_EXPORT const MGLExpressionInterpolationMode MGLInterpolateCurveTypeExponential;
extern MGL_EXPORT const MGLExpressionInterpolationMode MGLInterpolateCurveTypeCubicBezier;

MGL_EXPORT
@interface MGLNSExpressionBuilder : NSObject

@property (nonatomic, strong, readonly) NSExpression *expression;

- (instancetype)initWithExpression:(NSExpression *)expression;

+ (instancetype)expressionBuilderWithString:(nonnull NSString *)string;
+ (instancetype)expressionBuilderWithValue:(nonnull NSValue *)value;
+ (instancetype)expressionBuilderWithColor:(nonnull MGLColor *)color;
+ (instancetype)expressionBuilderWithExpression:(nonnull NSExpression *)expression;
+ (instancetype)expressionBuilderWithFunction:(nonnull MGLExpressionStyleFunction)function minimum:(NSValue *)minimum steps:(nonnull NS_DICTIONARY_OF(NSNumber *, id) *)steps;
+ (instancetype)expressionBuilderWithFunction:(nonnull MGLExpressionStyleFunction)function interpolateCurveType:(nonnull MGLExpressionInterpolationMode)curveType parameters:(nullable NSDictionary*)parameters steps:(nonnull NS_DICTIONARY_OF(NSNumber *, id) *)steps;
+ (instancetype)expressionBuilderWithTernaryCondition:(NSExpression *)condition trueExpression:(NSExpression *)trueExpression defaultExpression:(NSExpression *)defaultExpression;

- (instancetype)appendString:(nonnull NSString *)string;
- (instancetype)appendExpression:(NSExpression *)expression;

@end

NS_ASSUME_NONNULL_END
