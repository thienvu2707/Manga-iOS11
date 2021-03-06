// Generated by Apple Swift version 4.1.2 effective-3.3.2 (swiftlang-902.0.54 clang-902.0.39.2)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR __attribute__((enum_extensibility(open)))
# else
#  define SWIFT_ENUM_ATTR
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import ObjectiveC;
@import Dispatch;
@import Foundation;
#endif

#import <PromiseKit/PromiseKit.h>

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="PromiseKit",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif


/// AnyPromise is an Objective-C compatible promise.
SWIFT_CLASS_NAMED("AnyPromise")
@interface AnyPromise : NSObject
/// <ul>
///   <li>
///     See: <code>Promise.catch()</code>
///   </li>
/// </ul>
- (void)catchOn:(dispatch_queue_t _Nonnull)q policy:(enum PMKCatchPolicy)policy execute:(void (^ _Nonnull)(NSError * _Nonnull))body;
/// A promise starts pending and eventually resolves.
///
/// returns:
/// <code>true</code> if the promise has not yet resolved.
@property (nonatomic, readonly) BOOL pending;
/// A promise starts pending and eventually resolves.
///
/// returns:
/// <code>true</code> if the promise has resolved.
@property (nonatomic, readonly) BOOL resolved;
/// Creates a resolved promise.
/// When developing your own promise systems, it is occasionally useful to be able to return an already resolved promise.
/// \param value The value with which to resolve this promise. Passing an <code>NSError</code> will cause the promise to be rejected, passing an AnyPromise will return a new AnyPromise bound to that promise, otherwise the promise will be fulfilled with the value passed.
///
///
/// returns:
/// A resolved promise.
+ (AnyPromise * _Nonnull)promiseWithValue:(id _Nullable)value SWIFT_WARN_UNUSED_RESULT;
/// Create a new promise that resolves with the provided block.
/// Use this method when wrapping asynchronous code that does <em>not</em> use promises so that this code can be used in promise chains.
/// If <code>resolve</code> is called with an <code>NSError</code> object, the promise is rejected, otherwise the promise is fulfilled.
/// Don’t use this method if you already have promises! Instead, just return your promise.
/// Should you need to fulfill a promise but have no sensical value to use: your promise is a <code>void</code> promise: fulfill with <code>nil</code>.
/// The block you pass is executed immediately on the calling thread.
/// warning:
/// Resolving a promise with <code>nil</code> fulfills it.
/// seealso:
/// http://promisekit.org/sealing-your-own-promises/
/// seealso:
/// http://promisekit.org/wrapping-delegation/
/// \param block The provided block is immediately executed, inside the block call <code>resolve</code> to resolve this promise and cause any attached handlers to execute. If you are wrapping a delegate-based system, we recommend instead to use: initWithResolver:
///
///
/// returns:
/// A new promise.
+ (AnyPromise * _Nonnull)promiseWithResolverBlock:(SWIFT_NOESCAPE void (^ _Nonnull)(void (^ _Nonnull)(id _Nullable)))body SWIFT_WARN_UNUSED_RESULT;
- (AnyPromise * _Nonnull)__thenOn:(dispatch_queue_t _Nonnull)q execute:(id _Nullable (^ _Nonnull)(id _Nullable))body SWIFT_WARN_UNUSED_RESULT;
- (AnyPromise * _Nonnull)__catchOn:(dispatch_queue_t _Nonnull)q withPolicy:(enum PMKCatchPolicy)policy execute:(id _Nullable (^ _Nonnull)(id _Nullable))body SWIFT_WARN_UNUSED_RESULT;
- (AnyPromise * _Nonnull)__alwaysOn:(dispatch_queue_t _Nonnull)q execute:(void (^ _Nonnull)(void))body SWIFT_WARN_UNUSED_RESULT;
/// used by PMKWhen and PMKJoin
- (void)__pipe:(void (^ _Nonnull)(id _Nullable))body;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface AnyPromise (SWIFT_EXTENSION(PromiseKit))
///
/// returns:
/// A description of the state of this promise.
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
@end


@interface NSError (SWIFT_EXTENSION(PromiseKit))
+ (NSError * _Nonnull)cancelledError SWIFT_WARN_UNUSED_RESULT;
/// warning:
/// You must call this method before any promises in your application are rejected. Failure to ensure this may lead to concurrency crashes.
/// warning:
/// You must call this method on the main thread. Failure to do this may lead to concurrency crashes.
+ (void)registerCancelledErrorDomain:(NSString * _Nonnull)domain code:(NSInteger)code;
///
/// returns:
/// true if the error represents cancellation.
@property (nonatomic, readonly) BOOL isCancelled;
@end

#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
