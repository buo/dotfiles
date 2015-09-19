<a name="v0.15.0"></a>
# v0.15.0 (2015-09-14)

## Features

- Add optional percent support for hsl, hsla, hsb, hsba, hsv, hsva, hwb and gray expressions ([dd97b2ec](https://github.com/abe33/atom-pigments/commit/dd97b2ec4b982b26206a975b6d89f8e515c2607b))

<a name="v0.14.0"></a>
# v0.14.0 (2015-09-08)

## Features

- Add support for HSB color space ([00875c23](https://github.com/abe33/atom-pigments/commit/00875c2310562fe82455337d6a3735949e2fee1d), [#85](https://github.com/abe33/atom-pigments/issues/85))
  <br>Based on what wikipedia says, HSB is an alias for HSV.
- Add support for fade-out/fade_out and fade-in/fade_in sass functions ([6ae33a3e](https://github.com/abe33/atom-pigments/commit/6ae33a3e3d180967e9e81d9bb3d574b2d73683a6), [#84](https://github.com/abe33/atom-pigments/issues/84))

<a name="v0.13.2"></a>
# v0.13.2 (2015-09-01)

## Bug Fixes

- Fix callback binding in search results ([447fe35b](https://github.com/abe33/atom-pigments/commit/447fe35b45cc9bcf249df46f93bfea68aded4d68))

## Other

- Bump markers version ([9d15495a](https://github.com/abe33/atom-pigments/commit/9d15495a2607f39695dc7430b7863052f2a88a32))

<a name="v0.13.1"></a>
# v0.13.1 (2015-09-01)

## Bug Fixes

- Fix backslash escaping preventing to open files on windows ([0874de30](https://github.com/abe33/atom-pigments/commit/0874de30e26297aa5ee58221c4de19c0f18c1cf7), [#68](https://github.com/abe33/atom-pigments/issues/68))
- Fix error raised when a change force a range check on a destroyed marker ([dfcb055d](https://github.com/abe33/atom-pigments/commit/dfcb055d9d0ad417b3bee53a5e7dfadf0586b023), [#74](https://github.com/abe33/atom-pigments/issues/74))
- Fix error raised when there's no screen line for a marker ([f187e6c8](https://github.com/abe33/atom-pigments/commit/f187e6c88d5d3626187f1da081c7b20e172d1594), [#73](https://github.com/abe33/atom-pigments/issues/73))
- Fix find view font not following find-and-replace style ([9db9ff28](https://github.com/abe33/atom-pigments/commit/9db9ff283772d7681bb0bfd1bf4433fe83226e01), [#78](https://github.com/abe33/atom-pigments/issues/78))
- Fix marker classes not properly removed when type change ([3b2b6dd2](https://github.com/abe33/atom-pigments/commit/3b2b6dd29a36ad5b0092212cf29aef0805d6ba14), [#80](https://github.com/abe33/atom-pigments/issues/80))
- Fix palette using flawed javascript sort ([df242f8f](https://github.com/abe33/atom-pigments/commit/df242f8ff03e4a0f917d968f7a38c556778f9fbe))

<a name="v0.13.0"></a>
# v0.13.0 (2015-08-31)

## Features

- Implement project settings to ignore global config ([f9d3d168](https://github.com/abe33/atom-pigments/commit/f9d3d168840a7ade4626c0b9c7ad120271225b14))
- Implement project level support of extended search names ([d5aacf13](https://github.com/abe33/atom-pigments/commit/d5aacf132d7d0336a75dd3a7d4d659a1ef991cb0))
- Implement falling back to defaults whenever a value is invalid ([135b9564](https://github.com/abe33/atom-pigments/commit/135b9564985f54cad89e722f60634ad13efcc477))
- Implement sorting paths when building the evaluation context ([91570135](https://github.com/abe33/atom-pigments/commit/915701350a9b49ad730fd7c70b4fc9830b9b84dc), [#79](https://github.com/abe33/atom-pigments/issues/79))  <br>The variables are sorted based on a reference path and end up as below:
  - variables from the other root paths
  - variables from the same root path
  - variables from the same path
- Implement watching for themes changes when includeThemes is set ([643f3aa6](https://github.com/abe33/atom-pigments/commit/643f3aa6390066bff28d7a273a389d39ea6d1fe9))
- Add regular expression highlighting in corresponding text editor ([daaa176e](https://github.com/abe33/atom-pigments/commit/daaa176e75c9acfa10a469c2b67da4a3db1b5908))

## Bug Fixes

- Fix ignored scopes not honored on buffer initialization ([a681ebfa](https://github.com/abe33/atom-pigments/commit/a681ebfa381bc54eade1163e9937d5a1f63b8aa3), [#57](https://github.com/abe33/atom-pigments/issues/57))

<a name="v0.12.0"></a>
# v0.12.0 (2015-08-28)

## Features

- Add new setting to extend the color search to files not in source names ([ed38956b](https://github.com/abe33/atom-pigments/commit/ed38956b201e600fb9dcc167dc586364239423a0))
  <br>The default now allow to catch colors in CSS files.

## Bug Fixes

- Fix access to undefined project in autocomplete provider ([f1c1227a](https://github.com/abe33/atom-pigments/commit/f1c1227abf71505f8a554357b7000667b27950b0), [#6](https://github.com/abe33/atom-pigments/issues/6))

<a name="v0.11.0"></a>
# v0.11.0 (2015-08-13)

## Features

- Implement support for stylus channel modification functions ([6d783fd6](https://github.com/abe33/atom-pigments/commit/6d783fd6c74f08c8684002d9374a0a9340647630), [#72](https://github.com/abe33/atom-pigments/issues/72))
- Add support for Stylus transparentify function ([86834c1a](https://github.com/abe33/atom-pigments/commit/86834c1a2cec64956ca29e9fb5bb977151aac021), [#72](https://github.com/abe33/atom-pigments/issues/72))

## Bug Fixes

- Fix spin function called with degrees not parsed properly ([92a5e890](https://github.com/abe33/atom-pigments/commit/92a5e890b8c090bdf63f0947c3c781f43eadc259), [#72](https://github.com/abe33/atom-pigments/issues/72))

<a name="v0.10.0"></a>
# v0.10.0 (2015-08-13)

## Features

- Separate conversions to RGB and RGBA in two commands ([2f2da668](https://github.com/abe33/atom-pigments/commit/2f2da668187a709f24b5c18732684e9a1805d7da), [#71](https://github.com/abe33/atom-pigments/issues/71))

## Bug Fixes

- Prevent attaching a buffer if the editor element is undefined ([5fa6964c](https://github.com/abe33/atom-pigments/commit/5fa6964c5598a96ee243377c0f765640897e9217), [#70](https://github.com/abe33/atom-pigments/issues/70))

## Performances

- Cache marker's screen range to speed up updates and renders ([1746e1fe](https://github.com/abe33/atom-pigments/commit/1746e1fed9411311f9f8bd92b0a1da5516fe27ac))

<a name="v0.9.3"></a>
# v0.9.3 (2015-08-02)

## Bug Fixes

- Prevent markers creation and render after text editor was destroyed ([0b7e598b](https://github.com/abe33/atom-pigments/commit/0b7e598be84409c4b21e058a030e08124b4c52c1), [#63](https://github.com/abe33/atom-pigments/issues/63))

<a name="v0.9.2"></a>
# v0.9.2 (2015-07-27)

## Bug Fixes

- Prevent error raised when checking a destroyed marker ([e5d6512f](https://github.com/abe33/atom-pigments/commit/e5d6512fb5e958bcc0afacd093d7bebfbd492989))
- Fix marker ignored state not reevaluated when ignored scopes changed ([0c148db3](https://github.com/abe33/atom-pigments/commit/0c148db378150baaf9b05ea97c6f2844c07f9cf3))

## Performances

- Use asynchronous markers creation to avoid locking the UI ([4775788f](https://github.com/abe33/atom-pigments/commit/4775788f5cb8e24b52376560298bc44304917ae3) [#58](https://github.com/abe33/atom-pigments/issues/58))
- Store the ignored state into the marker for speedup ([ca922bac](https://github.com/abe33/atom-pigments/commit/ca922bac9cc93fbf87cad3652e82f757110bbab0))

<a name="v0.9.1"></a>
# v0.9.1 (2015-07-27)

## Bug Fixes

- Add missing `native-key-bindings` class on palette and results elements ([340d8117](https://github.com/abe33/atom-pigments/commit/340d81178bde5a69b015a0631301f383ed979ac1), [#60](https://github.com/abe33/atom-pigments/issues/60))
- Fix infinite loop when splitting a match with a `)` ([eb7baad1](https://github.com/abe33/atom-pigments/commit/eb7baad120c9a1ed0f08c3c24a78ee36b2eb78b9), [#61](https://github.com/abe33/atom-pigments/issues/61))

<a name="v0.9.0"></a>
# v0.9.0 (2015-07-21)

## Features

- Add destroy event on project ([3752bf23](https://github.com/abe33/atom-pigments/commit/3752bf23bdf7148db23181feacf153180c8ace9b))
- Add ignoreVcsIgnoredPaths setting instead of using the core setting ([11c78185](https://github.com/abe33/atom-pigments/commit/11c7818512d1dec04a32cbf0fa0f7900353eb785))

## Bug Fixes

- Fix markers out of sync when a line gets wrapped during typing ([f9f2015b](https://github.com/abe33/atom-pigments/commit/f9f2015ba49823b87968c09c7bb7dc0ae24f4d5c), [#55](https://github.com/abe33/atom-pigments/issues/55))
- Prevent error when an event is dispatched after destruction ([3c6d3a12](https://github.com/abe33/atom-pigments/commit/3c6d3a12185552a6792ef3d44ef625dbd5b9c143))
- Fix project variables not destroyed when reload find nothing ([16701793](https://github.com/abe33/atom-pigments/commit/167017931c21fcc3c53c6e04115c2bc5d447f163))
- Make sure to update markers when stylesheets are added ([61f00898](https://github.com/abe33/atom-pigments/commit/61f00898d1a244f14f4ac6da0e4cf36794740fe0), [#51](https://github.com/abe33/atom-pigments/issues/51))

<a name="v0.8.4"></a>
# v0.8.4 (2015-07-10)

## Bug Fixes

- Fix percentage with % treated as float in 0-1 range ([107d781b](https://github.com/abe33/atom-pigments/commit/107d781b4caa41db98b57bbca8cd24bfcb164676), [#49](https://github.com/abe33/atom-pigments/issues/49))

<a name="v0.8.3"></a>
# v0.8.3 (2015-07-07)

## Bug Fixes

- Fix error raised in the palette view if a color is destroyed inbetween ([fd0f9a41](https://github.com/abe33/atom-pigments/commit/fd0f9a41cab80dfc370d8e2aa88dd7d29764fb2a), [#47](https://github.com/abe33/atom-pigments/issues/47))
- Fix error when updating dependencies if a null variable is present ([22a3f0fb](https://github.com/abe33/atom-pigments/commit/22a3f0fbf165f83136d0a7ca9cd60b1297c46d44), [#48](https://github.com/abe33/atom-pigments/issues/48))
- Removes color markers from display markers when destroyed ([d16e0f86](https://github.com/abe33/atom-pigments/commit/d16e0f861f085dede89c69d8a96c794c3950e63b))

<a name="v0.8.2"></a>
# v0.8.2 (2015-06-30)

## Bug Fixes

- Prevent errors when reading scopes in a buffer ([cc4ccaa7](https://github.com/abe33/atom-pigments/commit/cc4ccaa73f7ea156d3cafaee4b06035b25d6dc75), [#46](https://github.com/abe33/atom-pigments/issues/46))
- Prevent errors raised when rendering a color marker view ([adff568f](https://github.com/abe33/atom-pigments/commit/adff568f0d20e55262be8d8a2321aa338153d604), [#27](https://github.com/abe33/atom-pigments/issues/27))

<a name="v0.8.1"></a>
# v0.8.1 (2015-06-27)

## Bug Fixes

- Fix XML entities and CSS color function improperly highlighted ([60545015](https://github.com/abe33/atom-pigments/commit/60545015230feed7a7896834e5950e1bb693f4af), [#39](https://github.com/abe33/atom-pigments/issues/39))
- Fix error raised when right clicking an editor without a shadow root ([30e21092](https://github.com/abe33/atom-pigments/commit/30e2109273e36e4012e799620b289b3fdaaf8768), [#44](https://github.com/abe33/atom-pigments/issues/44))
- Prevent error raised in color search ([ebb02279](https://github.com/abe33/atom-pigments/commit/ebb02279743370b4054ab2358761989b90397d51))

<a name="v0.8.0"></a>
# v0.8.0 (2015-06-19)

## Features

- Implement CSS hexa 4 and 8 digit notations ([5fb21fb3](https://github.com/abe33/atom-pigments/commit/5fb21fb3d0f8399fb0b702fa4e687a3757bc59d4), [#36](https://github.com/abe33/atom-pigments/issues/36))
- Add `rebeccapurple` as named color ([0169c0b9](https://github.com/abe33/atom-pigments/commit/0169c0b93200c519cb6816e6e88b3f62686bcb48), [#37](https://github.com/abe33/atom-pigments/issues/37))

<a name="v0.7.4"></a>
# v0.7.4 (2015-06-19)

## Bug Fixes

- Fix positionning of dot markers ([6bb32743](https://github.com/abe33/atom-pigments/commit/6bb32743a101f9bf49580c5cf548111009be5502), [#35](https://github.com/abe33/atom-pigments/issues/35))
- Fix attaching a color buffer element to an editor without shadow root ([a3dff949](https://github.com/abe33/atom-pigments/commit/a3dff949b1574a6f055e8b714bc4d69eaad7f07a), [#34](https://github.com/abe33/atom-pigments/issues/34))

<a name="v0.7.3"></a>
# v0.7.3 (2015-06-18)

## Bug Fixes

- Fix right click broken in mini text-editor ([85135805](https://github.com/abe33/atom-pigments/commit/8513580500e540d2e08f12030c5541963446750b), [#32](https://github.com/abe33/atom-pigments/issues/32))
- Remove negative margin in markers styles ([9afbde03](https://github.com/abe33/atom-pigments/commit/9afbde032465ab60addc694703c9d83f218ed355), [#33](https://github.com/abe33/atom-pigments/issues/33))
- Fix variables and path kept on reload after the file was removed ([37105157](https://github.com/abe33/atom-pigments/commit/37105157453ac56426bcdb58b06ff900bfb4778c))

<a name="v0.7.2"></a>
# v0.7.2 (2015-06-15)

- Bump markers version ([6921bea2](https://github.com/abe33/atom-pigments/commit/6921bea2e0ab4fe49edd4fbcfa2cdad0c17471f0))

<a name="v0.7.1"></a>
# v0.7.1 (2015-06-14)

## Bug Fixes

- Fix infinite recursion when parsing a color ([0c4ed7c6](https://github.com/abe33/atom-pigments/commit/0c4ed7c6e8c1e2a6d391c6ec08a7117372de5a0a), [#19](https://github.com/abe33/atom-pigments/issues/19))
- Fix typo in method name ([8e5c9423](https://github.com/abe33/atom-pigments/commit/8e5c9423124f994b37f7d0d1cf634cdc98fa710f))

<a name="v0.7.0"></a>
# v0.7.0 (2015-06-14)

## Features

- Add convert to hex and convert to rgba commands ([592157b3](https://github.com/abe33/atom-pigments/commit/592157b31bf1e6fe813071745b09e68bf1922c4e), [#22](https://github.com/abe33/atom-pigments/issues/22))
  <br>Available in the context when over a color.
- Add method on color buffer to retrieve color markers with buffer position ([ba00c5d8](https://github.com/abe33/atom-pigments/commit/ba00c5d894dfd88dfae9dba02c686fdfa7d5669f))
- Add method on color markers to convert its content to hex or rgba ([3ef5a337](https://github.com/abe33/atom-pigments/commit/3ef5a3374b555e1ed1ef47b9b15692c88676e4fc))
- Add support for sass complement function ([75e03377](https://github.com/abe33/atom-pigments/commit/75e03377639d0896c470bfe11a9b484180eb4632))
- Add support for stylus blend function ([c601c647](https://github.com/abe33/atom-pigments/commit/c601c647213f5cce0d6deae5809a284bc0e08390))
- Add support for less blending functions ([30fbe00e](https://github.com/abe33/atom-pigments/commit/30fbe00ef207923fbcd2390a15ecbb057e731f0c))
- Add support for less contrast function ([ffb6904b](https://github.com/abe33/atom-pigments/commit/ffb6904bd05b3a0f89975b79a0f93e6740f139da))
- Add support for less fade function ([5470dabb](https://github.com/abe33/atom-pigments/commit/5470dabba1d6570cce79a0e385ce15cbfbb59a29))
- Add support for less spin function ([e47ed885](https://github.com/abe33/atom-pigments/commit/e47ed8856838a94a2ee4acc6575519710abc0016))

## Bug Fixes

- Fix mix operation not working with color expression with paranthesis ([4bef6832](https://github.com/abe33/atom-pigments/commit/4bef6832d53b74b7d6e171404320fa57d7e304a1))

<a name="v0.6.0"></a>
# v0.6.0 (2015-06-11)

## Features

- Add a square dots marker renderer ([4b73948b](https://github.com/abe33/atom-pigments/commit/4b73948b4ef8172488de72dc017ddd21f4140ad1), [#15](https://github.com/abe33/atom-pigments/issues/15))

## Bug Fixes

- Remove annoying warning dialog for large project ([30cd2553](https://github.com/abe33/atom-pigments/commit/30cd2553677b2aeaa605a5e84251eea47975c7d9), [#23](https://github.com/abe33/atom-pigments/issues/23))

<a name="v0.5.0"></a>
# v0.5.0 (2015-06-11)

## Features

- Implement a variable that allow to speed up considerably considerably. ([c7ffc5c1](https://github.com/abe33/atom-pigments/commit/c7ffc5c19bf280928d204ea3b6ae5dfe5a931907))
- Bump markers version ([e483bb34](https://github.com/abe33/atom-pigments/commit/e483bb340683942eefc4d363b6512e1a50083cf2))

## Bug Fixes

- Fix outline, underline and dot markers hidden by tiles ([818930fc](https://github.com/abe33/atom-pigments/commit/818930fca4b6c4a1e9e1879499fe656b4ed4ba6d), [#26](https://github.com/abe33/atom-pigments/issues/26))
- Fix issue with variables update when rescanning a buffer ([5080531a](https://github.com/abe33/atom-pigments/commit/5080531a83ff6d578dd8210eea9ae5f419099d40))

## Performances

- Remove variables markers created in text buffer ([f701b6b9](https://github.com/abe33/atom-pigments/commit/f701b6b9ce01174154e90755c233afc2264b8eab))

<a name="v0.4.5"></a>
# v0.4.5 (2015-06-05)

## Bug Fixes

- Fix error raised when filtering the variables if there's no variables ([70e546c8](https://github.com/abe33/atom-pigments/commit/70e546c81dda1f181693291173c306fe8cf6d44b))
- Fix glob pattern matching not consistent between project and loader ([503d274c](https://github.com/abe33/atom-pigments/commit/503d274ca8054488fdea36ca35c539c2c2fb9890))

<a name="v0.4.4"></a>
# v0.4.4 (2015-06-03)

## Bug Fixes

- Fix markers horizontal scroll not in sync with editor tiles ([264450b5](https://github.com/abe33/atom-pigments/commit/264450b591c59481010ce927c643ad8ab3689c84))

<a name="v0.4.3"></a>
# v0.4.3 (2015-06-03)

## Bug Fixes

- Fix scroll still not in sync if there's no tiles when setting the model ([5d4b93a4](https://github.com/abe33/atom-pigments/commit/5d4b93a4a3a4a37317f0acf483195f99b3955dac), [#25](https://github.com/abe33/atom-pigments/issues/25))

<a name="v0.4.2"></a>
# v0.4.2 (2015-06-03)

## Bug Fixes

- Fix color markers not synced with editor scroll ([dded923d](https://github.com/abe33/atom-pigments/commit/dded923d103592fa2b4cf17d0d1f34ed22b90732), [#25](https://github.com/abe33/atom-pigments/issues/25))

<a name="v0.4.1"></a>
# v0.4.1 (2015-06-02)

## Features

- Add `vendor/*`, `spec/*` and `test/*` as default ignored names. ([96381ecf](https://github.com/abe33/atom-pigments/commit/96381ecf1c643300aa091c744149e28207e0c0bc))

## Bug Fixes

- Raise the threshold to avoid annoying user ([15b05c07](https://github.com/abe33/atom-pigments/commit/15b05c07885aaac2062c5c2b5aa40f892795bc9a))
- Fix paths and variables not updated when the paths settings are changed ([8e259a8a](https://github.com/abe33/atom-pigments/commit/8e259a8a81f0aed8744ab381d6a44c6f3609f85c))

<a name="v0.4.0"></a>
# v0.4.0 (2015-06-01)

## Features

- Add border radius to background markers ([3a9efc6a](https://github.com/abe33/atom-pigments/commit/3a9efc6ab12132820ece1bd2509834f81abb839d))
- Add a second version property in serialized data ([53fb3c1c](https://github.com/abe33/atom-pigments/commit/53fb3c1c91a0806e2f3305792caf4f82f6ee1df4))  <br>This version will only be used for markers data (variables and buffers
  data). So that we can drop these data without affecting the project
  specific data.
- Implement an alert on large project loading to ignores the paths ([05ba87f4](https://github.com/abe33/atom-pigments/commit/05ba87f45ef622d5811f11672d1314e125d8229f))

## Bug Fixes

- Fix variables defined after a mixin not found by scanner ([8f000e59](https://github.com/abe33/atom-pigments/commit/8f000e59a0c7aeea74a8a1475d7d543b98568c59))
- Fix variables and colors not handled for file not in project ([4bb84b72](https://github.com/abe33/atom-pigments/commit/4bb84b72d8e6a795335df462f804f91760a66da4))
- Prevent call stack errors when building the variables regexp ([3aa322cb](https://github.com/abe33/atom-pigments/commit/3aa322cb033aafbd5a4e6c84804342751ca21205))
- Fix broken anchor tag. ([f0ff40a7](https://github.com/abe33/atom-pigments/commit/f0ff40a7bbad999763cf0dcd0b0ed8f3766517b0))
- Fix error raised when an invalid regexp is set in ignored scopes ([d4527c68](https://github.com/abe33/atom-pigments/commit/d4527c6843766584541c25a1f610e21e26d11340), [#14](https://github.com/abe33/atom-pigments/issues/14))

<a name="v0.3.1"></a>
# v0.3.1 (2015-05-19)

## Bug Fixes

- Add alpha rounding after 3 decimals in palette view ([69638149](https://github.com/abe33/atom-pigments/commit/696381498dd4951aebc57fd3f6c0368e139bd59a))
- Fix accessing variables with id or name when there's no variables yet ([8155b945](https://github.com/abe33/atom-pigments/commit/8155b945f81fe834aabc99a74369670b241da96b), [#17](https://github.com/abe33/atom-pigments/issues/17))

<a name="v0.3.0"></a>
# v0.3.0 (2015-05-18)

## Features

- Add relative units for dot markers and autocomplete preview ([d3350386](https://github.com/abe33/atom-pigments/commit/d335038679f3338c3b9a26b846383b6dec988d83), [#11](https://github.com/abe33/atom-pigments/issues/11))
- Add a pigments:reload command to reload project variables ([1b3f51d6](https://github.com/abe33/atom-pigments/commit/1b3f51d6898cf2a551591bfe9e49b3d49a10978b))
  <br>As proposed in #7.
- Add node_modules as default ignored name ([e4ab734a](https://github.com/abe33/atom-pigments/commit/e4ab734ad22a0589b7d8a79ae96c650451ed1104))
  <br>As proposed in #7
- Implement rendering colors from variables only for variables sources ([fcb15da9](https://github.com/abe33/atom-pigments/commit/fcb15da97af37b2b6269aa780862ec8f22a4946d))

## Bug Fixes

- Fix attributes selectors being parsed as variables ([d7407e4c](https://github.com/abe33/atom-pigments/commit/d7407e4c291d42c80791ac17c11dce00f14ba618))

<a name="v0.2.1"></a>
# v0.2.1 (2015-05-14)

## Bug Fixes

- Fix mixins/functions arguments being parsed as variables ([e7a6fc17](https://github.com/abe33/atom-pigments/commit/e7a6fc178aa962c313ba7c3ce68301036526f093))

<a name="v0.2.0"></a>
# v0.2.0 (2015-04-30)

## Features

- Implement a delay before scanning the buffer after an input ([1ba5ee49](https://github.com/abe33/atom-pigments/commit/1ba5ee4956d81f00c5f086f0738fc2da27d89245))

## Bug Fixes

- Fix tasks still running when starting typing again ([fb185a2d](https://github.com/abe33/atom-pigments/commit/fb185a2d464212a23402d5258845af3141103a39))
- Fix provider not providing variable prefixed with $ ([f1752225](https://github.com/abe33/atom-pigments/commit/f1752225f729d84c854c728392528a3c62390134))

<a name="v0.1.4"></a>
# v0.1.4 (2015-04-24)

## Bug Fixes

- Fix invalid colors displayed in search results ([1534ea49](https://github.com/abe33/atom-pigments/commit/1534ea490ad3ccd20949f7aef7b73f5b4076a11d), [#3](https://github.com/abe33/atom-pigments/issues/3))

<a name="v0.1.3"></a>
# v0.1.3 (2015-04-23)

## Bug Fixes

- Implement strict matching in autocomplete provider ([028c3a9f](https://github.com/abe33/atom-pigments/commit/028c3a9f441d414bb3145d61a892e933920a4c61), [#3](https://github.com/abe33/atom-pigments/issues/3))
- Fix context returning invalid colors ([dc47cd1d](https://github.com/abe33/atom-pigments/commit/dc47cd1df920457215bfd2de5299c8c462a3b17a), [#4](https://github.com/abe33/atom-pigments/issues/4))

<a name="v0.1.2"></a>
# v0.1.2 (2015-04-22)

## Features

- Add json version in serialized data ([b432a50a](https://github.com/abe33/atom-pigments/commit/b432a50a82ae31ae9f6e44d532ddb3a2a0c1870b))

## Bug Fixes

- Fix invalid colors not detected by parser ([33674063](https://github.com/abe33/atom-pigments/commit/336740635241dea118972b5f914e572591fcf4bc), [#2](https://github.com/abe33/atom-pigments/issues/2))
- Fix typo in setting's name ([f9bcbd44](https://github.com/abe33/atom-pigments/commit/f9bcbd445845e1b88d346bc89c9e04f1cf0dd6a8), [#1](https://github.com/abe33/atom-pigments/issues/1))

<a name="v0.1.1"></a>
# v0.1.1 (2015-04-22)

## Bug Fixes

- Fix markers not updated after tokenization and editor styling ([ebe5a07a](https://github.com/abe33/atom-pigments/commit/ebe5a07a56a027863351dcf7422b2f45c3aa398b))
