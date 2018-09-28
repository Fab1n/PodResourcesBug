#  CocoaPods 1.5.3 Copy resources build script phase bug

### Setup to reproduce mentioned bugs:
- Xcode 10.0 (10A255)
- cocoapods 1.5.3

## Bug 1: Xcode 10 does not execute `[CP] Copy Pods Resources` build phase

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


## Bug 2: Multiple `.xcassets` files compiled in `[CP] Copy Pods Resources` build phase

**How to check the expected results?**
You just need to build and check the build logs of the last executed build

**Steps to reproduce**:
- Have the project cloned
- Switch to branch `#doubleXCAssetBug`
- Build the project and look at the logs output

**Expected result:**
The log output only should print the following:

```
-----------------------------------
/Users/<your_username>/<path_to_repo>/PodResourcesBug/Pods/PKHUD/PKHUD/Images.xcassets
/Users/<your_username>/<path_to_repo>/PodResourcesBug/PodResourcesBug/Assets.xcassets
-----------------------------------
```

**Actual result:**
The log output contains the following, indicating the `.xcassets`  folders filtering has failed:

```
-----------------------------------
/Users/<your_username>/<path_to_repo>/PodResourcesBug/Pods/PKHUD/PKHUD/Images.xcassets
/Users/<your_username>/<path_to_repo>/PodResourcesBug/Pods/PKHUD/PKHUD/Images.xcassets
/Users/<your_username>/<path_to_repo>/PodResourcesBug/PodResourcesBug/Assets.xcassets
-----------------------------------
```

**Explanation:**
The responsible code could be found in `Pods-PodResourcesBug-resources.sh`:
```
# Find all other xcassets (this unfortunately includes those of path pods and other targets).
OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
while read line; do
    if [[ $line != "${PODS_ROOT}*" ]]; then
        XCASSET_FILES+=("$line")
    fi
done <<<"$OTHER_XCASSETS"
```

The test `[[ $line != "${PODS_ROOT}*" ]];` does not seem to work when comparing strings.

**Test fix:**
Switch to the branch `fixDoubleXCAssetBug`.
Build.
The build output should contain the expected result and filtering should have worked.
