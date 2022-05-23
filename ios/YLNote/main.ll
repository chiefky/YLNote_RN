; ModuleID = 'main.m'
source_filename = "main.m"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-ios14.4.0-simulator"

%0 = type opaque
%struct._class_t = type { %struct._class_t*, %struct._class_t*, %struct._objc_cache*, i8* (i8*, i8*)**, %struct._class_ro_t* }
%struct._objc_cache = type opaque
%struct._class_ro_t = type { i32, i32, i32, i8*, i8*, %struct.__method_list_t*, %struct._objc_protocol_list*, %struct._ivar_list_t*, i8*, %struct._prop_list_t* }
%struct.__method_list_t = type { i32, i32, [0 x %struct._objc_method] }
%struct._objc_method = type { i8*, i8*, i8* }
%struct._objc_protocol_list = type { i64, [0 x %struct._protocol_t*] }
%struct._protocol_t = type { i8*, i8*, %struct._objc_protocol_list*, %struct.__method_list_t*, %struct.__method_list_t*, %struct.__method_list_t*, %struct.__method_list_t*, %struct._prop_list_t*, i32, i32, i8**, i8*, %struct._prop_list_t* }
%struct._ivar_list_t = type { i32, i32, [0 x %struct._ivar_t] }
%struct._ivar_t = type { i64*, i8*, i8*, i32, i32 }
%struct._prop_list_t = type { i32, i32, [0 x %struct._prop_t] }
%struct._prop_t = type { i8*, i8* }

@"OBJC_CLASS_$_AppDelegate" = external global %struct._class_t
@"OBJC_CLASSLIST_REFERENCES_$_" = internal global %struct._class_t* @"OBJC_CLASS_$_AppDelegate", section "__DATA,__objc_classrefs,regular,no_dead_strip", align 8
@llvm.compiler.used = appending global [1 x i8*] [i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_" to i8*)], section "llvm.metadata"
; Function Attrs: noinline optnone ssp uwtable
define i32 @main(i32 %0, i8** %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca %0*, align 8
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  store %0* null, %0** %6, align 8
  %7 = call i8* @llvm.objc.autoreleasePoolPush() #1
  %8 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_", align 8
  %9 = bitcast %struct._class_t* %8 to i8*
  %10 = call i8* @objc_opt_class(i8* %9)
  %11 = call %0* @NSStringFromClass(i8* %10)
  %12 = bitcast %0* %11 to i8*
  %13 = notail call i8* @llvm.objc.retainAutoreleasedReturnValue(i8* %12) #1
  %14 = bitcast i8* %13 to %0*
  %15 = load %0*, %0** %6, align 8
  store %0* %14, %0** %6, align 8
  %16 = bitcast %0* %15 to i8*
  call void @llvm.objc.release(i8* %16) #1, !clang.imprecise_release !10
  call void @llvm.objc.autoreleasePoolPop(i8* %7)
  %17 = load i32, i32* %4, align 4
  %18 = load i8**, i8*** %5, align 8
  %19 = load %0*, %0** %6, align 8
  %20 = call i32 @UIApplicationMain(i32 %17, i8** %18, %0* null, %0* %19)
  store i32 %20, i32* %3, align 4
  %21 = bitcast %0** %6 to i8**
  call void @llvm.objc.storeStrong(i8** %21, i8* null) #1
  %22 = load i32, i32* %3, align 4
  ret i32 %22
}
; Function Attrs: nounwind
declare i8* @llvm.objc.autoreleasePoolPush() #1
declare %0* @NSStringFromClass(i8*) #2
declare i8* @objc_opt_class(i8*)
; Function Attrs: nounwind
declare i8* @llvm.objc.retainAutoreleasedReturnValue(i8*) #1
; Function Attrs: nounwind
declare void @llvm.objc.release(i8*) #1
; Function Attrs: nounwind
declare void @llvm.objc.autoreleasePoolPop(i8*) #1
declare i32 @UIApplicationMain(i32, i8**, %0*, %0*) #2
; Function Attrs: nounwind
declare void @llvm.objc.storeStrong(i8**, i8*) #1

attributes #0 = { noinline optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 14, i32 4]}
!1 = !{i32 1, !"Objective-C Version", i32 2}
!2 = !{i32 1, !"Objective-C Image Info Version", i32 0}
!3 = !{i32 1, !"Objective-C Image Info Section", !"__DATA,__objc_imageinfo,regular,no_dead_strip"}
!4 = !{i32 4, !"Objective-C Garbage Collection", i32 0}
!5 = !{i32 1, !"Objective-C Is Simulated", i32 32}
!6 = !{i32 1, !"Objective-C Class Properties", i32 64}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{i32 7, !"PIC Level", i32 2}
!9 = !{!"Apple clang version 12.0.0 (clang-1200.0.32.29)"}
!10 = !{}
