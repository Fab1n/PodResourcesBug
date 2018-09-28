#  CocoaPods 1.5.3 Copy resources build script phase bug

### Setup to reproduce mentioned bugs:
- Xcode 10.0 (10A255)
- cocoapods 1.5.3

### Bug 1: Xcode 10 does not execute `[CP] Copy Pods Resources` build phase

**How to check the expected results?**
In Simulator check the expected result.

2 images should be displayed below each other:
- The top image comes from the app's asset catalog
- The bottom image comes from the pod's asset catalog

**Steps to reproduce**:
- Clone this project
- Make sure you are on branch #master
- Build and run the project

**Expected result:**
Both images should be displayed

**Actual result:**
Only the top image is displayed (the image in the app's bundle)

**Explanation:**
If you look at the build log you won't find `[CP] Copy Pods Resources`.
That is because Xcode 10 builds `Assets.car` and the build system checks the `Output Files` paths in the run script phase. And because these are identical Xcode skips the build phase.

**Test fix:**
To test the fix, switch to the branch `fixRunCopyResources`.
Build and run. 
Both images should be displayed!
