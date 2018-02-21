#import "MGLNSExpressionBuilder.h"

const MGLExpressionStyleFunction MGLExpressionStyleFunctionZoomLevel = @"$zoomLevel";
const MGLExpressionStyleFunction MGLExpressionStyleFunctionHeatmapDensity = @"$heatmapDensity";

const MGLExpressionInterpolationMode MGLExpressionInterpolationModeLinear = @"linear";
const MGLExpressionInterpolationMode MGLExpressionInterpolationModeExponential = @"exponential";
const MGLExpressionInterpolationMode MGLExpressionInterpolationModeCubicBezier = @"cubic-bezier";

@implementation MGLNSExpressionBuilder

- (instancetype)initWithExpression:(NSExpression *)expression
{
    self = [super init];
    if (self) {
        _expression = expression;
    }
    return self;
}

+ (instancetype)expressionBuilderWithString:(NSString *)string
{
    if (string) {
        return [MGLNSExpressionBuilder expressionBuilderWithExpression:[NSExpression expressionForConstantValue:string]];
    }
    
    return nil;
}

+ (instancetype)expressionBuilderWithValue:(NSValue *)value
{
    if (value) {
        return [MGLNSExpressionBuilder expressionBuilderWithExpression:[NSExpression expressionForConstantValue:value]];
    }
    return nil;
}

+ (instancetype)expressionBuilderWithColor:(MGLColor *)color
{
    if (color) {
        return [MGLNSExpressionBuilder expressionBuilderWithExpression:[NSExpression expressionWithFormat:@"%@", color]];
    }
    return nil;
}

+ (instancetype)expressionBuilderWithExpression:(NSExpression *)expression
{
    if (expression) {
        MGLNSExpressionBuilder *expressionBuilder = [[[MGLNSExpressionBuilder alloc] init] initWithExpression:expression];
        return expressionBuilder;
    }
    return nil;
}

+ (instancetype)expressionBuilderWithFunction:(nonnull MGLExpressionStyleFunction)function minimum:(NSValue *)minimum steps:(nonnull NS_DICTIONARY_OF(NSNumber *, id) *)steps
{
    NSExpression *expression = [NSExpression expressionWithFormat:@"FUNCTION($%@, 'mgl_stepWithMinimum:stops:', %@, %@)", function, minimum, steps];
    MGLNSExpressionBuilder *expressionBuilder = [[[MGLNSExpressionBuilder alloc] init] initWithExpression:expression];
    return expressionBuilder;
}

+ (instancetype)expressionBuilderWithFunction:(nonnull MGLExpressionStyleFunction)function interpolateCurveType:(nonnull MGLExpressionInterpolationMode)curveType parameters:(nullable NSDictionary*)parameters steps:(nonnull NS_DICTIONARY_OF(NSNumber *, id) *)steps
{
    NSString *functionFormat = [NSString stringWithFormat:@"FUNCTION(%@, 'mgl_interpolateWithCurveType:parameters:stops:', %%@, %%@, %%@)", function];
    NSExpression *expression = [NSExpression expressionWithFormat:functionFormat, curveType, parameters, steps];
    MGLNSExpressionBuilder *expressionBuilder = [[[MGLNSExpressionBuilder alloc] init] initWithExpression:expression];
    return expressionBuilder;
}

+ (instancetype)expressionBuilderWithTernaryCondition:(NSExpression *)condition trueExpression:(NSExpression *)trueExpression defaultExpression:(NSExpression *)defaultExpression
{
    NSExpression *expression = [NSExpression expressionWithFormat:@"TERNARY(%@, %@, %@)", condition, trueExpression, defaultExpression];
    MGLNSExpressionBuilder *expressionBuilder = [[[MGLNSExpressionBuilder alloc] init] initWithExpression:expression];
    return expressionBuilder;
}

- (instancetype)appendString:(NSString *)string
{
    if (string) {
        _expression = [NSExpression expressionWithFormat:@"FUNCTION(%@, 'stringByAppendingString:', %@)", self.expression, string];
    }
    return self;
}

- (instancetype)appendExpression:(NSExpression *)expression
{
    if (expression) {
        return [self appendString:[expression expressionValueWithObject:nil context:nil]];
    }
    return nil;
}


@end
