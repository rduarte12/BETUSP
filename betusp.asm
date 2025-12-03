; Normal Commands:
;
; ['w']       - Chips[CurChips] += 1
; ['a']       - CurChips -= 1
; ['s']       - CurChips += 1
; ['d']       - Chips[CurChips] -= 1
; [<Enter>]   - Confirm | Wager
; [<Space>]   - Stop
; ['?']       - Help
;
; Admin Commands:
;
; ['>']       - Money  = Limit
; ['<']       - Money  = 0
; ['+']       - Money *= 2
; ['-']       - Money /= 2

jmp main

; |==================| Section: Cat |==================|

; This is Sir Gato.   (en)
; Este é o Sr. Gato.  (ptbr)
; █████░▀██████████████▀░████
; ████▌▒▒░████████████░▒▒▐███
; ████░▒▒▒░██████████░▒▒▒░███
; ███▌░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▐██
; ███░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░██
; █████▀▀▀██▄▒▒▒▒▒▒▒▄██▀▀▀███
; ████░░░▐█░▀█▒▒▒▒▒█▀░█▌░░░██
; ███▌░░░▐▄▌░▐▌▒▒▒▐▌░▐▄▌░░▐██
; ████░░░▐█▌░░▌▒▒▒▐░░▐█▌░░███
; ███▒▀▄▄▄█▄▄▄▌░▄░▐▄▄▄█▄▄▀▒██
; ████░░░░░░░░░░└┴┘░░░░░░░░██
; █████▄▄░░░░░░░░░░░░░░▄▄████
; ███████████▒▒▒▒▒▒██████████
; ████▀░░███▒▒░░▒░░▒▀████████
; ████▒░███▒▒╖░░╥░░╓▒▐███████
; ████▒░▀▀▀░░║░░║░░║░░███████
; █████▄▄▄▄▀▀┴┴╚╧╧╝╧╧╝┴┴█████
; ███████████████████████████

; |==================| Section: Screens |==================|

GameScreen : var #1200
  ;Linha 0
  static GameScreen + #0, #2825
  static GameScreen + #1, #2825
  static GameScreen + #2, #2825
  static GameScreen + #3, #2825
  static GameScreen + #4, #2825
  static GameScreen + #5, #2825
  static GameScreen + #6, #2825
  static GameScreen + #7, #2825
  static GameScreen + #8, #2825
  static GameScreen + #9, #2825
  static GameScreen + #10, #2825
  static GameScreen + #11, #2825
  static GameScreen + #12, #2825
  static GameScreen + #13, #2825
  static GameScreen + #14, #2825
  static GameScreen + #15, #2825
  static GameScreen + #16, #2825
  static GameScreen + #17, #2825
  static GameScreen + #18, #2825
  static GameScreen + #19, #2825
  static GameScreen + #20, #2825
  static GameScreen + #21, #2825
  static GameScreen + #22, #2825
  static GameScreen + #23, #2825
  static GameScreen + #24, #2825
  static GameScreen + #25, #2825
  static GameScreen + #26, #2825
  static GameScreen + #27, #2825
  static GameScreen + #28, #2825
  static GameScreen + #29, #2825
  static GameScreen + #30, #2825
  static GameScreen + #31, #2825
  static GameScreen + #32, #2825
  static GameScreen + #33, #2825
  static GameScreen + #34, #2825
  static GameScreen + #35, #2825
  static GameScreen + #36, #2825
  static GameScreen + #37, #2825
  static GameScreen + #38, #2825
  static GameScreen + #39, #2825

  ;Linha 1
  static GameScreen + #40, #2825
  static GameScreen + #41, #32
  static GameScreen + #42, #32
  static GameScreen + #43, #32
  static GameScreen + #44, #32
  static GameScreen + #45, #32
  static GameScreen + #46, #32
  static GameScreen + #47, #32
  static GameScreen + #48, #32
  static GameScreen + #49, #32
  static GameScreen + #50, #32
  static GameScreen + #51, #32
  static GameScreen + #52, #32
  static GameScreen + #53, #32
  static GameScreen + #54, #32
  static GameScreen + #55, #32
  static GameScreen + #56, #32
  static GameScreen + #57, #32
  static GameScreen + #58, #32
  static GameScreen + #59, #32
  static GameScreen + #60, #32
  static GameScreen + #61, #32
  static GameScreen + #62, #32
  static GameScreen + #63, #32
  static GameScreen + #64, #32
  static GameScreen + #65, #32
  static GameScreen + #66, #32
  static GameScreen + #67, #32
  static GameScreen + #68, #32
  static GameScreen + #69, #32
  static GameScreen + #70, #32
  static GameScreen + #71, #32
  static GameScreen + #72, #32
  static GameScreen + #73, #32
  static GameScreen + #74, #32
  static GameScreen + #75, #32
  static GameScreen + #76, #32
  static GameScreen + #77, #32
  static GameScreen + #78, #32
  static GameScreen + #79, #2825

  ;Linha 2
  static GameScreen + #80, #2825
  static GameScreen + #81, #32
  static GameScreen + #82, #32
  static GameScreen + #83, #32
  static GameScreen + #84, #32
  static GameScreen + #85, #32
  static GameScreen + #86, #32
  static GameScreen + #87, #32
  static GameScreen + #88, #32
  static GameScreen + #89, #32
  static GameScreen + #90, #32
  static GameScreen + #91, #32
  static GameScreen + #92, #32
  static GameScreen + #93, #32
  static GameScreen + #94, #32
  static GameScreen + #95, #32
  static GameScreen + #96, #32
  static GameScreen + #97, #32
  static GameScreen + #98, #32
  static GameScreen + #99, #32
  static GameScreen + #100, #32
  static GameScreen + #101, #32
  static GameScreen + #102, #32
  static GameScreen + #103, #32
  static GameScreen + #104, #32
  static GameScreen + #105, #32
  static GameScreen + #106, #32
  static GameScreen + #107, #32
  static GameScreen + #108, #32
  static GameScreen + #109, #32
  static GameScreen + #110, #32
  static GameScreen + #111, #82
  static GameScreen + #112, #36
  static GameScreen + #113, #32
  static GameScreen + #114, #32
  static GameScreen + #115, #32
  static GameScreen + #116, #32
  static GameScreen + #117, #32
  static GameScreen + #118, #32
  static GameScreen + #119, #2825

  ;Linha 3
  static GameScreen + #120, #2825
  static GameScreen + #121, #32
  static GameScreen + #122, #32
  static GameScreen + #123, #32
  static GameScreen + #124, #32
  static GameScreen + #125, #32
  static GameScreen + #126, #32
  static GameScreen + #127, #32
  static GameScreen + #128, #32
  static GameScreen + #129, #32
  static GameScreen + #130, #32
  static GameScreen + #131, #32
  static GameScreen + #132, #32
  static GameScreen + #133, #32
  static GameScreen + #134, #32
  static GameScreen + #135, #32
  static GameScreen + #136, #32
  static GameScreen + #137, #32
  static GameScreen + #138, #32
  static GameScreen + #139, #32
  static GameScreen + #140, #32
  static GameScreen + #141, #32
  static GameScreen + #142, #32
  static GameScreen + #143, #32
  static GameScreen + #144, #32
  static GameScreen + #145, #32
  static GameScreen + #146, #32
  static GameScreen + #147, #32
  static GameScreen + #148, #32
  static GameScreen + #149, #32
  static GameScreen + #150, #32
  static GameScreen + #151, #32
  static GameScreen + #152, #32
  static GameScreen + #153, #32
  static GameScreen + #154, #32
  static GameScreen + #155, #32
  static GameScreen + #156, #32
  static GameScreen + #157, #32
  static GameScreen + #158, #32
  static GameScreen + #159, #2825

  ;Linha 4
  static GameScreen + #160, #2825
  static GameScreen + #161, #32
  static GameScreen + #162, #32
  static GameScreen + #163, #32
  static GameScreen + #164, #32
  static GameScreen + #165, #32
  static GameScreen + #166, #32
  static GameScreen + #167, #32
  static GameScreen + #168, #32
  static GameScreen + #169, #32
  static GameScreen + #170, #32
  static GameScreen + #171, #32
  static GameScreen + #172, #32
  static GameScreen + #173, #32
  static GameScreen + #174, #32
  static GameScreen + #175, #32
  static GameScreen + #176, #32
  static GameScreen + #177, #32
  static GameScreen + #178, #32
  static GameScreen + #179, #32
  static GameScreen + #180, #32
  static GameScreen + #181, #32
  static GameScreen + #182, #32
  static GameScreen + #183, #32
  static GameScreen + #184, #32
  static GameScreen + #185, #32
  static GameScreen + #186, #32
  static GameScreen + #187, #32
  static GameScreen + #188, #32
  static GameScreen + #189, #32
  static GameScreen + #190, #32
  static GameScreen + #191, #32
  static GameScreen + #192, #32
  static GameScreen + #193, #32
  static GameScreen + #194, #32
  static GameScreen + #195, #32
  static GameScreen + #196, #32
  static GameScreen + #197, #32
  static GameScreen + #198, #32
  static GameScreen + #199, #2825

  ;Linha 5
  static GameScreen + #200, #2825
  static GameScreen + #201, #32
  static GameScreen + #202, #32
  static GameScreen + #203, #32
  static GameScreen + #204, #32
  static GameScreen + #205, #32
  static GameScreen + #206, #32
  static GameScreen + #207, #32
  static GameScreen + #208, #32
  static GameScreen + #209, #32
  static GameScreen + #210, #32
  static GameScreen + #211, #32
  static GameScreen + #212, #32
  static GameScreen + #213, #32
  static GameScreen + #214, #32
  static GameScreen + #215, #32
  static GameScreen + #216, #32
  static GameScreen + #217, #32
  static GameScreen + #218, #32
  static GameScreen + #219, #32
  static GameScreen + #220, #32
  static GameScreen + #221, #32
  static GameScreen + #222, #32
  static GameScreen + #223, #32
  static GameScreen + #224, #32
  static GameScreen + #225, #32
  static GameScreen + #226, #32
  static GameScreen + #227, #32
  static GameScreen + #228, #32
  static GameScreen + #229, #32
  static GameScreen + #230, #32
  static GameScreen + #231, #32
  static GameScreen + #232, #32
  static GameScreen + #233, #32
  static GameScreen + #234, #32
  static GameScreen + #235, #32
  static GameScreen + #236, #32
  static GameScreen + #237, #32
  static GameScreen + #238, #32
  static GameScreen + #239, #2825

  ;Linha 6
  static GameScreen + #240, #2825
  static GameScreen + #241, #32
  static GameScreen + #242, #32
  static GameScreen + #243, #32
  static GameScreen + #244, #32
  static GameScreen + #245, #32
  static GameScreen + #246, #32
  static GameScreen + #247, #32
  static GameScreen + #248, #32
  static GameScreen + #249, #32
  static GameScreen + #250, #32
  static GameScreen + #251, #32
  static GameScreen + #252, #32
  static GameScreen + #253, #32
  static GameScreen + #254, #32
  static GameScreen + #255, #32
  static GameScreen + #256, #32
  static GameScreen + #257, #32
  static GameScreen + #258, #32
  static GameScreen + #259, #32
  static GameScreen + #260, #32
  static GameScreen + #261, #32
  static GameScreen + #262, #32
  static GameScreen + #263, #32
  static GameScreen + #264, #32
  static GameScreen + #265, #32
  static GameScreen + #266, #32
  static GameScreen + #267, #32
  static GameScreen + #268, #32
  static GameScreen + #269, #32
  static GameScreen + #270, #3081
  static GameScreen + #271, #3081
  static GameScreen + #272, #3081
  static GameScreen + #273, #32
  static GameScreen + #274, #32
  static GameScreen + #275, #32
  static GameScreen + #276, #32
  static GameScreen + #277, #32
  static GameScreen + #278, #32
  static GameScreen + #279, #2825

  ;Linha 7
  static GameScreen + #280, #2825
  static GameScreen + #281, #32
  static GameScreen + #282, #32
  static GameScreen + #283, #32
  static GameScreen + #284, #32
  static GameScreen + #285, #32
  static GameScreen + #286, #32
  static GameScreen + #287, #32
  static GameScreen + #288, #32
  static GameScreen + #289, #32
  static GameScreen + #290, #32
  static GameScreen + #291, #32
  static GameScreen + #292, #32
  static GameScreen + #293, #32
  static GameScreen + #294, #32
  static GameScreen + #295, #32
  static GameScreen + #296, #32
  static GameScreen + #297, #32
  static GameScreen + #298, #32
  static GameScreen + #299, #32
  static GameScreen + #300, #32
  static GameScreen + #301, #32
  static GameScreen + #302, #32
  static GameScreen + #303, #32
  static GameScreen + #304, #32
  static GameScreen + #305, #32
  static GameScreen + #306, #32
  static GameScreen + #307, #32
  static GameScreen + #308, #32
  static GameScreen + #309, #32
  static GameScreen + #310, #3081
  static GameScreen + #311, #3081
  static GameScreen + #312, #3081
  static GameScreen + #313, #32
  static GameScreen + #314, #32
  static GameScreen + #315, #32
  static GameScreen + #316, #32
  static GameScreen + #317, #32
  static GameScreen + #318, #32
  static GameScreen + #319, #2825

  ;Linha 8
  static GameScreen + #320, #2825
  static GameScreen + #321, #32
  static GameScreen + #322, #32
  static GameScreen + #323, #32
  static GameScreen + #324, #32
  static GameScreen + #325, #32
  static GameScreen + #326, #32
  static GameScreen + #327, #32
  static GameScreen + #328, #32
  static GameScreen + #329, #265
  static GameScreen + #330, #265
  static GameScreen + #331, #265
  static GameScreen + #332, #2313
  static GameScreen + #333, #2313
  static GameScreen + #334, #2313
  static GameScreen + #335, #2313
  static GameScreen + #336, #2313
  static GameScreen + #337, #2313
  static GameScreen + #338, #2313
  static GameScreen + #339, #2313
  static GameScreen + #340, #2313
  static GameScreen + #341, #2313
  static GameScreen + #342, #2313
  static GameScreen + #343, #2313
  static GameScreen + #344, #2313
  static GameScreen + #345, #2313
  static GameScreen + #346, #2313
  static GameScreen + #347, #265
  static GameScreen + #348, #265
  static GameScreen + #349, #265
  static GameScreen + #350, #3081
  static GameScreen + #351, #3081
  static GameScreen + #352, #3081
  static GameScreen + #353, #32
  static GameScreen + #354, #32
  static GameScreen + #355, #32
  static GameScreen + #356, #32
  static GameScreen + #357, #32
  static GameScreen + #358, #32
  static GameScreen + #359, #2825

  ;Linha 9
  static GameScreen + #360, #2825
  static GameScreen + #361, #32
  static GameScreen + #362, #32
  static GameScreen + #363, #32
  static GameScreen + #364, #32
  static GameScreen + #365, #32
  static GameScreen + #366, #32
  static GameScreen + #367, #32
  static GameScreen + #368, #32
  static GameScreen + #369, #265
  static GameScreen + #370, #265
  static GameScreen + #371, #2313
  static GameScreen + #372, #2313
  static GameScreen + #373, #2313
  static GameScreen + #374, #2313
  static GameScreen + #375, #2313
  static GameScreen + #376, #2313
  static GameScreen + #377, #2313
  static GameScreen + #378, #2313
  static GameScreen + #379, #2313
  static GameScreen + #380, #2313
  static GameScreen + #381, #2313
  static GameScreen + #382, #2313
  static GameScreen + #383, #2313
  static GameScreen + #384, #2313
  static GameScreen + #385, #2313
  static GameScreen + #386, #2313
  static GameScreen + #387, #2313
  static GameScreen + #388, #265
  static GameScreen + #389, #265
  static GameScreen + #390, #32
  static GameScreen + #391, #1545
  static GameScreen + #392, #32
  static GameScreen + #393, #32
  static GameScreen + #394, #32
  static GameScreen + #395, #32
  static GameScreen + #396, #32
  static GameScreen + #397, #32
  static GameScreen + #398, #32
  static GameScreen + #399, #2825

  ;Linha 10
  static GameScreen + #400, #2825
  static GameScreen + #401, #32
  static GameScreen + #402, #32
  static GameScreen + #403, #2825
  static GameScreen + #404, #2825
  static GameScreen + #405, #2825
  static GameScreen + #406, #2825
  static GameScreen + #407, #2825
  static GameScreen + #408, #32
  static GameScreen + #409, #265
  static GameScreen + #410, #2313
  static GameScreen + #411, #9
  static GameScreen + #412, #9
  static GameScreen + #413, #9
  static GameScreen + #414, #9
  static GameScreen + #415, #9
  static GameScreen + #416, #9
  static GameScreen + #417, #9
  static GameScreen + #418, #9
  static GameScreen + #419, #9
  static GameScreen + #420, #9
  static GameScreen + #421, #9
  static GameScreen + #422, #9
  static GameScreen + #423, #9
  static GameScreen + #424, #9
  static GameScreen + #425, #9
  static GameScreen + #426, #9
  static GameScreen + #427, #9
  static GameScreen + #428, #2313
  static GameScreen + #429, #265
  static GameScreen + #430, #32
  static GameScreen + #431, #1545
  static GameScreen + #432, #32
  static GameScreen + #433, #32
  static GameScreen + #434, #32
  static GameScreen + #435, #32
  static GameScreen + #436, #32
  static GameScreen + #437, #32
  static GameScreen + #438, #32
  static GameScreen + #439, #2825

  ;Linha 11
  static GameScreen + #440, #2825
  static GameScreen + #441, #32
  static GameScreen + #442, #32
  static GameScreen + #443, #2825
  static GameScreen + #444, #32
  static GameScreen + #445, #32
  static GameScreen + #446, #32
  static GameScreen + #447, #2825
  static GameScreen + #448, #2825
  static GameScreen + #449, #265
  static GameScreen + #450, #2313
  static GameScreen + #451, #2825
  static GameScreen + #452, #9
  static GameScreen + #453, #9
  static GameScreen + #454, #9
  static GameScreen + #455, #9
  static GameScreen + #456, #9
  static GameScreen + #457, #9
  static GameScreen + #458, #9
  static GameScreen + #459, #9
  static GameScreen + #460, #9
  static GameScreen + #461, #9
  static GameScreen + #462, #9
  static GameScreen + #463, #9
  static GameScreen + #464, #9
  static GameScreen + #465, #9
  static GameScreen + #466, #9
  static GameScreen + #467, #2825
  static GameScreen + #468, #2313
  static GameScreen + #469, #265
  static GameScreen + #470, #32
  static GameScreen + #471, #1545
  static GameScreen + #472, #32
  static GameScreen + #473, #32
  static GameScreen + #474, #32
  static GameScreen + #475, #32
  static GameScreen + #476, #32
  static GameScreen + #477, #32
  static GameScreen + #478, #32
  static GameScreen + #479, #2825

  ;Linha 12
  static GameScreen + #480, #2825
  static GameScreen + #481, #32
  static GameScreen + #482, #32
  static GameScreen + #483, #2825
  static GameScreen + #484, #32
  static GameScreen + #485, #69
  static GameScreen + #486, #32
  static GameScreen + #487, #2825
  static GameScreen + #488, #32
  static GameScreen + #489, #265
  static GameScreen + #490, #2313
  static GameScreen + #491, #9
  static GameScreen + #492, #2825
  static GameScreen + #493, #3081
  static GameScreen + #494, #3081
  static GameScreen + #495, #3081
  static GameScreen + #496, #3081
  static GameScreen + #497, #3081
  static GameScreen + #498, #3081
  static GameScreen + #499, #3081
  static GameScreen + #500, #3081
  static GameScreen + #501, #3081
  static GameScreen + #502, #3081
  static GameScreen + #503, #3081
  static GameScreen + #504, #3081
  static GameScreen + #505, #3081
  static GameScreen + #506, #2825
  static GameScreen + #507, #9
  static GameScreen + #508, #2313
  static GameScreen + #509, #265
  static GameScreen + #510, #32
  static GameScreen + #511, #1545
  static GameScreen + #512, #32
  static GameScreen + #513, #32
  static GameScreen + #514, #32
  static GameScreen + #515, #32
  static GameScreen + #516, #32
  static GameScreen + #517, #32
  static GameScreen + #518, #32
  static GameScreen + #519, #2825

  ;Linha 13
  static GameScreen + #520, #2825
  static GameScreen + #521, #32
  static GameScreen + #522, #32
  static GameScreen + #523, #2825
  static GameScreen + #524, #32
  static GameScreen + #525, #78
  static GameScreen + #526, #32
  static GameScreen + #527, #2825
  static GameScreen + #528, #32
  static GameScreen + #529, #265
  static GameScreen + #530, #2313
  static GameScreen + #531, #2825
  static GameScreen + #532, #9
  static GameScreen + #533, #3081
  static GameScreen + #534, #32
  static GameScreen + #535, #32
  static GameScreen + #536, #32
  static GameScreen + #537, #3081
  static GameScreen + #538, #32
  static GameScreen + #539, #32
  static GameScreen + #540, #32
  static GameScreen + #541, #3081
  static GameScreen + #542, #32
  static GameScreen + #543, #32
  static GameScreen + #544, #32
  static GameScreen + #545, #3081
  static GameScreen + #546, #9
  static GameScreen + #547, #2825
  static GameScreen + #548, #2313
  static GameScreen + #549, #265
  static GameScreen + #550, #1545
  static GameScreen + #551, #32
  static GameScreen + #552, #32
  static GameScreen + #553, #32
  static GameScreen + #554, #32
  static GameScreen + #555, #32
  static GameScreen + #556, #32
  static GameScreen + #557, #32
  static GameScreen + #558, #32
  static GameScreen + #559, #2825

  ;Linha 14
  static GameScreen + #560, #2825
  static GameScreen + #561, #32
  static GameScreen + #562, #32
  static GameScreen + #563, #2825
  static GameScreen + #564, #32
  static GameScreen + #565, #84
  static GameScreen + #566, #32
  static GameScreen + #567, #2825
  static GameScreen + #568, #32
  static GameScreen + #569, #265
  static GameScreen + #570, #2313
  static GameScreen + #571, #9
  static GameScreen + #572, #2825
  static GameScreen + #573, #3081
  static GameScreen + #574, #32
  static GameScreen + #575, #32
  static GameScreen + #576, #32
  static GameScreen + #577, #3081
  static GameScreen + #578, #32
  static GameScreen + #579, #32
  static GameScreen + #580, #32
  static GameScreen + #581, #3081
  static GameScreen + #582, #32
  static GameScreen + #583, #32
  static GameScreen + #584, #32
  static GameScreen + #585, #3081
  static GameScreen + #586, #2825
  static GameScreen + #587, #9
  static GameScreen + #588, #2313
  static GameScreen + #589, #1289
  static GameScreen + #590, #1545
  static GameScreen + #591, #1289
  static GameScreen + #592, #32
  static GameScreen + #593, #32
  static GameScreen + #594, #32
  static GameScreen + #595, #32
  static GameScreen + #596, #32
  static GameScreen + #597, #32
  static GameScreen + #598, #32
  static GameScreen + #599, #2825

  ;Linha 15
  static GameScreen + #600, #2825
  static GameScreen + #601, #32
  static GameScreen + #602, #32
  static GameScreen + #603, #2825
  static GameScreen + #604, #32
  static GameScreen + #605, #69
  static GameScreen + #606, #32
  static GameScreen + #607, #2825
  static GameScreen + #608, #32
  static GameScreen + #609, #265
  static GameScreen + #610, #2313
  static GameScreen + #611, #2825
  static GameScreen + #612, #9
  static GameScreen + #613, #3081
  static GameScreen + #614, #32
  static GameScreen + #615, #32
  static GameScreen + #616, #32
  static GameScreen + #617, #3081
  static GameScreen + #618, #32
  static GameScreen + #619, #32
  static GameScreen + #620, #32
  static GameScreen + #621, #3081
  static GameScreen + #622, #32
  static GameScreen + #623, #32
  static GameScreen + #624, #32
  static GameScreen + #625, #3081
  static GameScreen + #626, #9
  static GameScreen + #627, #2825
  static GameScreen + #628, #2313
  static GameScreen + #629, #1289
  static GameScreen + #630, #1545
  static GameScreen + #631, #1289
  static GameScreen + #632, #32
  static GameScreen + #633, #32
  static GameScreen + #634, #32
  static GameScreen + #635, #32
  static GameScreen + #636, #32
  static GameScreen + #637, #32
  static GameScreen + #638, #32
  static GameScreen + #639, #2825

  ;Linha 16
  static GameScreen + #640, #2825
  static GameScreen + #641, #32
  static GameScreen + #642, #32
  static GameScreen + #643, #2825
  static GameScreen + #644, #32
  static GameScreen + #645, #82
  static GameScreen + #646, #32
  static GameScreen + #647, #2825
  static GameScreen + #648, #32
  static GameScreen + #649, #265
  static GameScreen + #650, #2313
  static GameScreen + #651, #9
  static GameScreen + #652, #2825
  static GameScreen + #653, #3081
  static GameScreen + #654, #3081
  static GameScreen + #655, #3081
  static GameScreen + #656, #3081
  static GameScreen + #657, #3081
  static GameScreen + #658, #3081
  static GameScreen + #659, #3081
  static GameScreen + #660, #3081
  static GameScreen + #661, #3081
  static GameScreen + #662, #3081
  static GameScreen + #663, #3081
  static GameScreen + #664, #3081
  static GameScreen + #665, #3081
  static GameScreen + #666, #2825
  static GameScreen + #667, #9
  static GameScreen + #668, #2313
  static GameScreen + #669, #1289
  static GameScreen + #670, #1545
  static GameScreen + #671, #1289
  static GameScreen + #672, #32
  static GameScreen + #673, #32
  static GameScreen + #674, #32
  static GameScreen + #675, #32
  static GameScreen + #676, #32
  static GameScreen + #677, #32
  static GameScreen + #678, #32
  static GameScreen + #679, #2825

  ;Linha 17
  static GameScreen + #680, #2825
  static GameScreen + #681, #32
  static GameScreen + #682, #32
  static GameScreen + #683, #2825
  static GameScreen + #684, #32
  static GameScreen + #685, #32
  static GameScreen + #686, #32
  static GameScreen + #687, #2825
  static GameScreen + #688, #2825
  static GameScreen + #689, #2313
  static GameScreen + #690, #2313
  static GameScreen + #691, #2825
  static GameScreen + #692, #9
  static GameScreen + #693, #9
  static GameScreen + #694, #9
  static GameScreen + #695, #9
  static GameScreen + #696, #9
  static GameScreen + #697, #9
  static GameScreen + #698, #9
  static GameScreen + #699, #9
  static GameScreen + #700, #9
  static GameScreen + #701, #9
  static GameScreen + #702, #9
  static GameScreen + #703, #9
  static GameScreen + #704, #9
  static GameScreen + #705, #9
  static GameScreen + #706, #9
  static GameScreen + #707, #2825
  static GameScreen + #708, #2313
  static GameScreen + #709, #2313
  static GameScreen + #710, #1545
  static GameScreen + #711, #1289
  static GameScreen + #712, #32
  static GameScreen + #713, #32
  static GameScreen + #714, #32
  static GameScreen + #715, #32
  static GameScreen + #716, #32
  static GameScreen + #717, #32
  static GameScreen + #718, #32
  static GameScreen + #719, #2825

  ;Linha 18
  static GameScreen + #720, #2825
  static GameScreen + #721, #32
  static GameScreen + #722, #32
  static GameScreen + #723, #2825
  static GameScreen + #724, #2825
  static GameScreen + #725, #2825
  static GameScreen + #726, #2825
  static GameScreen + #727, #2825
  static GameScreen + #728, #32
  static GameScreen + #729, #2313
  static GameScreen + #730, #2313
  static GameScreen + #731, #9
  static GameScreen + #732, #2825
  static GameScreen + #733, #9
  static GameScreen + #734, #9
  static GameScreen + #735, #9
  static GameScreen + #736, #9
  static GameScreen + #737, #9
  static GameScreen + #738, #9
  static GameScreen + #739, #9
  static GameScreen + #740, #9
  static GameScreen + #741, #9
  static GameScreen + #742, #9
  static GameScreen + #743, #9
  static GameScreen + #744, #9
  static GameScreen + #745, #9
  static GameScreen + #746, #2825
  static GameScreen + #747, #9
  static GameScreen + #748, #2313
  static GameScreen + #749, #2313
  static GameScreen + #750, #1289
  static GameScreen + #751, #1289
  static GameScreen + #752, #32
  static GameScreen + #753, #32
  static GameScreen + #754, #32
  static GameScreen + #755, #32
  static GameScreen + #756, #32
  static GameScreen + #757, #32
  static GameScreen + #758, #32
  static GameScreen + #759, #2825

  ;Linha 19
  static GameScreen + #760, #2825
  static GameScreen + #761, #32
  static GameScreen + #762, #32
  static GameScreen + #763, #32
  static GameScreen + #764, #32
  static GameScreen + #765, #32
  static GameScreen + #766, #32
  static GameScreen + #767, #32
  static GameScreen + #768, #32
  static GameScreen + #769, #2313
  static GameScreen + #770, #2313
  static GameScreen + #771, #2825
  static GameScreen + #772, #9
  static GameScreen + #773, #9
  static GameScreen + #774, #9
  static GameScreen + #775, #9
  static GameScreen + #776, #9
  static GameScreen + #777, #9
  static GameScreen + #778, #9
  static GameScreen + #779, #9
  static GameScreen + #780, #9
  static GameScreen + #781, #9
  static GameScreen + #782, #9
  static GameScreen + #783, #9
  static GameScreen + #784, #9
  static GameScreen + #785, #9
  static GameScreen + #786, #9
  static GameScreen + #787, #2825
  static GameScreen + #788, #2313
  static GameScreen + #789, #2313
  static GameScreen + #790, #1289
  static GameScreen + #791, #1289
  static GameScreen + #792, #32
  static GameScreen + #793, #32
  static GameScreen + #794, #32
  static GameScreen + #795, #32
  static GameScreen + #796, #32
  static GameScreen + #797, #32
  static GameScreen + #798, #32
  static GameScreen + #799, #2825

  ;Linha 20
  static GameScreen + #800, #2825
  static GameScreen + #801, #32
  static GameScreen + #802, #32
  static GameScreen + #803, #32
  static GameScreen + #804, #32
  static GameScreen + #805, #32
  static GameScreen + #806, #32
  static GameScreen + #807, #32
  static GameScreen + #808, #32
  static GameScreen + #809, #265
  static GameScreen + #810, #265
  static GameScreen + #811, #265
  static GameScreen + #812, #265
  static GameScreen + #813, #265
  static GameScreen + #814, #265
  static GameScreen + #815, #265
  static GameScreen + #816, #265
  static GameScreen + #817, #265
  static GameScreen + #818, #265
  static GameScreen + #819, #265
  static GameScreen + #820, #265
  static GameScreen + #821, #265
  static GameScreen + #822, #265
  static GameScreen + #823, #265
  static GameScreen + #824, #265
  static GameScreen + #825, #265
  static GameScreen + #826, #265
  static GameScreen + #827, #265
  static GameScreen + #828, #265
  static GameScreen + #829, #265
  static GameScreen + #830, #1289
  static GameScreen + #831, #1289
  static GameScreen + #832, #32
  static GameScreen + #833, #32
  static GameScreen + #834, #32
  static GameScreen + #835, #32
  static GameScreen + #836, #32
  static GameScreen + #837, #32
  static GameScreen + #838, #32
  static GameScreen + #839, #2825

  ;Linha 21
  static GameScreen + #840, #2825
  static GameScreen + #841, #32
  static GameScreen + #842, #32
  static GameScreen + #843, #32
  static GameScreen + #844, #32
  static GameScreen + #845, #32
  static GameScreen + #846, #32
  static GameScreen + #847, #32
  static GameScreen + #848, #32
  static GameScreen + #849, #1033
  static GameScreen + #850, #3081
  static GameScreen + #851, #1033
  static GameScreen + #852, #265
  static GameScreen + #853, #265
  static GameScreen + #854, #265
  static GameScreen + #855, #265
  static GameScreen + #856, #265
  static GameScreen + #857, #265
  static GameScreen + #858, #265
  static GameScreen + #859, #265
  static GameScreen + #860, #265
  static GameScreen + #861, #265
  static GameScreen + #862, #265
  static GameScreen + #863, #265
  static GameScreen + #864, #265
  static GameScreen + #865, #265
  static GameScreen + #866, #265
  static GameScreen + #867, #1033
  static GameScreen + #868, #3081
  static GameScreen + #869, #1033
  static GameScreen + #870, #32
  static GameScreen + #871, #32
  static GameScreen + #872, #32
  static GameScreen + #873, #32
  static GameScreen + #874, #32
  static GameScreen + #875, #32
  static GameScreen + #876, #32
  static GameScreen + #877, #32
  static GameScreen + #878, #32
  static GameScreen + #879, #2825

  ;Linha 22
  static GameScreen + #880, #2825
  static GameScreen + #881, #32
  static GameScreen + #882, #32
  static GameScreen + #883, #32
  static GameScreen + #884, #32
  static GameScreen + #885, #32
  static GameScreen + #886, #32
  static GameScreen + #887, #32
  static GameScreen + #888, #1033
  static GameScreen + #889, #3081
  static GameScreen + #890, #1033
  static GameScreen + #891, #2313
  static GameScreen + #892, #2825
  static GameScreen + #893, #2313
  static GameScreen + #894, #2313
  static GameScreen + #895, #2313
  static GameScreen + #896, #2313
  static GameScreen + #897, #2313
  static GameScreen + #898, #2313
  static GameScreen + #899, #2313
  static GameScreen + #900, #2313
  static GameScreen + #901, #2313
  static GameScreen + #902, #2313
  static GameScreen + #903, #2313
  static GameScreen + #904, #2313
  static GameScreen + #905, #2313
  static GameScreen + #906, #2825
  static GameScreen + #907, #2313
  static GameScreen + #908, #1033
  static GameScreen + #909, #3081
  static GameScreen + #910, #1033
  static GameScreen + #911, #32
  static GameScreen + #912, #32
  static GameScreen + #913, #32
  static GameScreen + #914, #32
  static GameScreen + #915, #32
  static GameScreen + #916, #32
  static GameScreen + #917, #32
  static GameScreen + #918, #32
  static GameScreen + #919, #2825

  ;Linha 23
  static GameScreen + #920, #2825
  static GameScreen + #921, #32
  static GameScreen + #922, #32
  static GameScreen + #923, #32
  static GameScreen + #924, #32
  static GameScreen + #925, #32
  static GameScreen + #926, #32
  static GameScreen + #927, #1033
  static GameScreen + #928, #3081
  static GameScreen + #929, #1033
  static GameScreen + #930, #2313
  static GameScreen + #931, #2313
  static GameScreen + #932, #2313
  static GameScreen + #933, #2313
  static GameScreen + #934, #2313
  static GameScreen + #935, #2313
  static GameScreen + #936, #2313
  static GameScreen + #937, #2313
  static GameScreen + #938, #2313
  static GameScreen + #939, #2313
  static GameScreen + #940, #2313
  static GameScreen + #941, #2313
  static GameScreen + #942, #2313
  static GameScreen + #943, #2313
  static GameScreen + #944, #2313
  static GameScreen + #945, #2825
  static GameScreen + #946, #2825
  static GameScreen + #947, #2313
  static GameScreen + #948, #2313
  static GameScreen + #949, #1033
  static GameScreen + #950, #3081
  static GameScreen + #951, #1033
  static GameScreen + #952, #32
  static GameScreen + #953, #32
  static GameScreen + #954, #32
  static GameScreen + #955, #32
  static GameScreen + #956, #32
  static GameScreen + #957, #32
  static GameScreen + #958, #32
  static GameScreen + #959, #2825

  ;Linha 24
  static GameScreen + #960, #2825
  static GameScreen + #961, #32
  static GameScreen + #962, #32
  static GameScreen + #963, #32
  static GameScreen + #964, #32
  static GameScreen + #965, #32
  static GameScreen + #966, #1033
  static GameScreen + #967, #3081
  static GameScreen + #968, #1033
  static GameScreen + #969, #2313
  static GameScreen + #970, #2313
  static GameScreen + #971, #2313
  static GameScreen + #972, #2313
  static GameScreen + #973, #2313
  static GameScreen + #974, #2313
  static GameScreen + #975, #2313
  static GameScreen + #976, #2313
  static GameScreen + #977, #2313
  static GameScreen + #978, #2313
  static GameScreen + #979, #2313
  static GameScreen + #980, #2313
  static GameScreen + #981, #2313
  static GameScreen + #982, #2313
  static GameScreen + #983, #2313
  static GameScreen + #984, #2313
  static GameScreen + #985, #2313
  static GameScreen + #986, #2313
  static GameScreen + #987, #2313
  static GameScreen + #988, #2313
  static GameScreen + #989, #2313
  static GameScreen + #990, #1033
  static GameScreen + #991, #3081
  static GameScreen + #992, #1033
  static GameScreen + #993, #32
  static GameScreen + #994, #32
  static GameScreen + #995, #32
  static GameScreen + #996, #32
  static GameScreen + #997, #32
  static GameScreen + #998, #32
  static GameScreen + #999, #2825

  ;Linha 25
  static GameScreen + #1000, #2825
  static GameScreen + #1001, #32
  static GameScreen + #1002, #32
  static GameScreen + #1003, #32
  static GameScreen + #1004, #32
  static GameScreen + #1005, #32
  static GameScreen + #1006, #265
  static GameScreen + #1007, #265
  static GameScreen + #1008, #265
  static GameScreen + #1009, #265
  static GameScreen + #1010, #265
  static GameScreen + #1011, #265
  static GameScreen + #1012, #265
  static GameScreen + #1013, #265
  static GameScreen + #1014, #265
  static GameScreen + #1015, #265
  static GameScreen + #1016, #265
  static GameScreen + #1017, #265
  static GameScreen + #1018, #265
  static GameScreen + #1019, #265
  static GameScreen + #1020, #265
  static GameScreen + #1021, #265
  static GameScreen + #1022, #265
  static GameScreen + #1023, #265
  static GameScreen + #1024, #265
  static GameScreen + #1025, #265
  static GameScreen + #1026, #265
  static GameScreen + #1027, #265
  static GameScreen + #1028, #265
  static GameScreen + #1029, #265
  static GameScreen + #1030, #265
  static GameScreen + #1031, #265
  static GameScreen + #1032, #265
  static GameScreen + #1033, #32
  static GameScreen + #1034, #32
  static GameScreen + #1035, #32
  static GameScreen + #1036, #32
  static GameScreen + #1037, #32
  static GameScreen + #1038, #32
  static GameScreen + #1039, #2825

  ;Linha 26
  static GameScreen + #1040, #2825
  static GameScreen + #1041, #32
  static GameScreen + #1042, #32
  static GameScreen + #1043, #32
  static GameScreen + #1044, #32
  static GameScreen + #1045, #32
  static GameScreen + #1046, #265
  static GameScreen + #1047, #265
  static GameScreen + #1048, #265
  static GameScreen + #1049, #2825
  static GameScreen + #1050, #3081
  static GameScreen + #1051, #3081
  static GameScreen + #1052, #2313
  static GameScreen + #1053, #2313
  static GameScreen + #1054, #2313
  static GameScreen + #1055, #2313
  static GameScreen + #1056, #2313
  static GameScreen + #1057, #2313
  static GameScreen + #1058, #2313
  static GameScreen + #1059, #2313
  static GameScreen + #1060, #2313
  static GameScreen + #1061, #2313
  static GameScreen + #1062, #2313
  static GameScreen + #1063, #2313
  static GameScreen + #1064, #2313
  static GameScreen + #1065, #2313
  static GameScreen + #1066, #2313
  static GameScreen + #1067, #3081
  static GameScreen + #1068, #3081
  static GameScreen + #1069, #2825
  static GameScreen + #1070, #265
  static GameScreen + #1071, #265
  static GameScreen + #1072, #265
  static GameScreen + #1073, #32
  static GameScreen + #1074, #32
  static GameScreen + #1075, #32
  static GameScreen + #1076, #32
  static GameScreen + #1077, #32
  static GameScreen + #1078, #32
  static GameScreen + #1079, #2825

  ;Linha 27
  static GameScreen + #1080, #2825
  static GameScreen + #1081, #32
  static GameScreen + #1082, #32
  static GameScreen + #1083, #32
  static GameScreen + #1084, #32
  static GameScreen + #1085, #32
  static GameScreen + #1086, #265
  static GameScreen + #1087, #265
  static GameScreen + #1088, #265
  static GameScreen + #1089, #3081
  static GameScreen + #1090, #2825
  static GameScreen + #1091, #3081
  static GameScreen + #1092, #2313
  static GameScreen + #1093, #265
  static GameScreen + #1094, #2313
  static GameScreen + #1095, #2313
  static GameScreen + #1096, #2313
  static GameScreen + #1097, #2313
  static GameScreen + #1098, #2313
  static GameScreen + #1099, #2313
  static GameScreen + #1100, #2313
  static GameScreen + #1101, #2313
  static GameScreen + #1102, #2313
  static GameScreen + #1103, #2313
  static GameScreen + #1104, #2313
  static GameScreen + #1105, #265
  static GameScreen + #1106, #2313
  static GameScreen + #1107, #3081
  static GameScreen + #1108, #2825
  static GameScreen + #1109, #3081
  static GameScreen + #1110, #265
  static GameScreen + #1111, #265
  static GameScreen + #1112, #265
  static GameScreen + #1113, #32
  static GameScreen + #1114, #32
  static GameScreen + #1115, #32
  static GameScreen + #1116, #32
  static GameScreen + #1117, #32
  static GameScreen + #1118, #32
  static GameScreen + #1119, #2825

  ;Linha 28
  static GameScreen + #1120, #2825
  static GameScreen + #1121, #32
  static GameScreen + #1122, #32
  static GameScreen + #1123, #32
  static GameScreen + #1124, #32
  static GameScreen + #1125, #32
  static GameScreen + #1126, #265
  static GameScreen + #1127, #265
  static GameScreen + #1128, #265
  static GameScreen + #1129, #2825
  static GameScreen + #1130, #3081
  static GameScreen + #1131, #3081
  static GameScreen + #1132, #2313
  static GameScreen + #1133, #2313
  static GameScreen + #1134, #2313
  static GameScreen + #1135, #2313
  static GameScreen + #1136, #2313
  static GameScreen + #1137, #2313
  static GameScreen + #1138, #2313
  static GameScreen + #1139, #2313
  static GameScreen + #1140, #2313
  static GameScreen + #1141, #2313
  static GameScreen + #1142, #2313
  static GameScreen + #1143, #2313
  static GameScreen + #1144, #2313
  static GameScreen + #1145, #265
  static GameScreen + #1146, #2313
  static GameScreen + #1147, #3081
  static GameScreen + #1148, #3081
  static GameScreen + #1149, #2825
  static GameScreen + #1150, #265
  static GameScreen + #1151, #265
  static GameScreen + #1152, #265
  static GameScreen + #1153, #32
  static GameScreen + #1154, #32
  static GameScreen + #1155, #32
  static GameScreen + #1156, #32
  static GameScreen + #1157, #32
  static GameScreen + #1158, #32
  static GameScreen + #1159, #2825

  ;Linha 29
  static GameScreen + #1160, #2825
  static GameScreen + #1161, #2825
  static GameScreen + #1162, #2825
  static GameScreen + #1163, #2825
  static GameScreen + #1164, #2825
  static GameScreen + #1165, #2825
  static GameScreen + #1166, #265
  static GameScreen + #1167, #265
  static GameScreen + #1168, #265
  static GameScreen + #1169, #3081
  static GameScreen + #1170, #2825
  static GameScreen + #1171, #3081
  static GameScreen + #1172, #2313
  static GameScreen + #1173, #2313
  static GameScreen + #1174, #2313
  static GameScreen + #1175, #2313
  static GameScreen + #1176, #2313
  static GameScreen + #1177, #2313
  static GameScreen + #1178, #2313
  static GameScreen + #1179, #2313
  static GameScreen + #1180, #2313
  static GameScreen + #1181, #2313
  static GameScreen + #1182, #2313
  static GameScreen + #1183, #2313
  static GameScreen + #1184, #2313
  static GameScreen + #1185, #2313
  static GameScreen + #1186, #2313
  static GameScreen + #1187, #3081
  static GameScreen + #1188, #2825
  static GameScreen + #1189, #3081
  static GameScreen + #1190, #265
  static GameScreen + #1191, #265
  static GameScreen + #1192, #265
  static GameScreen + #1193, #2825
  static GameScreen + #1194, #2825
  static GameScreen + #1195, #2825
  static GameScreen + #1196, #2825
  static GameScreen + #1197, #2825
  static GameScreen + #1198, #2825
  static GameScreen + #1199, #2825
;

InitialScreen1 : var #1200
  ;Linha 0
  static InitialScreen1 + #0, #2825
  static InitialScreen1 + #1, #2825
  static InitialScreen1 + #2, #2825
  static InitialScreen1 + #3, #2825
  static InitialScreen1 + #4, #2825
  static InitialScreen1 + #5, #2825
  static InitialScreen1 + #6, #2825
  static InitialScreen1 + #7, #2825
  static InitialScreen1 + #8, #2825
  static InitialScreen1 + #9, #2825
  static InitialScreen1 + #10, #2825
  static InitialScreen1 + #11, #2825
  static InitialScreen1 + #12, #2825
  static InitialScreen1 + #13, #2825
  static InitialScreen1 + #14, #2825
  static InitialScreen1 + #15, #2825
  static InitialScreen1 + #16, #2825
  static InitialScreen1 + #17, #2825
  static InitialScreen1 + #18, #2825
  static InitialScreen1 + #19, #2825
  static InitialScreen1 + #20, #2825
  static InitialScreen1 + #21, #2825
  static InitialScreen1 + #22, #2825
  static InitialScreen1 + #23, #2825
  static InitialScreen1 + #24, #2825
  static InitialScreen1 + #25, #2825
  static InitialScreen1 + #26, #2825
  static InitialScreen1 + #27, #2825
  static InitialScreen1 + #28, #2825
  static InitialScreen1 + #29, #2825
  static InitialScreen1 + #30, #2825
  static InitialScreen1 + #31, #2825
  static InitialScreen1 + #32, #2825
  static InitialScreen1 + #33, #2825
  static InitialScreen1 + #34, #2825
  static InitialScreen1 + #35, #2825
  static InitialScreen1 + #36, #2825
  static InitialScreen1 + #37, #2825
  static InitialScreen1 + #38, #2825
  static InitialScreen1 + #39, #2825

  ;Linha 1
  static InitialScreen1 + #40, #2825
  static InitialScreen1 + #41, #32
  static InitialScreen1 + #42, #32
  static InitialScreen1 + #43, #32
  static InitialScreen1 + #44, #32
  static InitialScreen1 + #45, #32
  static InitialScreen1 + #46, #32
  static InitialScreen1 + #47, #32
  static InitialScreen1 + #48, #32
  static InitialScreen1 + #49, #32
  static InitialScreen1 + #50, #32
  static InitialScreen1 + #51, #32
  static InitialScreen1 + #52, #32
  static InitialScreen1 + #53, #32
  static InitialScreen1 + #54, #32
  static InitialScreen1 + #55, #32
  static InitialScreen1 + #56, #32
  static InitialScreen1 + #57, #32
  static InitialScreen1 + #58, #32
  static InitialScreen1 + #59, #32
  static InitialScreen1 + #60, #32
  static InitialScreen1 + #61, #32
  static InitialScreen1 + #62, #32
  static InitialScreen1 + #63, #32
  static InitialScreen1 + #64, #32
  static InitialScreen1 + #65, #32
  static InitialScreen1 + #66, #32
  static InitialScreen1 + #67, #32
  static InitialScreen1 + #68, #32
  static InitialScreen1 + #69, #32
  static InitialScreen1 + #70, #32
  static InitialScreen1 + #71, #32
  static InitialScreen1 + #72, #32
  static InitialScreen1 + #73, #32
  static InitialScreen1 + #74, #32
  static InitialScreen1 + #75, #32
  static InitialScreen1 + #76, #32
  static InitialScreen1 + #77, #32
  static InitialScreen1 + #78, #32
  static InitialScreen1 + #79, #2825

  ;Linha 2
  static InitialScreen1 + #80, #2825
  static InitialScreen1 + #81, #32
  static InitialScreen1 + #82, #32
  static InitialScreen1 + #83, #32
  static InitialScreen1 + #84, #32
  static InitialScreen1 + #85, #32
  static InitialScreen1 + #86, #32
  static InitialScreen1 + #87, #32
  static InitialScreen1 + #88, #32
  static InitialScreen1 + #89, #32
  static InitialScreen1 + #90, #32
  static InitialScreen1 + #91, #32
  static InitialScreen1 + #92, #32
  static InitialScreen1 + #93, #32
  static InitialScreen1 + #94, #32
  static InitialScreen1 + #95, #32
  static InitialScreen1 + #96, #32
  static InitialScreen1 + #97, #32
  static InitialScreen1 + #98, #32
  static InitialScreen1 + #99, #2313
  static InitialScreen1 + #100, #32
  static InitialScreen1 + #101, #32
  static InitialScreen1 + #102, #32
  static InitialScreen1 + #103, #32
  static InitialScreen1 + #104, #32
  static InitialScreen1 + #105, #32
  static InitialScreen1 + #106, #32
  static InitialScreen1 + #107, #32
  static InitialScreen1 + #108, #32
  static InitialScreen1 + #109, #32
  static InitialScreen1 + #110, #32
  static InitialScreen1 + #111, #32
  static InitialScreen1 + #112, #32
  static InitialScreen1 + #113, #32
  static InitialScreen1 + #114, #32
  static InitialScreen1 + #115, #32
  static InitialScreen1 + #116, #32
  static InitialScreen1 + #117, #32
  static InitialScreen1 + #118, #32
  static InitialScreen1 + #119, #2825

  ;Linha 3
  static InitialScreen1 + #120, #2825
  static InitialScreen1 + #121, #32
  static InitialScreen1 + #122, #32
  static InitialScreen1 + #123, #32
  static InitialScreen1 + #124, #32
  static InitialScreen1 + #125, #32
  static InitialScreen1 + #126, #32
  static InitialScreen1 + #127, #32
  static InitialScreen1 + #128, #32
  static InitialScreen1 + #129, #32
  static InitialScreen1 + #130, #32
  static InitialScreen1 + #131, #32
  static InitialScreen1 + #132, #32
  static InitialScreen1 + #133, #32
  static InitialScreen1 + #134, #32
  static InitialScreen1 + #135, #32
  static InitialScreen1 + #136, #32
  static InitialScreen1 + #137, #32
  static InitialScreen1 + #138, #32
  static InitialScreen1 + #139, #2313
  static InitialScreen1 + #140, #2313
  static InitialScreen1 + #141, #32
  static InitialScreen1 + #142, #32
  static InitialScreen1 + #143, #32
  static InitialScreen1 + #144, #32
  static InitialScreen1 + #145, #32
  static InitialScreen1 + #146, #32
  static InitialScreen1 + #147, #32
  static InitialScreen1 + #148, #32
  static InitialScreen1 + #149, #32
  static InitialScreen1 + #150, #32
  static InitialScreen1 + #151, #32
  static InitialScreen1 + #152, #32
  static InitialScreen1 + #153, #32
  static InitialScreen1 + #154, #32
  static InitialScreen1 + #155, #32
  static InitialScreen1 + #156, #32
  static InitialScreen1 + #157, #32
  static InitialScreen1 + #158, #32
  static InitialScreen1 + #159, #2825

  ;Linha 4
  static InitialScreen1 + #160, #2825
  static InitialScreen1 + #161, #32
  static InitialScreen1 + #162, #32
  static InitialScreen1 + #163, #32
  static InitialScreen1 + #164, #32
  static InitialScreen1 + #165, #32
  static InitialScreen1 + #166, #32
  static InitialScreen1 + #167, #32
  static InitialScreen1 + #168, #32
  static InitialScreen1 + #169, #32
  static InitialScreen1 + #170, #32
  static InitialScreen1 + #171, #32
  static InitialScreen1 + #172, #32
  static InitialScreen1 + #173, #32
  static InitialScreen1 + #174, #32
  static InitialScreen1 + #175, #32
  static InitialScreen1 + #176, #32
  static InitialScreen1 + #177, #32
  static InitialScreen1 + #178, #32
  static InitialScreen1 + #179, #32
  static InitialScreen1 + #180, #2313
  static InitialScreen1 + #181, #2313
  static InitialScreen1 + #182, #32
  static InitialScreen1 + #183, #32
  static InitialScreen1 + #184, #32
  static InitialScreen1 + #185, #32
  static InitialScreen1 + #186, #32
  static InitialScreen1 + #187, #32
  static InitialScreen1 + #188, #32
  static InitialScreen1 + #189, #32
  static InitialScreen1 + #190, #32
  static InitialScreen1 + #191, #32
  static InitialScreen1 + #192, #32
  static InitialScreen1 + #193, #32
  static InitialScreen1 + #194, #32
  static InitialScreen1 + #195, #32
  static InitialScreen1 + #196, #32
  static InitialScreen1 + #197, #32
  static InitialScreen1 + #198, #32
  static InitialScreen1 + #199, #2825

  ;Linha 5
  static InitialScreen1 + #200, #2825
  static InitialScreen1 + #201, #32
  static InitialScreen1 + #202, #32
  static InitialScreen1 + #203, #32
  static InitialScreen1 + #204, #32
  static InitialScreen1 + #205, #32
  static InitialScreen1 + #206, #32
  static InitialScreen1 + #207, #32
  static InitialScreen1 + #208, #32
  static InitialScreen1 + #209, #32
  static InitialScreen1 + #210, #32
  static InitialScreen1 + #211, #32
  static InitialScreen1 + #212, #32
  static InitialScreen1 + #213, #32
  static InitialScreen1 + #214, #32
  static InitialScreen1 + #215, #32
  static InitialScreen1 + #216, #32
  static InitialScreen1 + #217, #32
  static InitialScreen1 + #218, #32
  static InitialScreen1 + #219, #32
  static InitialScreen1 + #220, #2313
  static InitialScreen1 + #221, #2313
  static InitialScreen1 + #222, #32
  static InitialScreen1 + #223, #32
  static InitialScreen1 + #224, #32
  static InitialScreen1 + #225, #32
  static InitialScreen1 + #226, #32
  static InitialScreen1 + #227, #32
  static InitialScreen1 + #228, #32
  static InitialScreen1 + #229, #32
  static InitialScreen1 + #230, #32
  static InitialScreen1 + #231, #32
  static InitialScreen1 + #232, #32
  static InitialScreen1 + #233, #32
  static InitialScreen1 + #234, #32
  static InitialScreen1 + #235, #32
  static InitialScreen1 + #236, #32
  static InitialScreen1 + #237, #32
  static InitialScreen1 + #238, #32
  static InitialScreen1 + #239, #2825

  ;Linha 6
  static InitialScreen1 + #240, #2825
  static InitialScreen1 + #241, #32
  static InitialScreen1 + #242, #32
  static InitialScreen1 + #243, #32
  static InitialScreen1 + #244, #32
  static InitialScreen1 + #245, #32
  static InitialScreen1 + #246, #32
  static InitialScreen1 + #247, #32
  static InitialScreen1 + #248, #32
  static InitialScreen1 + #249, #32
  static InitialScreen1 + #250, #32
  static InitialScreen1 + #251, #32
  static InitialScreen1 + #252, #32
  static InitialScreen1 + #253, #32
  static InitialScreen1 + #254, #32
  static InitialScreen1 + #255, #2313
  static InitialScreen1 + #256, #32
  static InitialScreen1 + #257, #32
  static InitialScreen1 + #258, #32
  static InitialScreen1 + #259, #32
  static InitialScreen1 + #260, #2313
  static InitialScreen1 + #261, #2313
  static InitialScreen1 + #262, #2313
  static InitialScreen1 + #263, #32
  static InitialScreen1 + #264, #32
  static InitialScreen1 + #265, #32
  static InitialScreen1 + #266, #32
  static InitialScreen1 + #267, #32
  static InitialScreen1 + #268, #32
  static InitialScreen1 + #269, #32
  static InitialScreen1 + #270, #32
  static InitialScreen1 + #271, #32
  static InitialScreen1 + #272, #32
  static InitialScreen1 + #273, #32
  static InitialScreen1 + #274, #32
  static InitialScreen1 + #275, #32
  static InitialScreen1 + #276, #32
  static InitialScreen1 + #277, #32
  static InitialScreen1 + #278, #32
  static InitialScreen1 + #279, #2825

  ;Linha 7
  static InitialScreen1 + #280, #2825
  static InitialScreen1 + #281, #32
  static InitialScreen1 + #282, #32
  static InitialScreen1 + #283, #32
  static InitialScreen1 + #284, #32
  static InitialScreen1 + #285, #32
  static InitialScreen1 + #286, #32
  static InitialScreen1 + #287, #32
  static InitialScreen1 + #288, #32
  static InitialScreen1 + #289, #32
  static InitialScreen1 + #290, #32
  static InitialScreen1 + #291, #32
  static InitialScreen1 + #292, #32
  static InitialScreen1 + #293, #32
  static InitialScreen1 + #294, #32
  static InitialScreen1 + #295, #2313
  static InitialScreen1 + #296, #2313
  static InitialScreen1 + #297, #32
  static InitialScreen1 + #298, #32
  static InitialScreen1 + #299, #2313
  static InitialScreen1 + #300, #2313
  static InitialScreen1 + #301, #2313
  static InitialScreen1 + #302, #2313
  static InitialScreen1 + #303, #2313
  static InitialScreen1 + #304, #32
  static InitialScreen1 + #305, #32
  static InitialScreen1 + #306, #32
  static InitialScreen1 + #307, #32
  static InitialScreen1 + #308, #32
  static InitialScreen1 + #309, #32
  static InitialScreen1 + #310, #32
  static InitialScreen1 + #311, #32
  static InitialScreen1 + #312, #32
  static InitialScreen1 + #313, #32
  static InitialScreen1 + #314, #32
  static InitialScreen1 + #315, #32
  static InitialScreen1 + #316, #32
  static InitialScreen1 + #317, #32
  static InitialScreen1 + #318, #32
  static InitialScreen1 + #319, #2825

  ;Linha 8
  static InitialScreen1 + #320, #2825
  static InitialScreen1 + #321, #32
  static InitialScreen1 + #322, #32
  static InitialScreen1 + #323, #32
  static InitialScreen1 + #324, #32
  static InitialScreen1 + #325, #32
  static InitialScreen1 + #326, #32
  static InitialScreen1 + #327, #32
  static InitialScreen1 + #328, #32
  static InitialScreen1 + #329, #32
  static InitialScreen1 + #330, #32
  static InitialScreen1 + #331, #32
  static InitialScreen1 + #332, #32
  static InitialScreen1 + #333, #32
  static InitialScreen1 + #334, #32
  static InitialScreen1 + #335, #2313
  static InitialScreen1 + #336, #2313
  static InitialScreen1 + #337, #2313
  static InitialScreen1 + #338, #2313
  static InitialScreen1 + #339, #2313
  static InitialScreen1 + #340, #2313
  static InitialScreen1 + #341, #2313
  static InitialScreen1 + #342, #2313
  static InitialScreen1 + #343, #2313
  static InitialScreen1 + #344, #32
  static InitialScreen1 + #345, #32
  static InitialScreen1 + #346, #32
  static InitialScreen1 + #347, #32
  static InitialScreen1 + #348, #32
  static InitialScreen1 + #349, #32
  static InitialScreen1 + #350, #32
  static InitialScreen1 + #351, #32
  static InitialScreen1 + #352, #32
  static InitialScreen1 + #353, #32
  static InitialScreen1 + #354, #32
  static InitialScreen1 + #355, #32
  static InitialScreen1 + #356, #32
  static InitialScreen1 + #357, #32
  static InitialScreen1 + #358, #32
  static InitialScreen1 + #359, #2825

  ;Linha 9
  static InitialScreen1 + #360, #2825
  static InitialScreen1 + #361, #32
  static InitialScreen1 + #362, #32
  static InitialScreen1 + #363, #32
  static InitialScreen1 + #364, #32
  static InitialScreen1 + #365, #32
  static InitialScreen1 + #366, #32
  static InitialScreen1 + #367, #32
  static InitialScreen1 + #368, #32
  static InitialScreen1 + #369, #32
  static InitialScreen1 + #370, #32
  static InitialScreen1 + #371, #32
  static InitialScreen1 + #372, #32
  static InitialScreen1 + #373, #32
  static InitialScreen1 + #374, #2313
  static InitialScreen1 + #375, #2313
  static InitialScreen1 + #376, #2313
  static InitialScreen1 + #377, #2313
  static InitialScreen1 + #378, #2313
  static InitialScreen1 + #379, #9
  static InitialScreen1 + #380, #2313
  static InitialScreen1 + #381, #2313
  static InitialScreen1 + #382, #2313
  static InitialScreen1 + #383, #2313
  static InitialScreen1 + #384, #2313
  static InitialScreen1 + #385, #32
  static InitialScreen1 + #386, #32
  static InitialScreen1 + #387, #32
  static InitialScreen1 + #388, #32
  static InitialScreen1 + #389, #32
  static InitialScreen1 + #390, #32
  static InitialScreen1 + #391, #32
  static InitialScreen1 + #392, #32
  static InitialScreen1 + #393, #32
  static InitialScreen1 + #394, #32
  static InitialScreen1 + #395, #32
  static InitialScreen1 + #396, #32
  static InitialScreen1 + #397, #32
  static InitialScreen1 + #398, #32
  static InitialScreen1 + #399, #2825

  ;Linha 10
  static InitialScreen1 + #400, #2825
  static InitialScreen1 + #401, #32
  static InitialScreen1 + #402, #32
  static InitialScreen1 + #403, #32
  static InitialScreen1 + #404, #32
  static InitialScreen1 + #405, #32
  static InitialScreen1 + #406, #32
  static InitialScreen1 + #407, #32
  static InitialScreen1 + #408, #32
  static InitialScreen1 + #409, #32
  static InitialScreen1 + #410, #32
  static InitialScreen1 + #411, #32
  static InitialScreen1 + #412, #32
  static InitialScreen1 + #413, #32
  static InitialScreen1 + #414, #2313
  static InitialScreen1 + #415, #2313
  static InitialScreen1 + #416, #2313
  static InitialScreen1 + #417, #2313
  static InitialScreen1 + #418, #9
  static InitialScreen1 + #419, #9
  static InitialScreen1 + #420, #9
  static InitialScreen1 + #421, #2313
  static InitialScreen1 + #422, #2313
  static InitialScreen1 + #423, #2313
  static InitialScreen1 + #424, #2313
  static InitialScreen1 + #425, #32
  static InitialScreen1 + #426, #32
  static InitialScreen1 + #427, #32
  static InitialScreen1 + #428, #32
  static InitialScreen1 + #429, #32
  static InitialScreen1 + #430, #32
  static InitialScreen1 + #431, #32
  static InitialScreen1 + #432, #32
  static InitialScreen1 + #433, #32
  static InitialScreen1 + #434, #32
  static InitialScreen1 + #435, #32
  static InitialScreen1 + #436, #32
  static InitialScreen1 + #437, #32
  static InitialScreen1 + #438, #32
  static InitialScreen1 + #439, #2825

  ;Linha 11
  static InitialScreen1 + #440, #2825
  static InitialScreen1 + #441, #32
  static InitialScreen1 + #442, #32
  static InitialScreen1 + #443, #32
  static InitialScreen1 + #444, #32
  static InitialScreen1 + #445, #32
  static InitialScreen1 + #446, #32
  static InitialScreen1 + #447, #32
  static InitialScreen1 + #448, #32
  static InitialScreen1 + #449, #32
  static InitialScreen1 + #450, #32
  static InitialScreen1 + #451, #32
  static InitialScreen1 + #452, #32
  static InitialScreen1 + #453, #32
  static InitialScreen1 + #454, #2313
  static InitialScreen1 + #455, #2313
  static InitialScreen1 + #456, #2313
  static InitialScreen1 + #457, #9
  static InitialScreen1 + #458, #9
  static InitialScreen1 + #459, #2313
  static InitialScreen1 + #460, #9
  static InitialScreen1 + #461, #9
  static InitialScreen1 + #462, #2313
  static InitialScreen1 + #463, #2313
  static InitialScreen1 + #464, #2313
  static InitialScreen1 + #465, #32
  static InitialScreen1 + #466, #32
  static InitialScreen1 + #467, #32
  static InitialScreen1 + #468, #32
  static InitialScreen1 + #469, #32
  static InitialScreen1 + #470, #32
  static InitialScreen1 + #471, #32
  static InitialScreen1 + #472, #32
  static InitialScreen1 + #473, #32
  static InitialScreen1 + #474, #32
  static InitialScreen1 + #475, #32
  static InitialScreen1 + #476, #32
  static InitialScreen1 + #477, #32
  static InitialScreen1 + #478, #32
  static InitialScreen1 + #479, #2825

  ;Linha 12
  static InitialScreen1 + #480, #2825
  static InitialScreen1 + #481, #32
  static InitialScreen1 + #482, #32
  static InitialScreen1 + #483, #32
  static InitialScreen1 + #484, #32
  static InitialScreen1 + #485, #32
  static InitialScreen1 + #486, #32
  static InitialScreen1 + #487, #32
  static InitialScreen1 + #488, #32
  static InitialScreen1 + #489, #32
  static InitialScreen1 + #490, #32
  static InitialScreen1 + #491, #32
  static InitialScreen1 + #492, #32
  static InitialScreen1 + #493, #2313
  static InitialScreen1 + #494, #2313
  static InitialScreen1 + #495, #2313
  static InitialScreen1 + #496, #9
  static InitialScreen1 + #497, #9
  static InitialScreen1 + #498, #9
  static InitialScreen1 + #499, #9
  static InitialScreen1 + #500, #9
  static InitialScreen1 + #501, #9
  static InitialScreen1 + #502, #9
  static InitialScreen1 + #503, #2313
  static InitialScreen1 + #504, #2313
  static InitialScreen1 + #505, #2313
  static InitialScreen1 + #506, #32
  static InitialScreen1 + #507, #32
  static InitialScreen1 + #508, #32
  static InitialScreen1 + #509, #32
  static InitialScreen1 + #510, #32
  static InitialScreen1 + #511, #32
  static InitialScreen1 + #512, #32
  static InitialScreen1 + #513, #32
  static InitialScreen1 + #514, #32
  static InitialScreen1 + #515, #32
  static InitialScreen1 + #516, #32
  static InitialScreen1 + #517, #32
  static InitialScreen1 + #518, #32
  static InitialScreen1 + #519, #2825

  ;Linha 13
  static InitialScreen1 + #520, #2825
  static InitialScreen1 + #521, #32
  static InitialScreen1 + #522, #32
  static InitialScreen1 + #523, #32
  static InitialScreen1 + #524, #32
  static InitialScreen1 + #525, #32
  static InitialScreen1 + #526, #32
  static InitialScreen1 + #527, #32
  static InitialScreen1 + #528, #32
  static InitialScreen1 + #529, #32
  static InitialScreen1 + #530, #32
  static InitialScreen1 + #531, #32
  static InitialScreen1 + #532, #32
  static InitialScreen1 + #533, #2313
  static InitialScreen1 + #534, #2313
  static InitialScreen1 + #535, #9
  static InitialScreen1 + #536, #9
  static InitialScreen1 + #537, #9
  static InitialScreen1 + #538, #9
  static InitialScreen1 + #539, #9
  static InitialScreen1 + #540, #9
  static InitialScreen1 + #541, #9
  static InitialScreen1 + #542, #9
  static InitialScreen1 + #543, #9
  static InitialScreen1 + #544, #2313
  static InitialScreen1 + #545, #2313
  static InitialScreen1 + #546, #32
  static InitialScreen1 + #547, #32
  static InitialScreen1 + #548, #32
  static InitialScreen1 + #549, #32
  static InitialScreen1 + #550, #32
  static InitialScreen1 + #551, #32
  static InitialScreen1 + #552, #32
  static InitialScreen1 + #553, #32
  static InitialScreen1 + #554, #32
  static InitialScreen1 + #555, #32
  static InitialScreen1 + #556, #32
  static InitialScreen1 + #557, #32
  static InitialScreen1 + #558, #32
  static InitialScreen1 + #559, #2825

  ;Linha 14
  static InitialScreen1 + #560, #2825
  static InitialScreen1 + #561, #32
  static InitialScreen1 + #562, #32
  static InitialScreen1 + #563, #32
  static InitialScreen1 + #564, #32
  static InitialScreen1 + #565, #32
  static InitialScreen1 + #566, #32
  static InitialScreen1 + #567, #32
  static InitialScreen1 + #568, #32
  static InitialScreen1 + #569, #32
  static InitialScreen1 + #570, #32
  static InitialScreen1 + #571, #32
  static InitialScreen1 + #572, #32
  static InitialScreen1 + #573, #2313
  static InitialScreen1 + #574, #9
  static InitialScreen1 + #575, #9
  static InitialScreen1 + #576, #2313
  static InitialScreen1 + #577, #9
  static InitialScreen1 + #578, #9
  static InitialScreen1 + #579, #2313
  static InitialScreen1 + #580, #9
  static InitialScreen1 + #581, #9
  static InitialScreen1 + #582, #2313
  static InitialScreen1 + #583, #9
  static InitialScreen1 + #584, #9
  static InitialScreen1 + #585, #2313
  static InitialScreen1 + #586, #32
  static InitialScreen1 + #587, #32
  static InitialScreen1 + #588, #32
  static InitialScreen1 + #589, #32
  static InitialScreen1 + #590, #32
  static InitialScreen1 + #591, #32
  static InitialScreen1 + #592, #32
  static InitialScreen1 + #593, #32
  static InitialScreen1 + #594, #32
  static InitialScreen1 + #595, #32
  static InitialScreen1 + #596, #32
  static InitialScreen1 + #597, #32
  static InitialScreen1 + #598, #32
  static InitialScreen1 + #599, #2825

  ;Linha 15
  static InitialScreen1 + #600, #2825
  static InitialScreen1 + #601, #32
  static InitialScreen1 + #602, #32
  static InitialScreen1 + #603, #32
  static InitialScreen1 + #604, #32
  static InitialScreen1 + #605, #32
  static InitialScreen1 + #606, #32
  static InitialScreen1 + #607, #32
  static InitialScreen1 + #608, #32
  static InitialScreen1 + #609, #32
  static InitialScreen1 + #610, #32
  static InitialScreen1 + #611, #32
  static InitialScreen1 + #612, #32
  static InitialScreen1 + #613, #2313
  static InitialScreen1 + #614, #2313
  static InitialScreen1 + #615, #9
  static InitialScreen1 + #616, #9
  static InitialScreen1 + #617, #9
  static InitialScreen1 + #618, #9
  static InitialScreen1 + #619, #9
  static InitialScreen1 + #620, #9
  static InitialScreen1 + #621, #9
  static InitialScreen1 + #622, #9
  static InitialScreen1 + #623, #9
  static InitialScreen1 + #624, #2313
  static InitialScreen1 + #625, #2313
  static InitialScreen1 + #626, #32
  static InitialScreen1 + #627, #32
  static InitialScreen1 + #628, #32
  static InitialScreen1 + #629, #32
  static InitialScreen1 + #630, #32
  static InitialScreen1 + #631, #32
  static InitialScreen1 + #632, #32
  static InitialScreen1 + #633, #32
  static InitialScreen1 + #634, #32
  static InitialScreen1 + #635, #32
  static InitialScreen1 + #636, #32
  static InitialScreen1 + #637, #32
  static InitialScreen1 + #638, #32
  static InitialScreen1 + #639, #2825

  ;Linha 16
  static InitialScreen1 + #640, #2825
  static InitialScreen1 + #641, #32
  static InitialScreen1 + #642, #32
  static InitialScreen1 + #643, #32
  static InitialScreen1 + #644, #32
  static InitialScreen1 + #645, #32
  static InitialScreen1 + #646, #32
  static InitialScreen1 + #647, #32
  static InitialScreen1 + #648, #32
  static InitialScreen1 + #649, #32
  static InitialScreen1 + #650, #32
  static InitialScreen1 + #651, #32
  static InitialScreen1 + #652, #32
  static InitialScreen1 + #653, #32
  static InitialScreen1 + #654, #2313
  static InitialScreen1 + #655, #2313
  static InitialScreen1 + #656, #9
  static InitialScreen1 + #657, #9
  static InitialScreen1 + #658, #9
  static InitialScreen1 + #659, #9
  static InitialScreen1 + #660, #9
  static InitialScreen1 + #661, #9
  static InitialScreen1 + #662, #9
  static InitialScreen1 + #663, #2313
  static InitialScreen1 + #664, #2313
  static InitialScreen1 + #665, #32
  static InitialScreen1 + #666, #32
  static InitialScreen1 + #667, #32
  static InitialScreen1 + #668, #32
  static InitialScreen1 + #669, #32
  static InitialScreen1 + #670, #32
  static InitialScreen1 + #671, #32
  static InitialScreen1 + #672, #32
  static InitialScreen1 + #673, #32
  static InitialScreen1 + #674, #32
  static InitialScreen1 + #675, #32
  static InitialScreen1 + #676, #32
  static InitialScreen1 + #677, #32
  static InitialScreen1 + #678, #32
  static InitialScreen1 + #679, #2825

  ;Linha 17
  static InitialScreen1 + #680, #2825
  static InitialScreen1 + #681, #32
  static InitialScreen1 + #682, #32
  static InitialScreen1 + #683, #32
  static InitialScreen1 + #684, #32
  static InitialScreen1 + #685, #32
  static InitialScreen1 + #686, #32
  static InitialScreen1 + #687, #32
  static InitialScreen1 + #688, #32
  static InitialScreen1 + #689, #32
  static InitialScreen1 + #690, #32
  static InitialScreen1 + #691, #32
  static InitialScreen1 + #692, #32
  static InitialScreen1 + #693, #32
  static InitialScreen1 + #694, #32
  static InitialScreen1 + #695, #2313
  static InitialScreen1 + #696, #2313
  static InitialScreen1 + #697, #9
  static InitialScreen1 + #698, #9
  static InitialScreen1 + #699, #2313
  static InitialScreen1 + #700, #9
  static InitialScreen1 + #701, #9
  static InitialScreen1 + #702, #2313
  static InitialScreen1 + #703, #2313
  static InitialScreen1 + #704, #32
  static InitialScreen1 + #705, #32
  static InitialScreen1 + #706, #32
  static InitialScreen1 + #707, #32
  static InitialScreen1 + #708, #32
  static InitialScreen1 + #709, #32
  static InitialScreen1 + #710, #32
  static InitialScreen1 + #711, #32
  static InitialScreen1 + #712, #32
  static InitialScreen1 + #713, #32
  static InitialScreen1 + #714, #32
  static InitialScreen1 + #715, #32
  static InitialScreen1 + #716, #32
  static InitialScreen1 + #717, #32
  static InitialScreen1 + #718, #32
  static InitialScreen1 + #719, #2825

  ;Linha 18
  static InitialScreen1 + #720, #2825
  static InitialScreen1 + #721, #32
  static InitialScreen1 + #722, #32
  static InitialScreen1 + #723, #32
  static InitialScreen1 + #724, #32
  static InitialScreen1 + #725, #32
  static InitialScreen1 + #726, #32
  static InitialScreen1 + #727, #32
  static InitialScreen1 + #728, #32
  static InitialScreen1 + #729, #32
  static InitialScreen1 + #730, #32
  static InitialScreen1 + #731, #32
  static InitialScreen1 + #732, #32
  static InitialScreen1 + #733, #32
  static InitialScreen1 + #734, #32
  static InitialScreen1 + #735, #32
  static InitialScreen1 + #736, #2313
  static InitialScreen1 + #737, #2313
  static InitialScreen1 + #738, #9
  static InitialScreen1 + #739, #9
  static InitialScreen1 + #740, #9
  static InitialScreen1 + #741, #2313
  static InitialScreen1 + #742, #2313
  static InitialScreen1 + #743, #32
  static InitialScreen1 + #744, #32
  static InitialScreen1 + #745, #32
  static InitialScreen1 + #746, #32
  static InitialScreen1 + #747, #32
  static InitialScreen1 + #748, #32
  static InitialScreen1 + #749, #32
  static InitialScreen1 + #750, #32
  static InitialScreen1 + #751, #32
  static InitialScreen1 + #752, #32
  static InitialScreen1 + #753, #32
  static InitialScreen1 + #754, #32
  static InitialScreen1 + #755, #32
  static InitialScreen1 + #756, #32
  static InitialScreen1 + #757, #32
  static InitialScreen1 + #758, #32
  static InitialScreen1 + #759, #2825

  ;Linha 19
  static InitialScreen1 + #760, #2825
  static InitialScreen1 + #761, #32
  static InitialScreen1 + #762, #32
  static InitialScreen1 + #763, #32
  static InitialScreen1 + #764, #32
  static InitialScreen1 + #765, #32
  static InitialScreen1 + #766, #32
  static InitialScreen1 + #767, #32
  static InitialScreen1 + #768, #32
  static InitialScreen1 + #769, #32
  static InitialScreen1 + #770, #32
  static InitialScreen1 + #771, #32
  static InitialScreen1 + #772, #32
  static InitialScreen1 + #773, #32
  static InitialScreen1 + #774, #32
  static InitialScreen1 + #775, #32
  static InitialScreen1 + #776, #32
  static InitialScreen1 + #777, #2313
  static InitialScreen1 + #778, #2313
  static InitialScreen1 + #779, #9
  static InitialScreen1 + #780, #2313
  static InitialScreen1 + #781, #2313
  static InitialScreen1 + #782, #32
  static InitialScreen1 + #783, #32
  static InitialScreen1 + #784, #32
  static InitialScreen1 + #785, #32
  static InitialScreen1 + #786, #32
  static InitialScreen1 + #787, #32
  static InitialScreen1 + #788, #32
  static InitialScreen1 + #789, #32
  static InitialScreen1 + #790, #32
  static InitialScreen1 + #791, #32
  static InitialScreen1 + #792, #32
  static InitialScreen1 + #793, #32
  static InitialScreen1 + #794, #32
  static InitialScreen1 + #795, #32
  static InitialScreen1 + #796, #32
  static InitialScreen1 + #797, #32
  static InitialScreen1 + #798, #32
  static InitialScreen1 + #799, #2825

  ;Linha 20
  static InitialScreen1 + #800, #2825
  static InitialScreen1 + #801, #32
  static InitialScreen1 + #802, #32
  static InitialScreen1 + #803, #32
  static InitialScreen1 + #804, #32
  static InitialScreen1 + #805, #32
  static InitialScreen1 + #806, #32
  static InitialScreen1 + #807, #32
  static InitialScreen1 + #808, #32
  static InitialScreen1 + #809, #32
  static InitialScreen1 + #810, #32
  static InitialScreen1 + #811, #32
  static InitialScreen1 + #812, #32
  static InitialScreen1 + #813, #32
  static InitialScreen1 + #814, #32
  static InitialScreen1 + #815, #32
  static InitialScreen1 + #816, #32
  static InitialScreen1 + #817, #32
  static InitialScreen1 + #818, #2313
  static InitialScreen1 + #819, #2313
  static InitialScreen1 + #820, #2313
  static InitialScreen1 + #821, #32
  static InitialScreen1 + #822, #32
  static InitialScreen1 + #823, #32
  static InitialScreen1 + #824, #32
  static InitialScreen1 + #825, #32
  static InitialScreen1 + #826, #32
  static InitialScreen1 + #827, #32
  static InitialScreen1 + #828, #32
  static InitialScreen1 + #829, #32
  static InitialScreen1 + #830, #32
  static InitialScreen1 + #831, #32
  static InitialScreen1 + #832, #32
  static InitialScreen1 + #833, #32
  static InitialScreen1 + #834, #32
  static InitialScreen1 + #835, #32
  static InitialScreen1 + #836, #32
  static InitialScreen1 + #837, #32
  static InitialScreen1 + #838, #32
  static InitialScreen1 + #839, #2825

  ;Linha 21
  static InitialScreen1 + #840, #2825
  static InitialScreen1 + #841, #32
  static InitialScreen1 + #842, #32
  static InitialScreen1 + #843, #32
  static InitialScreen1 + #844, #32
  static InitialScreen1 + #845, #32
  static InitialScreen1 + #846, #32
  static InitialScreen1 + #847, #32
  static InitialScreen1 + #848, #32
  static InitialScreen1 + #849, #32
  static InitialScreen1 + #850, #32
  static InitialScreen1 + #851, #32
  static InitialScreen1 + #852, #32
  static InitialScreen1 + #853, #32
  static InitialScreen1 + #854, #32
  static InitialScreen1 + #855, #32
  static InitialScreen1 + #856, #32
  static InitialScreen1 + #857, #32
  static InitialScreen1 + #858, #32
  static InitialScreen1 + #859, #2313
  static InitialScreen1 + #860, #32
  static InitialScreen1 + #861, #32
  static InitialScreen1 + #862, #32
  static InitialScreen1 + #863, #32
  static InitialScreen1 + #864, #32
  static InitialScreen1 + #865, #32
  static InitialScreen1 + #866, #32
  static InitialScreen1 + #867, #32
  static InitialScreen1 + #868, #32
  static InitialScreen1 + #869, #32
  static InitialScreen1 + #870, #32
  static InitialScreen1 + #871, #32
  static InitialScreen1 + #872, #32
  static InitialScreen1 + #873, #32
  static InitialScreen1 + #874, #32
  static InitialScreen1 + #875, #32
  static InitialScreen1 + #876, #32
  static InitialScreen1 + #877, #32
  static InitialScreen1 + #878, #32
  static InitialScreen1 + #879, #2825

  ;Linha 22
  static InitialScreen1 + #880, #2825
  static InitialScreen1 + #881, #32
  static InitialScreen1 + #882, #32
  static InitialScreen1 + #883, #32
  static InitialScreen1 + #884, #32
  static InitialScreen1 + #885, #32
  static InitialScreen1 + #886, #32
  static InitialScreen1 + #887, #32
  static InitialScreen1 + #888, #32
  static InitialScreen1 + #889, #32
  static InitialScreen1 + #890, #32
  static InitialScreen1 + #891, #32
  static InitialScreen1 + #892, #32
  static InitialScreen1 + #893, #32
  static InitialScreen1 + #894, #32
  static InitialScreen1 + #895, #32
  static InitialScreen1 + #896, #32
  static InitialScreen1 + #897, #32
  static InitialScreen1 + #898, #32
  static InitialScreen1 + #899, #32
  static InitialScreen1 + #900, #32
  static InitialScreen1 + #901, #32
  static InitialScreen1 + #902, #32
  static InitialScreen1 + #903, #32
  static InitialScreen1 + #904, #32
  static InitialScreen1 + #905, #32
  static InitialScreen1 + #906, #32
  static InitialScreen1 + #907, #32
  static InitialScreen1 + #908, #32
  static InitialScreen1 + #909, #32
  static InitialScreen1 + #910, #32
  static InitialScreen1 + #911, #32
  static InitialScreen1 + #912, #32
  static InitialScreen1 + #913, #32
  static InitialScreen1 + #914, #32
  static InitialScreen1 + #915, #32
  static InitialScreen1 + #916, #32
  static InitialScreen1 + #917, #32
  static InitialScreen1 + #918, #32
  static InitialScreen1 + #919, #2825

  ;Linha 23
  static InitialScreen1 + #920, #2825
  static InitialScreen1 + #921, #32
  static InitialScreen1 + #922, #32
  static InitialScreen1 + #923, #32
  static InitialScreen1 + #924, #32
  static InitialScreen1 + #925, #32
  static InitialScreen1 + #926, #32
  static InitialScreen1 + #927, #32
  static InitialScreen1 + #928, #32
  static InitialScreen1 + #929, #32
  static InitialScreen1 + #930, #32
  static InitialScreen1 + #931, #32
  static InitialScreen1 + #932, #32
  static InitialScreen1 + #933, #32
  static InitialScreen1 + #934, #32
  static InitialScreen1 + #935, #32
  static InitialScreen1 + #936, #32
  static InitialScreen1 + #937, #32
  static InitialScreen1 + #938, #32
  static InitialScreen1 + #939, #32
  static InitialScreen1 + #940, #32
  static InitialScreen1 + #941, #32
  static InitialScreen1 + #942, #32
  static InitialScreen1 + #943, #32
  static InitialScreen1 + #944, #32
  static InitialScreen1 + #945, #32
  static InitialScreen1 + #946, #32
  static InitialScreen1 + #947, #32
  static InitialScreen1 + #948, #32
  static InitialScreen1 + #949, #32
  static InitialScreen1 + #950, #32
  static InitialScreen1 + #951, #32
  static InitialScreen1 + #952, #32
  static InitialScreen1 + #953, #32
  static InitialScreen1 + #954, #32
  static InitialScreen1 + #955, #32
  static InitialScreen1 + #956, #32
  static InitialScreen1 + #957, #32
  static InitialScreen1 + #958, #32
  static InitialScreen1 + #959, #2825

  ;Linha 24
  static InitialScreen1 + #960, #2825
  static InitialScreen1 + #961, #32
  static InitialScreen1 + #962, #32
  static InitialScreen1 + #963, #32
  static InitialScreen1 + #964, #32
  static InitialScreen1 + #965, #32
  static InitialScreen1 + #966, #32
  static InitialScreen1 + #967, #32
  static InitialScreen1 + #968, #32
  static InitialScreen1 + #969, #32
  static InitialScreen1 + #970, #32
  static InitialScreen1 + #971, #32
  static InitialScreen1 + #972, #32
  static InitialScreen1 + #973, #32
  static InitialScreen1 + #974, #32
  static InitialScreen1 + #975, #32
  static InitialScreen1 + #976, #2882
  static InitialScreen1 + #977, #2885
  static InitialScreen1 + #978, #2900
  static InitialScreen1 + #979, #32
  static InitialScreen1 + #980, #2901
  static InitialScreen1 + #981, #2899
  static InitialScreen1 + #982, #2896
  static InitialScreen1 + #983, #32
  static InitialScreen1 + #984, #32
  static InitialScreen1 + #985, #32
  static InitialScreen1 + #986, #32
  static InitialScreen1 + #987, #32
  static InitialScreen1 + #988, #32
  static InitialScreen1 + #989, #32
  static InitialScreen1 + #990, #32
  static InitialScreen1 + #991, #32
  static InitialScreen1 + #992, #32
  static InitialScreen1 + #993, #32
  static InitialScreen1 + #994, #32
  static InitialScreen1 + #995, #32
  static InitialScreen1 + #996, #32
  static InitialScreen1 + #997, #32
  static InitialScreen1 + #998, #32
  static InitialScreen1 + #999, #2825

  ;Linha 25
  static InitialScreen1 + #1000, #2825
  static InitialScreen1 + #1001, #32
  static InitialScreen1 + #1002, #32
  static InitialScreen1 + #1003, #32
  static InitialScreen1 + #1004, #32
  static InitialScreen1 + #1005, #32
  static InitialScreen1 + #1006, #32
  static InitialScreen1 + #1007, #32
  static InitialScreen1 + #1008, #32
  static InitialScreen1 + #1009, #32
  static InitialScreen1 + #1010, #32
  static InitialScreen1 + #1011, #32
  static InitialScreen1 + #1012, #32
  static InitialScreen1 + #1013, #32
  static InitialScreen1 + #1014, #32
  static InitialScreen1 + #1015, #32
  static InitialScreen1 + #1016, #32
  static InitialScreen1 + #1017, #32
  static InitialScreen1 + #1018, #32
  static InitialScreen1 + #1019, #32
  static InitialScreen1 + #1020, #32
  static InitialScreen1 + #1021, #32
  static InitialScreen1 + #1022, #32
  static InitialScreen1 + #1023, #32
  static InitialScreen1 + #1024, #32
  static InitialScreen1 + #1025, #32
  static InitialScreen1 + #1026, #32
  static InitialScreen1 + #1027, #32
  static InitialScreen1 + #1028, #32
  static InitialScreen1 + #1029, #32
  static InitialScreen1 + #1030, #32
  static InitialScreen1 + #1031, #32
  static InitialScreen1 + #1032, #32
  static InitialScreen1 + #1033, #32
  static InitialScreen1 + #1034, #32
  static InitialScreen1 + #1035, #32
  static InitialScreen1 + #1036, #32
  static InitialScreen1 + #1037, #32
  static InitialScreen1 + #1038, #32
  static InitialScreen1 + #1039, #2825

  ;Linha 26
  static InitialScreen1 + #1040, #2825
  static InitialScreen1 + #1041, #32
  static InitialScreen1 + #1042, #32
  static InitialScreen1 + #1043, #32
  static InitialScreen1 + #1044, #32
  static InitialScreen1 + #1045, #32
  static InitialScreen1 + #1046, #32
  static InitialScreen1 + #1047, #32
  static InitialScreen1 + #1048, #32
  static InitialScreen1 + #1049, #32
  static InitialScreen1 + #1050, #32
  static InitialScreen1 + #1051, #32
  static InitialScreen1 + #1052, #32
  static InitialScreen1 + #1053, #2907
  static InitialScreen1 + #1054, #32
  static InitialScreen1 + #1055, #2879
  static InitialScreen1 + #1056, #32
  static InitialScreen1 + #1057, #2900
  static InitialScreen1 + #1058, #2933
  static InitialScreen1 + #1059, #2932
  static InitialScreen1 + #1060, #2927
  static InitialScreen1 + #1061, #2930
  static InitialScreen1 + #1062, #2921
  static InitialScreen1 + #1063, #2913
  static InitialScreen1 + #1064, #2924
  static InitialScreen1 + #1065, #2909
  static InitialScreen1 + #1066, #32
  static InitialScreen1 + #1067, #32
  static InitialScreen1 + #1068, #32
  static InitialScreen1 + #1069, #32
  static InitialScreen1 + #1070, #32
  static InitialScreen1 + #1071, #32
  static InitialScreen1 + #1072, #32
  static InitialScreen1 + #1073, #32
  static InitialScreen1 + #1074, #32
  static InitialScreen1 + #1075, #32
  static InitialScreen1 + #1076, #32
  static InitialScreen1 + #1077, #32
  static InitialScreen1 + #1078, #32
  static InitialScreen1 + #1079, #2825

  ;Linha 27
  static InitialScreen1 + #1080, #2825
  static InitialScreen1 + #1081, #32
  static InitialScreen1 + #1082, #32
  static InitialScreen1 + #1083, #32
  static InitialScreen1 + #1084, #32
  static InitialScreen1 + #1085, #32
  static InitialScreen1 + #1086, #32
  static InitialScreen1 + #1087, #32
  static InitialScreen1 + #1088, #32
  static InitialScreen1 + #1089, #32
  static InitialScreen1 + #1090, #32
  static InitialScreen1 + #1091, #32
  static InitialScreen1 + #1092, #32
  static InitialScreen1 + #1093, #2907
  static InitialScreen1 + #1094, #2885
  static InitialScreen1 + #1095, #2926
  static InitialScreen1 + #1096, #2932
  static InitialScreen1 + #1097, #2917
  static InitialScreen1 + #1098, #2930
  static InitialScreen1 + #1099, #32
  static InitialScreen1 + #1100, #2890
  static InitialScreen1 + #1101, #2927
  static InitialScreen1 + #1102, #2919
  static InitialScreen1 + #1103, #2913
  static InitialScreen1 + #1104, #2930
  static InitialScreen1 + #1105, #2909
  static InitialScreen1 + #1106, #32
  static InitialScreen1 + #1107, #32
  static InitialScreen1 + #1108, #32
  static InitialScreen1 + #1109, #32
  static InitialScreen1 + #1110, #32
  static InitialScreen1 + #1111, #32
  static InitialScreen1 + #1112, #32
  static InitialScreen1 + #1113, #32
  static InitialScreen1 + #1114, #32
  static InitialScreen1 + #1115, #32
  static InitialScreen1 + #1116, #32
  static InitialScreen1 + #1117, #32
  static InitialScreen1 + #1118, #32
  static InitialScreen1 + #1119, #2825

  ;Linha 28
  static InitialScreen1 + #1120, #2825
  static InitialScreen1 + #1121, #32
  static InitialScreen1 + #1122, #32
  static InitialScreen1 + #1123, #32
  static InitialScreen1 + #1124, #32
  static InitialScreen1 + #1125, #32
  static InitialScreen1 + #1126, #32
  static InitialScreen1 + #1127, #32
  static InitialScreen1 + #1128, #32
  static InitialScreen1 + #1129, #32
  static InitialScreen1 + #1130, #32
  static InitialScreen1 + #1131, #32
  static InitialScreen1 + #1132, #32
  static InitialScreen1 + #1133, #32
  static InitialScreen1 + #1134, #32
  static InitialScreen1 + #1135, #32
  static InitialScreen1 + #1136, #32
  static InitialScreen1 + #1137, #32
  static InitialScreen1 + #1138, #32
  static InitialScreen1 + #1139, #32
  static InitialScreen1 + #1140, #32
  static InitialScreen1 + #1141, #32
  static InitialScreen1 + #1142, #32
  static InitialScreen1 + #1143, #32
  static InitialScreen1 + #1144, #32
  static InitialScreen1 + #1145, #32
  static InitialScreen1 + #1146, #32
  static InitialScreen1 + #1147, #32
  static InitialScreen1 + #1148, #32
  static InitialScreen1 + #1149, #32
  static InitialScreen1 + #1150, #32
  static InitialScreen1 + #1151, #32
  static InitialScreen1 + #1152, #32
  static InitialScreen1 + #1153, #32
  static InitialScreen1 + #1154, #32
  static InitialScreen1 + #1155, #32
  static InitialScreen1 + #1156, #32
  static InitialScreen1 + #1157, #32
  static InitialScreen1 + #1158, #32
  static InitialScreen1 + #1159, #2825

  ;Linha 29
  static InitialScreen1 + #1160, #2825
  static InitialScreen1 + #1161, #2825
  static InitialScreen1 + #1162, #2825
  static InitialScreen1 + #1163, #2825
  static InitialScreen1 + #1164, #2825
  static InitialScreen1 + #1165, #2825
  static InitialScreen1 + #1166, #2825
  static InitialScreen1 + #1167, #2825
  static InitialScreen1 + #1168, #2825
  static InitialScreen1 + #1169, #2825
  static InitialScreen1 + #1170, #2825
  static InitialScreen1 + #1171, #2825
  static InitialScreen1 + #1172, #2825
  static InitialScreen1 + #1173, #2825
  static InitialScreen1 + #1174, #2825
  static InitialScreen1 + #1175, #2825
  static InitialScreen1 + #1176, #2825
  static InitialScreen1 + #1177, #2825
  static InitialScreen1 + #1178, #2825
  static InitialScreen1 + #1179, #2825
  static InitialScreen1 + #1180, #2825
  static InitialScreen1 + #1181, #2825
  static InitialScreen1 + #1182, #2825
  static InitialScreen1 + #1183, #2825
  static InitialScreen1 + #1184, #2825
  static InitialScreen1 + #1185, #2825
  static InitialScreen1 + #1186, #2825
  static InitialScreen1 + #1187, #2825
  static InitialScreen1 + #1188, #2825
  static InitialScreen1 + #1189, #2825
  static InitialScreen1 + #1190, #2825
  static InitialScreen1 + #1191, #2825
  static InitialScreen1 + #1192, #2825
  static InitialScreen1 + #1193, #2825
  static InitialScreen1 + #1194, #2825
  static InitialScreen1 + #1195, #2825
  static InitialScreen1 + #1196, #2825
  static InitialScreen1 + #1197, #2825
  static InitialScreen1 + #1198, #2825
  static InitialScreen1 + #1199, #2825
;

InitialScreen2 : var #1200
  ;Linha 0
  static InitialScreen2 + #0, #2825
  static InitialScreen2 + #1, #2825
  static InitialScreen2 + #2, #2825
  static InitialScreen2 + #3, #2825
  static InitialScreen2 + #4, #2825
  static InitialScreen2 + #5, #2825
  static InitialScreen2 + #6, #2825
  static InitialScreen2 + #7, #2825
  static InitialScreen2 + #8, #2825
  static InitialScreen2 + #9, #2825
  static InitialScreen2 + #10, #2825
  static InitialScreen2 + #11, #2825
  static InitialScreen2 + #12, #2825
  static InitialScreen2 + #13, #2825
  static InitialScreen2 + #14, #2825
  static InitialScreen2 + #15, #2825
  static InitialScreen2 + #16, #2825
  static InitialScreen2 + #17, #2825
  static InitialScreen2 + #18, #2825
  static InitialScreen2 + #19, #2825
  static InitialScreen2 + #20, #2825
  static InitialScreen2 + #21, #2825
  static InitialScreen2 + #22, #2825
  static InitialScreen2 + #23, #2825
  static InitialScreen2 + #24, #2825
  static InitialScreen2 + #25, #2825
  static InitialScreen2 + #26, #2825
  static InitialScreen2 + #27, #2825
  static InitialScreen2 + #28, #2825
  static InitialScreen2 + #29, #2825
  static InitialScreen2 + #30, #2825
  static InitialScreen2 + #31, #2825
  static InitialScreen2 + #32, #2825
  static InitialScreen2 + #33, #2825
  static InitialScreen2 + #34, #2825
  static InitialScreen2 + #35, #2825
  static InitialScreen2 + #36, #2825
  static InitialScreen2 + #37, #2825
  static InitialScreen2 + #38, #2825
  static InitialScreen2 + #39, #2825

  ;Linha 1
  static InitialScreen2 + #40, #2825
  static InitialScreen2 + #41, #32
  static InitialScreen2 + #42, #32
  static InitialScreen2 + #43, #32
  static InitialScreen2 + #44, #32
  static InitialScreen2 + #45, #32
  static InitialScreen2 + #46, #32
  static InitialScreen2 + #47, #32
  static InitialScreen2 + #48, #32
  static InitialScreen2 + #49, #32
  static InitialScreen2 + #50, #32
  static InitialScreen2 + #51, #32
  static InitialScreen2 + #52, #32
  static InitialScreen2 + #53, #32
  static InitialScreen2 + #54, #32
  static InitialScreen2 + #55, #32
  static InitialScreen2 + #56, #32
  static InitialScreen2 + #57, #32
  static InitialScreen2 + #58, #32
  static InitialScreen2 + #59, #32
  static InitialScreen2 + #60, #32
  static InitialScreen2 + #61, #32
  static InitialScreen2 + #62, #32
  static InitialScreen2 + #63, #32
  static InitialScreen2 + #64, #32
  static InitialScreen2 + #65, #32
  static InitialScreen2 + #66, #32
  static InitialScreen2 + #67, #32
  static InitialScreen2 + #68, #32
  static InitialScreen2 + #69, #32
  static InitialScreen2 + #70, #32
  static InitialScreen2 + #71, #32
  static InitialScreen2 + #72, #32
  static InitialScreen2 + #73, #32
  static InitialScreen2 + #74, #32
  static InitialScreen2 + #75, #32
  static InitialScreen2 + #76, #32
  static InitialScreen2 + #77, #32
  static InitialScreen2 + #78, #32
  static InitialScreen2 + #79, #2825

  ;Linha 2
  static InitialScreen2 + #80, #2825
  static InitialScreen2 + #81, #32
  static InitialScreen2 + #82, #32
  static InitialScreen2 + #83, #32
  static InitialScreen2 + #84, #32
  static InitialScreen2 + #85, #32
  static InitialScreen2 + #86, #32
  static InitialScreen2 + #87, #32
  static InitialScreen2 + #88, #32
  static InitialScreen2 + #89, #32
  static InitialScreen2 + #90, #32
  static InitialScreen2 + #91, #32
  static InitialScreen2 + #92, #32
  static InitialScreen2 + #93, #32
  static InitialScreen2 + #94, #32
  static InitialScreen2 + #95, #32
  static InitialScreen2 + #96, #32
  static InitialScreen2 + #97, #32
  static InitialScreen2 + #98, #32
  static InitialScreen2 + #99, #32
  static InitialScreen2 + #100, #32
  static InitialScreen2 + #101, #32
  static InitialScreen2 + #102, #32
  static InitialScreen2 + #103, #32
  static InitialScreen2 + #104, #32
  static InitialScreen2 + #105, #32
  static InitialScreen2 + #106, #32
  static InitialScreen2 + #107, #32
  static InitialScreen2 + #108, #32
  static InitialScreen2 + #109, #32
  static InitialScreen2 + #110, #32
  static InitialScreen2 + #111, #32
  static InitialScreen2 + #112, #32
  static InitialScreen2 + #113, #32
  static InitialScreen2 + #114, #32
  static InitialScreen2 + #115, #32
  static InitialScreen2 + #116, #32
  static InitialScreen2 + #117, #32
  static InitialScreen2 + #118, #32
  static InitialScreen2 + #119, #2825

  ;Linha 3
  static InitialScreen2 + #120, #2825
  static InitialScreen2 + #121, #32
  static InitialScreen2 + #122, #32
  static InitialScreen2 + #123, #32
  static InitialScreen2 + #124, #32
  static InitialScreen2 + #125, #32
  static InitialScreen2 + #126, #32
  static InitialScreen2 + #127, #32
  static InitialScreen2 + #128, #32
  static InitialScreen2 + #129, #32
  static InitialScreen2 + #130, #32
  static InitialScreen2 + #131, #32
  static InitialScreen2 + #132, #32
  static InitialScreen2 + #133, #32
  static InitialScreen2 + #134, #32
  static InitialScreen2 + #135, #32
  static InitialScreen2 + #136, #32
  static InitialScreen2 + #137, #32
  static InitialScreen2 + #138, #32
  static InitialScreen2 + #139, #32
  static InitialScreen2 + #140, #32
  static InitialScreen2 + #141, #2313
  static InitialScreen2 + #142, #32
  static InitialScreen2 + #143, #32
  static InitialScreen2 + #144, #32
  static InitialScreen2 + #145, #32
  static InitialScreen2 + #146, #32
  static InitialScreen2 + #147, #32
  static InitialScreen2 + #148, #32
  static InitialScreen2 + #149, #32
  static InitialScreen2 + #150, #32
  static InitialScreen2 + #151, #32
  static InitialScreen2 + #152, #32
  static InitialScreen2 + #153, #32
  static InitialScreen2 + #154, #32
  static InitialScreen2 + #155, #32
  static InitialScreen2 + #156, #32
  static InitialScreen2 + #157, #32
  static InitialScreen2 + #158, #32
  static InitialScreen2 + #159, #2825

  ;Linha 4
  static InitialScreen2 + #160, #2825
  static InitialScreen2 + #161, #32
  static InitialScreen2 + #162, #32
  static InitialScreen2 + #163, #32
  static InitialScreen2 + #164, #32
  static InitialScreen2 + #165, #32
  static InitialScreen2 + #166, #32
  static InitialScreen2 + #167, #32
  static InitialScreen2 + #168, #32
  static InitialScreen2 + #169, #32
  static InitialScreen2 + #170, #32
  static InitialScreen2 + #171, #32
  static InitialScreen2 + #172, #32
  static InitialScreen2 + #173, #32
  static InitialScreen2 + #174, #32
  static InitialScreen2 + #175, #32
  static InitialScreen2 + #176, #32
  static InitialScreen2 + #177, #32
  static InitialScreen2 + #178, #32
  static InitialScreen2 + #179, #32
  static InitialScreen2 + #180, #2313
  static InitialScreen2 + #181, #2313
  static InitialScreen2 + #182, #32
  static InitialScreen2 + #183, #32
  static InitialScreen2 + #184, #32
  static InitialScreen2 + #185, #32
  static InitialScreen2 + #186, #32
  static InitialScreen2 + #187, #32
  static InitialScreen2 + #188, #32
  static InitialScreen2 + #189, #32
  static InitialScreen2 + #190, #32
  static InitialScreen2 + #191, #32
  static InitialScreen2 + #192, #32
  static InitialScreen2 + #193, #32
  static InitialScreen2 + #194, #32
  static InitialScreen2 + #195, #32
  static InitialScreen2 + #196, #32
  static InitialScreen2 + #197, #32
  static InitialScreen2 + #198, #32
  static InitialScreen2 + #199, #2825

  ;Linha 5
  static InitialScreen2 + #200, #2825
  static InitialScreen2 + #201, #32
  static InitialScreen2 + #202, #32
  static InitialScreen2 + #203, #32
  static InitialScreen2 + #204, #32
  static InitialScreen2 + #205, #32
  static InitialScreen2 + #206, #32
  static InitialScreen2 + #207, #32
  static InitialScreen2 + #208, #32
  static InitialScreen2 + #209, #32
  static InitialScreen2 + #210, #32
  static InitialScreen2 + #211, #32
  static InitialScreen2 + #212, #32
  static InitialScreen2 + #213, #32
  static InitialScreen2 + #214, #32
  static InitialScreen2 + #215, #32
  static InitialScreen2 + #216, #32
  static InitialScreen2 + #217, #32
  static InitialScreen2 + #218, #2313
  static InitialScreen2 + #219, #32
  static InitialScreen2 + #220, #2313
  static InitialScreen2 + #221, #2313
  static InitialScreen2 + #222, #32
  static InitialScreen2 + #223, #32
  static InitialScreen2 + #224, #32
  static InitialScreen2 + #225, #32
  static InitialScreen2 + #226, #32
  static InitialScreen2 + #227, #32
  static InitialScreen2 + #228, #32
  static InitialScreen2 + #229, #32
  static InitialScreen2 + #230, #32
  static InitialScreen2 + #231, #32
  static InitialScreen2 + #232, #32
  static InitialScreen2 + #233, #32
  static InitialScreen2 + #234, #32
  static InitialScreen2 + #235, #32
  static InitialScreen2 + #236, #32
  static InitialScreen2 + #237, #32
  static InitialScreen2 + #238, #32
  static InitialScreen2 + #239, #2825

  ;Linha 6
  static InitialScreen2 + #240, #2825
  static InitialScreen2 + #241, #32
  static InitialScreen2 + #242, #32
  static InitialScreen2 + #243, #32
  static InitialScreen2 + #244, #32
  static InitialScreen2 + #245, #32
  static InitialScreen2 + #246, #32
  static InitialScreen2 + #247, #32
  static InitialScreen2 + #248, #32
  static InitialScreen2 + #249, #32
  static InitialScreen2 + #250, #32
  static InitialScreen2 + #251, #32
  static InitialScreen2 + #252, #32
  static InitialScreen2 + #253, #32
  static InitialScreen2 + #254, #32
  static InitialScreen2 + #255, #32
  static InitialScreen2 + #256, #32
  static InitialScreen2 + #257, #2313
  static InitialScreen2 + #258, #32
  static InitialScreen2 + #259, #32
  static InitialScreen2 + #260, #2313
  static InitialScreen2 + #261, #2313
  static InitialScreen2 + #262, #2313
  static InitialScreen2 + #263, #32
  static InitialScreen2 + #264, #32
  static InitialScreen2 + #265, #32
  static InitialScreen2 + #266, #32
  static InitialScreen2 + #267, #32
  static InitialScreen2 + #268, #32
  static InitialScreen2 + #269, #32
  static InitialScreen2 + #270, #32
  static InitialScreen2 + #271, #32
  static InitialScreen2 + #272, #32
  static InitialScreen2 + #273, #32
  static InitialScreen2 + #274, #32
  static InitialScreen2 + #275, #32
  static InitialScreen2 + #276, #32
  static InitialScreen2 + #277, #32
  static InitialScreen2 + #278, #32
  static InitialScreen2 + #279, #2825

  ;Linha 7
  static InitialScreen2 + #280, #2825
  static InitialScreen2 + #281, #32
  static InitialScreen2 + #282, #32
  static InitialScreen2 + #283, #32
  static InitialScreen2 + #284, #32
  static InitialScreen2 + #285, #32
  static InitialScreen2 + #286, #32
  static InitialScreen2 + #287, #32
  static InitialScreen2 + #288, #32
  static InitialScreen2 + #289, #32
  static InitialScreen2 + #290, #32
  static InitialScreen2 + #291, #32
  static InitialScreen2 + #292, #32
  static InitialScreen2 + #293, #32
  static InitialScreen2 + #294, #32
  static InitialScreen2 + #295, #32
  static InitialScreen2 + #296, #2313
  static InitialScreen2 + #297, #2313
  static InitialScreen2 + #298, #32
  static InitialScreen2 + #299, #2313
  static InitialScreen2 + #300, #2313
  static InitialScreen2 + #301, #2313
  static InitialScreen2 + #302, #2313
  static InitialScreen2 + #303, #2313
  static InitialScreen2 + #304, #32
  static InitialScreen2 + #305, #32
  static InitialScreen2 + #306, #32
  static InitialScreen2 + #307, #32
  static InitialScreen2 + #308, #32
  static InitialScreen2 + #309, #32
  static InitialScreen2 + #310, #32
  static InitialScreen2 + #311, #32
  static InitialScreen2 + #312, #32
  static InitialScreen2 + #313, #32
  static InitialScreen2 + #314, #32
  static InitialScreen2 + #315, #32
  static InitialScreen2 + #316, #32
  static InitialScreen2 + #317, #32
  static InitialScreen2 + #318, #32
  static InitialScreen2 + #319, #2825

  ;Linha 8
  static InitialScreen2 + #320, #2825
  static InitialScreen2 + #321, #32
  static InitialScreen2 + #322, #32
  static InitialScreen2 + #323, #32
  static InitialScreen2 + #324, #32
  static InitialScreen2 + #325, #32
  static InitialScreen2 + #326, #32
  static InitialScreen2 + #327, #32
  static InitialScreen2 + #328, #32
  static InitialScreen2 + #329, #32
  static InitialScreen2 + #330, #32
  static InitialScreen2 + #331, #32
  static InitialScreen2 + #332, #32
  static InitialScreen2 + #333, #32
  static InitialScreen2 + #334, #32
  static InitialScreen2 + #335, #2313
  static InitialScreen2 + #336, #2313
  static InitialScreen2 + #337, #2313
  static InitialScreen2 + #338, #2313
  static InitialScreen2 + #339, #2313
  static InitialScreen2 + #340, #2313
  static InitialScreen2 + #341, #2313
  static InitialScreen2 + #342, #2313
  static InitialScreen2 + #343, #2313
  static InitialScreen2 + #344, #32
  static InitialScreen2 + #345, #32
  static InitialScreen2 + #346, #32
  static InitialScreen2 + #347, #32
  static InitialScreen2 + #348, #32
  static InitialScreen2 + #349, #32
  static InitialScreen2 + #350, #32
  static InitialScreen2 + #351, #32
  static InitialScreen2 + #352, #32
  static InitialScreen2 + #353, #32
  static InitialScreen2 + #354, #32
  static InitialScreen2 + #355, #32
  static InitialScreen2 + #356, #32
  static InitialScreen2 + #357, #32
  static InitialScreen2 + #358, #32
  static InitialScreen2 + #359, #2825

  ;Linha 9
  static InitialScreen2 + #360, #2825
  static InitialScreen2 + #361, #32
  static InitialScreen2 + #362, #32
  static InitialScreen2 + #363, #32
  static InitialScreen2 + #364, #32
  static InitialScreen2 + #365, #32
  static InitialScreen2 + #366, #32
  static InitialScreen2 + #367, #32
  static InitialScreen2 + #368, #32
  static InitialScreen2 + #369, #32
  static InitialScreen2 + #370, #32
  static InitialScreen2 + #371, #32
  static InitialScreen2 + #372, #32
  static InitialScreen2 + #373, #32
  static InitialScreen2 + #374, #2313
  static InitialScreen2 + #375, #2313
  static InitialScreen2 + #376, #2313
  static InitialScreen2 + #377, #2313
  static InitialScreen2 + #378, #2313
  static InitialScreen2 + #379, #9
  static InitialScreen2 + #380, #2313
  static InitialScreen2 + #381, #2313
  static InitialScreen2 + #382, #2313
  static InitialScreen2 + #383, #2313
  static InitialScreen2 + #384, #2313
  static InitialScreen2 + #385, #32
  static InitialScreen2 + #386, #32
  static InitialScreen2 + #387, #32
  static InitialScreen2 + #388, #32
  static InitialScreen2 + #389, #32
  static InitialScreen2 + #390, #32
  static InitialScreen2 + #391, #32
  static InitialScreen2 + #392, #32
  static InitialScreen2 + #393, #32
  static InitialScreen2 + #394, #32
  static InitialScreen2 + #395, #32
  static InitialScreen2 + #396, #32
  static InitialScreen2 + #397, #32
  static InitialScreen2 + #398, #32
  static InitialScreen2 + #399, #2825

  ;Linha 10
  static InitialScreen2 + #400, #2825
  static InitialScreen2 + #401, #32
  static InitialScreen2 + #402, #32
  static InitialScreen2 + #403, #32
  static InitialScreen2 + #404, #32
  static InitialScreen2 + #405, #32
  static InitialScreen2 + #406, #32
  static InitialScreen2 + #407, #32
  static InitialScreen2 + #408, #32
  static InitialScreen2 + #409, #32
  static InitialScreen2 + #410, #32
  static InitialScreen2 + #411, #32
  static InitialScreen2 + #412, #32
  static InitialScreen2 + #413, #32
  static InitialScreen2 + #414, #2313
  static InitialScreen2 + #415, #2313
  static InitialScreen2 + #416, #2313
  static InitialScreen2 + #417, #2313
  static InitialScreen2 + #418, #9
  static InitialScreen2 + #419, #9
  static InitialScreen2 + #420, #9
  static InitialScreen2 + #421, #2313
  static InitialScreen2 + #422, #2313
  static InitialScreen2 + #423, #2313
  static InitialScreen2 + #424, #2313
  static InitialScreen2 + #425, #32
  static InitialScreen2 + #426, #32
  static InitialScreen2 + #427, #32
  static InitialScreen2 + #428, #32
  static InitialScreen2 + #429, #32
  static InitialScreen2 + #430, #32
  static InitialScreen2 + #431, #32
  static InitialScreen2 + #432, #32
  static InitialScreen2 + #433, #32
  static InitialScreen2 + #434, #32
  static InitialScreen2 + #435, #32
  static InitialScreen2 + #436, #32
  static InitialScreen2 + #437, #32
  static InitialScreen2 + #438, #32
  static InitialScreen2 + #439, #2825

  ;Linha 11
  static InitialScreen2 + #440, #2825
  static InitialScreen2 + #441, #32
  static InitialScreen2 + #442, #32
  static InitialScreen2 + #443, #32
  static InitialScreen2 + #444, #32
  static InitialScreen2 + #445, #32
  static InitialScreen2 + #446, #32
  static InitialScreen2 + #447, #32
  static InitialScreen2 + #448, #32
  static InitialScreen2 + #449, #32
  static InitialScreen2 + #450, #32
  static InitialScreen2 + #451, #32
  static InitialScreen2 + #452, #32
  static InitialScreen2 + #453, #32
  static InitialScreen2 + #454, #2313
  static InitialScreen2 + #455, #2313
  static InitialScreen2 + #456, #2313
  static InitialScreen2 + #457, #9
  static InitialScreen2 + #458, #9
  static InitialScreen2 + #459, #2313
  static InitialScreen2 + #460, #9
  static InitialScreen2 + #461, #9
  static InitialScreen2 + #462, #2313
  static InitialScreen2 + #463, #2313
  static InitialScreen2 + #464, #2313
  static InitialScreen2 + #465, #32
  static InitialScreen2 + #466, #32
  static InitialScreen2 + #467, #32
  static InitialScreen2 + #468, #32
  static InitialScreen2 + #469, #32
  static InitialScreen2 + #470, #32
  static InitialScreen2 + #471, #32
  static InitialScreen2 + #472, #32
  static InitialScreen2 + #473, #32
  static InitialScreen2 + #474, #32
  static InitialScreen2 + #475, #32
  static InitialScreen2 + #476, #32
  static InitialScreen2 + #477, #32
  static InitialScreen2 + #478, #32
  static InitialScreen2 + #479, #2825

  ;Linha 12
  static InitialScreen2 + #480, #2825
  static InitialScreen2 + #481, #32
  static InitialScreen2 + #482, #32
  static InitialScreen2 + #483, #32
  static InitialScreen2 + #484, #32
  static InitialScreen2 + #485, #32
  static InitialScreen2 + #486, #32
  static InitialScreen2 + #487, #32
  static InitialScreen2 + #488, #32
  static InitialScreen2 + #489, #32
  static InitialScreen2 + #490, #32
  static InitialScreen2 + #491, #32
  static InitialScreen2 + #492, #32
  static InitialScreen2 + #493, #2313
  static InitialScreen2 + #494, #2313
  static InitialScreen2 + #495, #2313
  static InitialScreen2 + #496, #9
  static InitialScreen2 + #497, #9
  static InitialScreen2 + #498, #9
  static InitialScreen2 + #499, #9
  static InitialScreen2 + #500, #9
  static InitialScreen2 + #501, #9
  static InitialScreen2 + #502, #9
  static InitialScreen2 + #503, #2313
  static InitialScreen2 + #504, #2313
  static InitialScreen2 + #505, #2313
  static InitialScreen2 + #506, #32
  static InitialScreen2 + #507, #32
  static InitialScreen2 + #508, #32
  static InitialScreen2 + #509, #32
  static InitialScreen2 + #510, #32
  static InitialScreen2 + #511, #32
  static InitialScreen2 + #512, #32
  static InitialScreen2 + #513, #32
  static InitialScreen2 + #514, #32
  static InitialScreen2 + #515, #32
  static InitialScreen2 + #516, #32
  static InitialScreen2 + #517, #32
  static InitialScreen2 + #518, #32
  static InitialScreen2 + #519, #2825

  ;Linha 13
  static InitialScreen2 + #520, #2825
  static InitialScreen2 + #521, #32
  static InitialScreen2 + #522, #32
  static InitialScreen2 + #523, #32
  static InitialScreen2 + #524, #32
  static InitialScreen2 + #525, #32
  static InitialScreen2 + #526, #32
  static InitialScreen2 + #527, #32
  static InitialScreen2 + #528, #32
  static InitialScreen2 + #529, #32
  static InitialScreen2 + #530, #32
  static InitialScreen2 + #531, #32
  static InitialScreen2 + #532, #32
  static InitialScreen2 + #533, #2313
  static InitialScreen2 + #534, #2313
  static InitialScreen2 + #535, #9
  static InitialScreen2 + #536, #9
  static InitialScreen2 + #537, #9
  static InitialScreen2 + #538, #9
  static InitialScreen2 + #539, #9
  static InitialScreen2 + #540, #9
  static InitialScreen2 + #541, #9
  static InitialScreen2 + #542, #9
  static InitialScreen2 + #543, #9
  static InitialScreen2 + #544, #2313
  static InitialScreen2 + #545, #2313
  static InitialScreen2 + #546, #32
  static InitialScreen2 + #547, #32
  static InitialScreen2 + #548, #32
  static InitialScreen2 + #549, #32
  static InitialScreen2 + #550, #32
  static InitialScreen2 + #551, #32
  static InitialScreen2 + #552, #32
  static InitialScreen2 + #553, #32
  static InitialScreen2 + #554, #32
  static InitialScreen2 + #555, #32
  static InitialScreen2 + #556, #32
  static InitialScreen2 + #557, #32
  static InitialScreen2 + #558, #32
  static InitialScreen2 + #559, #2825

  ;Linha 14
  static InitialScreen2 + #560, #2825
  static InitialScreen2 + #561, #32
  static InitialScreen2 + #562, #32
  static InitialScreen2 + #563, #32
  static InitialScreen2 + #564, #32
  static InitialScreen2 + #565, #32
  static InitialScreen2 + #566, #32
  static InitialScreen2 + #567, #32
  static InitialScreen2 + #568, #32
  static InitialScreen2 + #569, #32
  static InitialScreen2 + #570, #32
  static InitialScreen2 + #571, #32
  static InitialScreen2 + #572, #32
  static InitialScreen2 + #573, #2313
  static InitialScreen2 + #574, #9
  static InitialScreen2 + #575, #9
  static InitialScreen2 + #576, #2313
  static InitialScreen2 + #577, #9
  static InitialScreen2 + #578, #9
  static InitialScreen2 + #579, #2313
  static InitialScreen2 + #580, #9
  static InitialScreen2 + #581, #9
  static InitialScreen2 + #582, #2313
  static InitialScreen2 + #583, #9
  static InitialScreen2 + #584, #9
  static InitialScreen2 + #585, #2313
  static InitialScreen2 + #586, #32
  static InitialScreen2 + #587, #32
  static InitialScreen2 + #588, #32
  static InitialScreen2 + #589, #32
  static InitialScreen2 + #590, #32
  static InitialScreen2 + #591, #32
  static InitialScreen2 + #592, #32
  static InitialScreen2 + #593, #32
  static InitialScreen2 + #594, #32
  static InitialScreen2 + #595, #32
  static InitialScreen2 + #596, #32
  static InitialScreen2 + #597, #32
  static InitialScreen2 + #598, #32
  static InitialScreen2 + #599, #2825

  ;Linha 15
  static InitialScreen2 + #600, #2825
  static InitialScreen2 + #601, #32
  static InitialScreen2 + #602, #32
  static InitialScreen2 + #603, #32
  static InitialScreen2 + #604, #32
  static InitialScreen2 + #605, #32
  static InitialScreen2 + #606, #32
  static InitialScreen2 + #607, #32
  static InitialScreen2 + #608, #32
  static InitialScreen2 + #609, #32
  static InitialScreen2 + #610, #32
  static InitialScreen2 + #611, #32
  static InitialScreen2 + #612, #32
  static InitialScreen2 + #613, #2313
  static InitialScreen2 + #614, #2313
  static InitialScreen2 + #615, #9
  static InitialScreen2 + #616, #9
  static InitialScreen2 + #617, #9
  static InitialScreen2 + #618, #9
  static InitialScreen2 + #619, #9
  static InitialScreen2 + #620, #9
  static InitialScreen2 + #621, #9
  static InitialScreen2 + #622, #9
  static InitialScreen2 + #623, #9
  static InitialScreen2 + #624, #2313
  static InitialScreen2 + #625, #2313
  static InitialScreen2 + #626, #32
  static InitialScreen2 + #627, #32
  static InitialScreen2 + #628, #32
  static InitialScreen2 + #629, #32
  static InitialScreen2 + #630, #32
  static InitialScreen2 + #631, #32
  static InitialScreen2 + #632, #32
  static InitialScreen2 + #633, #32
  static InitialScreen2 + #634, #32
  static InitialScreen2 + #635, #32
  static InitialScreen2 + #636, #32
  static InitialScreen2 + #637, #32
  static InitialScreen2 + #638, #32
  static InitialScreen2 + #639, #2825

  ;Linha 16
  static InitialScreen2 + #640, #2825
  static InitialScreen2 + #641, #32
  static InitialScreen2 + #642, #32
  static InitialScreen2 + #643, #32
  static InitialScreen2 + #644, #32
  static InitialScreen2 + #645, #32
  static InitialScreen2 + #646, #32
  static InitialScreen2 + #647, #32
  static InitialScreen2 + #648, #32
  static InitialScreen2 + #649, #32
  static InitialScreen2 + #650, #32
  static InitialScreen2 + #651, #32
  static InitialScreen2 + #652, #32
  static InitialScreen2 + #653, #32
  static InitialScreen2 + #654, #2313
  static InitialScreen2 + #655, #2313
  static InitialScreen2 + #656, #9
  static InitialScreen2 + #657, #9
  static InitialScreen2 + #658, #9
  static InitialScreen2 + #659, #9
  static InitialScreen2 + #660, #9
  static InitialScreen2 + #661, #9
  static InitialScreen2 + #662, #9
  static InitialScreen2 + #663, #2313
  static InitialScreen2 + #664, #2313
  static InitialScreen2 + #665, #32
  static InitialScreen2 + #666, #32
  static InitialScreen2 + #667, #32
  static InitialScreen2 + #668, #32
  static InitialScreen2 + #669, #32
  static InitialScreen2 + #670, #32
  static InitialScreen2 + #671, #32
  static InitialScreen2 + #672, #32
  static InitialScreen2 + #673, #32
  static InitialScreen2 + #674, #32
  static InitialScreen2 + #675, #32
  static InitialScreen2 + #676, #32
  static InitialScreen2 + #677, #32
  static InitialScreen2 + #678, #32
  static InitialScreen2 + #679, #2825

  ;Linha 17
  static InitialScreen2 + #680, #2825
  static InitialScreen2 + #681, #32
  static InitialScreen2 + #682, #32
  static InitialScreen2 + #683, #32
  static InitialScreen2 + #684, #32
  static InitialScreen2 + #685, #32
  static InitialScreen2 + #686, #32
  static InitialScreen2 + #687, #32
  static InitialScreen2 + #688, #32
  static InitialScreen2 + #689, #32
  static InitialScreen2 + #690, #32
  static InitialScreen2 + #691, #32
  static InitialScreen2 + #692, #32
  static InitialScreen2 + #693, #32
  static InitialScreen2 + #694, #32
  static InitialScreen2 + #695, #2313
  static InitialScreen2 + #696, #2313
  static InitialScreen2 + #697, #9
  static InitialScreen2 + #698, #9
  static InitialScreen2 + #699, #2313
  static InitialScreen2 + #700, #9
  static InitialScreen2 + #701, #9
  static InitialScreen2 + #702, #2313
  static InitialScreen2 + #703, #2313
  static InitialScreen2 + #704, #32
  static InitialScreen2 + #705, #32
  static InitialScreen2 + #706, #32
  static InitialScreen2 + #707, #32
  static InitialScreen2 + #708, #32
  static InitialScreen2 + #709, #32
  static InitialScreen2 + #710, #32
  static InitialScreen2 + #711, #32
  static InitialScreen2 + #712, #32
  static InitialScreen2 + #713, #32
  static InitialScreen2 + #714, #32
  static InitialScreen2 + #715, #32
  static InitialScreen2 + #716, #32
  static InitialScreen2 + #717, #32
  static InitialScreen2 + #718, #32
  static InitialScreen2 + #719, #2825

  ;Linha 18
  static InitialScreen2 + #720, #2825
  static InitialScreen2 + #721, #32
  static InitialScreen2 + #722, #32
  static InitialScreen2 + #723, #32
  static InitialScreen2 + #724, #32
  static InitialScreen2 + #725, #32
  static InitialScreen2 + #726, #32
  static InitialScreen2 + #727, #32
  static InitialScreen2 + #728, #32
  static InitialScreen2 + #729, #32
  static InitialScreen2 + #730, #32
  static InitialScreen2 + #731, #32
  static InitialScreen2 + #732, #32
  static InitialScreen2 + #733, #32
  static InitialScreen2 + #734, #32
  static InitialScreen2 + #735, #32
  static InitialScreen2 + #736, #2313
  static InitialScreen2 + #737, #2313
  static InitialScreen2 + #738, #9
  static InitialScreen2 + #739, #9
  static InitialScreen2 + #740, #9
  static InitialScreen2 + #741, #2313
  static InitialScreen2 + #742, #2313
  static InitialScreen2 + #743, #32
  static InitialScreen2 + #744, #32
  static InitialScreen2 + #745, #32
  static InitialScreen2 + #746, #32
  static InitialScreen2 + #747, #32
  static InitialScreen2 + #748, #32
  static InitialScreen2 + #749, #32
  static InitialScreen2 + #750, #32
  static InitialScreen2 + #751, #32
  static InitialScreen2 + #752, #32
  static InitialScreen2 + #753, #32
  static InitialScreen2 + #754, #32
  static InitialScreen2 + #755, #32
  static InitialScreen2 + #756, #32
  static InitialScreen2 + #757, #32
  static InitialScreen2 + #758, #32
  static InitialScreen2 + #759, #2825

  ;Linha 19
  static InitialScreen2 + #760, #2825
  static InitialScreen2 + #761, #32
  static InitialScreen2 + #762, #32
  static InitialScreen2 + #763, #32
  static InitialScreen2 + #764, #32
  static InitialScreen2 + #765, #32
  static InitialScreen2 + #766, #32
  static InitialScreen2 + #767, #32
  static InitialScreen2 + #768, #32
  static InitialScreen2 + #769, #32
  static InitialScreen2 + #770, #32
  static InitialScreen2 + #771, #32
  static InitialScreen2 + #772, #32
  static InitialScreen2 + #773, #32
  static InitialScreen2 + #774, #32
  static InitialScreen2 + #775, #32
  static InitialScreen2 + #776, #32
  static InitialScreen2 + #777, #2313
  static InitialScreen2 + #778, #2313
  static InitialScreen2 + #779, #9
  static InitialScreen2 + #780, #2313
  static InitialScreen2 + #781, #2313
  static InitialScreen2 + #782, #32
  static InitialScreen2 + #783, #32
  static InitialScreen2 + #784, #32
  static InitialScreen2 + #785, #32
  static InitialScreen2 + #786, #32
  static InitialScreen2 + #787, #32
  static InitialScreen2 + #788, #32
  static InitialScreen2 + #789, #32
  static InitialScreen2 + #790, #32
  static InitialScreen2 + #791, #32
  static InitialScreen2 + #792, #32
  static InitialScreen2 + #793, #32
  static InitialScreen2 + #794, #32
  static InitialScreen2 + #795, #32
  static InitialScreen2 + #796, #32
  static InitialScreen2 + #797, #32
  static InitialScreen2 + #798, #32
  static InitialScreen2 + #799, #2825

  ;Linha 20
  static InitialScreen2 + #800, #2825
  static InitialScreen2 + #801, #32
  static InitialScreen2 + #802, #32
  static InitialScreen2 + #803, #32
  static InitialScreen2 + #804, #32
  static InitialScreen2 + #805, #32
  static InitialScreen2 + #806, #32
  static InitialScreen2 + #807, #32
  static InitialScreen2 + #808, #32
  static InitialScreen2 + #809, #32
  static InitialScreen2 + #810, #32
  static InitialScreen2 + #811, #32
  static InitialScreen2 + #812, #32
  static InitialScreen2 + #813, #32
  static InitialScreen2 + #814, #32
  static InitialScreen2 + #815, #32
  static InitialScreen2 + #816, #32
  static InitialScreen2 + #817, #32
  static InitialScreen2 + #818, #2313
  static InitialScreen2 + #819, #2313
  static InitialScreen2 + #820, #2313
  static InitialScreen2 + #821, #32
  static InitialScreen2 + #822, #32
  static InitialScreen2 + #823, #32
  static InitialScreen2 + #824, #32
  static InitialScreen2 + #825, #32
  static InitialScreen2 + #826, #32
  static InitialScreen2 + #827, #32
  static InitialScreen2 + #828, #32
  static InitialScreen2 + #829, #32
  static InitialScreen2 + #830, #32
  static InitialScreen2 + #831, #32
  static InitialScreen2 + #832, #32
  static InitialScreen2 + #833, #32
  static InitialScreen2 + #834, #32
  static InitialScreen2 + #835, #32
  static InitialScreen2 + #836, #32
  static InitialScreen2 + #837, #32
  static InitialScreen2 + #838, #32
  static InitialScreen2 + #839, #2825

  ;Linha 21
  static InitialScreen2 + #840, #2825
  static InitialScreen2 + #841, #32
  static InitialScreen2 + #842, #32
  static InitialScreen2 + #843, #32
  static InitialScreen2 + #844, #32
  static InitialScreen2 + #845, #32
  static InitialScreen2 + #846, #32
  static InitialScreen2 + #847, #32
  static InitialScreen2 + #848, #32
  static InitialScreen2 + #849, #32
  static InitialScreen2 + #850, #32
  static InitialScreen2 + #851, #32
  static InitialScreen2 + #852, #32
  static InitialScreen2 + #853, #32
  static InitialScreen2 + #854, #32
  static InitialScreen2 + #855, #32
  static InitialScreen2 + #856, #32
  static InitialScreen2 + #857, #32
  static InitialScreen2 + #858, #32
  static InitialScreen2 + #859, #2313
  static InitialScreen2 + #860, #32
  static InitialScreen2 + #861, #32
  static InitialScreen2 + #862, #32
  static InitialScreen2 + #863, #32
  static InitialScreen2 + #864, #32
  static InitialScreen2 + #865, #32
  static InitialScreen2 + #866, #32
  static InitialScreen2 + #867, #32
  static InitialScreen2 + #868, #32
  static InitialScreen2 + #869, #32
  static InitialScreen2 + #870, #32
  static InitialScreen2 + #871, #32
  static InitialScreen2 + #872, #32
  static InitialScreen2 + #873, #32
  static InitialScreen2 + #874, #32
  static InitialScreen2 + #875, #32
  static InitialScreen2 + #876, #32
  static InitialScreen2 + #877, #32
  static InitialScreen2 + #878, #32
  static InitialScreen2 + #879, #2825

  ;Linha 22
  static InitialScreen2 + #880, #2825
  static InitialScreen2 + #881, #32
  static InitialScreen2 + #882, #32
  static InitialScreen2 + #883, #32
  static InitialScreen2 + #884, #32
  static InitialScreen2 + #885, #32
  static InitialScreen2 + #886, #32
  static InitialScreen2 + #887, #32
  static InitialScreen2 + #888, #32
  static InitialScreen2 + #889, #32
  static InitialScreen2 + #890, #32
  static InitialScreen2 + #891, #32
  static InitialScreen2 + #892, #32
  static InitialScreen2 + #893, #32
  static InitialScreen2 + #894, #32
  static InitialScreen2 + #895, #32
  static InitialScreen2 + #896, #32
  static InitialScreen2 + #897, #32
  static InitialScreen2 + #898, #32
  static InitialScreen2 + #899, #32
  static InitialScreen2 + #900, #32
  static InitialScreen2 + #901, #32
  static InitialScreen2 + #902, #32
  static InitialScreen2 + #903, #32
  static InitialScreen2 + #904, #32
  static InitialScreen2 + #905, #32
  static InitialScreen2 + #906, #32
  static InitialScreen2 + #907, #32
  static InitialScreen2 + #908, #32
  static InitialScreen2 + #909, #32
  static InitialScreen2 + #910, #32
  static InitialScreen2 + #911, #32
  static InitialScreen2 + #912, #32
  static InitialScreen2 + #913, #32
  static InitialScreen2 + #914, #32
  static InitialScreen2 + #915, #32
  static InitialScreen2 + #916, #32
  static InitialScreen2 + #917, #32
  static InitialScreen2 + #918, #32
  static InitialScreen2 + #919, #2825

  ;Linha 23
  static InitialScreen2 + #920, #2825
  static InitialScreen2 + #921, #32
  static InitialScreen2 + #922, #32
  static InitialScreen2 + #923, #32
  static InitialScreen2 + #924, #32
  static InitialScreen2 + #925, #32
  static InitialScreen2 + #926, #32
  static InitialScreen2 + #927, #32
  static InitialScreen2 + #928, #32
  static InitialScreen2 + #929, #32
  static InitialScreen2 + #930, #32
  static InitialScreen2 + #931, #32
  static InitialScreen2 + #932, #32
  static InitialScreen2 + #933, #32
  static InitialScreen2 + #934, #32
  static InitialScreen2 + #935, #32
  static InitialScreen2 + #936, #32
  static InitialScreen2 + #937, #32
  static InitialScreen2 + #938, #32
  static InitialScreen2 + #939, #32
  static InitialScreen2 + #940, #32
  static InitialScreen2 + #941, #32
  static InitialScreen2 + #942, #32
  static InitialScreen2 + #943, #32
  static InitialScreen2 + #944, #32
  static InitialScreen2 + #945, #32
  static InitialScreen2 + #946, #32
  static InitialScreen2 + #947, #32
  static InitialScreen2 + #948, #32
  static InitialScreen2 + #949, #32
  static InitialScreen2 + #950, #32
  static InitialScreen2 + #951, #32
  static InitialScreen2 + #952, #32
  static InitialScreen2 + #953, #32
  static InitialScreen2 + #954, #32
  static InitialScreen2 + #955, #32
  static InitialScreen2 + #956, #32
  static InitialScreen2 + #957, #32
  static InitialScreen2 + #958, #32
  static InitialScreen2 + #959, #2825

  ;Linha 24
  static InitialScreen2 + #960, #2825
  static InitialScreen2 + #961, #32
  static InitialScreen2 + #962, #32
  static InitialScreen2 + #963, #32
  static InitialScreen2 + #964, #32
  static InitialScreen2 + #965, #32
  static InitialScreen2 + #966, #32
  static InitialScreen2 + #967, #32
  static InitialScreen2 + #968, #32
  static InitialScreen2 + #969, #32
  static InitialScreen2 + #970, #32
  static InitialScreen2 + #971, #32
  static InitialScreen2 + #972, #32
  static InitialScreen2 + #973, #32
  static InitialScreen2 + #974, #32
  static InitialScreen2 + #975, #32
  static InitialScreen2 + #976, #2882
  static InitialScreen2 + #977, #2885
  static InitialScreen2 + #978, #2900
  static InitialScreen2 + #979, #32
  static InitialScreen2 + #980, #2901
  static InitialScreen2 + #981, #2899
  static InitialScreen2 + #982, #2896
  static InitialScreen2 + #983, #32
  static InitialScreen2 + #984, #32
  static InitialScreen2 + #985, #32
  static InitialScreen2 + #986, #32
  static InitialScreen2 + #987, #32
  static InitialScreen2 + #988, #32
  static InitialScreen2 + #989, #32
  static InitialScreen2 + #990, #32
  static InitialScreen2 + #991, #32
  static InitialScreen2 + #992, #32
  static InitialScreen2 + #993, #32
  static InitialScreen2 + #994, #32
  static InitialScreen2 + #995, #32
  static InitialScreen2 + #996, #32
  static InitialScreen2 + #997, #32
  static InitialScreen2 + #998, #32
  static InitialScreen2 + #999, #2825

  ;Linha 25
  static InitialScreen2 + #1000, #2825
  static InitialScreen2 + #1001, #32
  static InitialScreen2 + #1002, #32
  static InitialScreen2 + #1003, #32
  static InitialScreen2 + #1004, #32
  static InitialScreen2 + #1005, #32
  static InitialScreen2 + #1006, #32
  static InitialScreen2 + #1007, #32
  static InitialScreen2 + #1008, #32
  static InitialScreen2 + #1009, #32
  static InitialScreen2 + #1010, #32
  static InitialScreen2 + #1011, #32
  static InitialScreen2 + #1012, #32
  static InitialScreen2 + #1013, #32
  static InitialScreen2 + #1014, #32
  static InitialScreen2 + #1015, #32
  static InitialScreen2 + #1016, #32
  static InitialScreen2 + #1017, #32
  static InitialScreen2 + #1018, #32
  static InitialScreen2 + #1019, #32
  static InitialScreen2 + #1020, #32
  static InitialScreen2 + #1021, #32
  static InitialScreen2 + #1022, #32
  static InitialScreen2 + #1023, #32
  static InitialScreen2 + #1024, #32
  static InitialScreen2 + #1025, #32
  static InitialScreen2 + #1026, #32
  static InitialScreen2 + #1027, #32
  static InitialScreen2 + #1028, #32
  static InitialScreen2 + #1029, #32
  static InitialScreen2 + #1030, #32
  static InitialScreen2 + #1031, #32
  static InitialScreen2 + #1032, #32
  static InitialScreen2 + #1033, #32
  static InitialScreen2 + #1034, #32
  static InitialScreen2 + #1035, #32
  static InitialScreen2 + #1036, #32
  static InitialScreen2 + #1037, #32
  static InitialScreen2 + #1038, #32
  static InitialScreen2 + #1039, #2825

  ;Linha 26
  static InitialScreen2 + #1040, #2825
  static InitialScreen2 + #1041, #32
  static InitialScreen2 + #1042, #32
  static InitialScreen2 + #1043, #32
  static InitialScreen2 + #1044, #32
  static InitialScreen2 + #1045, #32
  static InitialScreen2 + #1046, #32
  static InitialScreen2 + #1047, #32
  static InitialScreen2 + #1048, #32
  static InitialScreen2 + #1049, #32
  static InitialScreen2 + #1050, #32
  static InitialScreen2 + #1051, #32
  static InitialScreen2 + #1052, #32
  static InitialScreen2 + #1053, #2907
  static InitialScreen2 + #1054, #32
  static InitialScreen2 + #1055, #2879
  static InitialScreen2 + #1056, #32
  static InitialScreen2 + #1057, #2900
  static InitialScreen2 + #1058, #2933
  static InitialScreen2 + #1059, #2932
  static InitialScreen2 + #1060, #2927
  static InitialScreen2 + #1061, #2930
  static InitialScreen2 + #1062, #2921
  static InitialScreen2 + #1063, #2913
  static InitialScreen2 + #1064, #2924
  static InitialScreen2 + #1065, #2909
  static InitialScreen2 + #1066, #32
  static InitialScreen2 + #1067, #32
  static InitialScreen2 + #1068, #32
  static InitialScreen2 + #1069, #32
  static InitialScreen2 + #1070, #32
  static InitialScreen2 + #1071, #32
  static InitialScreen2 + #1072, #32
  static InitialScreen2 + #1073, #32
  static InitialScreen2 + #1074, #32
  static InitialScreen2 + #1075, #32
  static InitialScreen2 + #1076, #32
  static InitialScreen2 + #1077, #32
  static InitialScreen2 + #1078, #32
  static InitialScreen2 + #1079, #2825

  ;Linha 27
  static InitialScreen2 + #1080, #2825
  static InitialScreen2 + #1081, #32
  static InitialScreen2 + #1082, #32
  static InitialScreen2 + #1083, #32
  static InitialScreen2 + #1084, #32
  static InitialScreen2 + #1085, #32
  static InitialScreen2 + #1086, #32
  static InitialScreen2 + #1087, #32
  static InitialScreen2 + #1088, #32
  static InitialScreen2 + #1089, #32
  static InitialScreen2 + #1090, #32
  static InitialScreen2 + #1091, #32
  static InitialScreen2 + #1092, #32
  static InitialScreen2 + #1093, #2907
  static InitialScreen2 + #1094, #2885
  static InitialScreen2 + #1095, #2926
  static InitialScreen2 + #1096, #2932
  static InitialScreen2 + #1097, #2917
  static InitialScreen2 + #1098, #2930
  static InitialScreen2 + #1099, #32
  static InitialScreen2 + #1100, #2890
  static InitialScreen2 + #1101, #2927
  static InitialScreen2 + #1102, #2919
  static InitialScreen2 + #1103, #2913
  static InitialScreen2 + #1104, #2930
  static InitialScreen2 + #1105, #2909
  static InitialScreen2 + #1106, #32
  static InitialScreen2 + #1107, #32
  static InitialScreen2 + #1108, #32
  static InitialScreen2 + #1109, #32
  static InitialScreen2 + #1110, #32
  static InitialScreen2 + #1111, #32
  static InitialScreen2 + #1112, #32
  static InitialScreen2 + #1113, #32
  static InitialScreen2 + #1114, #32
  static InitialScreen2 + #1115, #32
  static InitialScreen2 + #1116, #32
  static InitialScreen2 + #1117, #32
  static InitialScreen2 + #1118, #32
  static InitialScreen2 + #1119, #2825

  ;Linha 28
  static InitialScreen2 + #1120, #2825
  static InitialScreen2 + #1121, #32
  static InitialScreen2 + #1122, #32
  static InitialScreen2 + #1123, #32
  static InitialScreen2 + #1124, #32
  static InitialScreen2 + #1125, #32
  static InitialScreen2 + #1126, #32
  static InitialScreen2 + #1127, #32
  static InitialScreen2 + #1128, #32
  static InitialScreen2 + #1129, #32
  static InitialScreen2 + #1130, #32
  static InitialScreen2 + #1131, #32
  static InitialScreen2 + #1132, #32
  static InitialScreen2 + #1133, #32
  static InitialScreen2 + #1134, #32
  static InitialScreen2 + #1135, #32
  static InitialScreen2 + #1136, #32
  static InitialScreen2 + #1137, #32
  static InitialScreen2 + #1138, #32
  static InitialScreen2 + #1139, #32
  static InitialScreen2 + #1140, #32
  static InitialScreen2 + #1141, #32
  static InitialScreen2 + #1142, #32
  static InitialScreen2 + #1143, #32
  static InitialScreen2 + #1144, #32
  static InitialScreen2 + #1145, #32
  static InitialScreen2 + #1146, #32
  static InitialScreen2 + #1147, #32
  static InitialScreen2 + #1148, #32
  static InitialScreen2 + #1149, #32
  static InitialScreen2 + #1150, #32
  static InitialScreen2 + #1151, #32
  static InitialScreen2 + #1152, #32
  static InitialScreen2 + #1153, #32
  static InitialScreen2 + #1154, #32
  static InitialScreen2 + #1155, #32
  static InitialScreen2 + #1156, #32
  static InitialScreen2 + #1157, #32
  static InitialScreen2 + #1158, #32
  static InitialScreen2 + #1159, #2825

  ;Linha 29
  static InitialScreen2 + #1160, #2825
  static InitialScreen2 + #1161, #2825
  static InitialScreen2 + #1162, #2825
  static InitialScreen2 + #1163, #2825
  static InitialScreen2 + #1164, #2825
  static InitialScreen2 + #1165, #2825
  static InitialScreen2 + #1166, #2825
  static InitialScreen2 + #1167, #2825
  static InitialScreen2 + #1168, #2825
  static InitialScreen2 + #1169, #2825
  static InitialScreen2 + #1170, #2825
  static InitialScreen2 + #1171, #2825
  static InitialScreen2 + #1172, #2825
  static InitialScreen2 + #1173, #2825
  static InitialScreen2 + #1174, #2825
  static InitialScreen2 + #1175, #2825
  static InitialScreen2 + #1176, #2825
  static InitialScreen2 + #1177, #2825
  static InitialScreen2 + #1178, #2825
  static InitialScreen2 + #1179, #2825
  static InitialScreen2 + #1180, #2825
  static InitialScreen2 + #1181, #2825
  static InitialScreen2 + #1182, #2825
  static InitialScreen2 + #1183, #2825
  static InitialScreen2 + #1184, #2825
  static InitialScreen2 + #1185, #2825
  static InitialScreen2 + #1186, #2825
  static InitialScreen2 + #1187, #2825
  static InitialScreen2 + #1188, #2825
  static InitialScreen2 + #1189, #2825
  static InitialScreen2 + #1190, #2825
  static InitialScreen2 + #1191, #2825
  static InitialScreen2 + #1192, #2825
  static InitialScreen2 + #1193, #2825
  static InitialScreen2 + #1194, #2825
  static InitialScreen2 + #1195, #2825
  static InitialScreen2 + #1196, #2825
  static InitialScreen2 + #1197, #2825
  static InitialScreen2 + #1198, #2825
  static InitialScreen2 + #1199, #2825
;

InitialScreen3 : var #1200
  ;Linha 0
  static InitialScreen3 + #0, #2825
  static InitialScreen3 + #1, #2825
  static InitialScreen3 + #2, #2825
  static InitialScreen3 + #3, #2825
  static InitialScreen3 + #4, #2825
  static InitialScreen3 + #5, #2825
  static InitialScreen3 + #6, #2825
  static InitialScreen3 + #7, #2825
  static InitialScreen3 + #8, #2825
  static InitialScreen3 + #9, #2825
  static InitialScreen3 + #10, #2825
  static InitialScreen3 + #11, #2825
  static InitialScreen3 + #12, #2825
  static InitialScreen3 + #13, #2825
  static InitialScreen3 + #14, #2825
  static InitialScreen3 + #15, #2825
  static InitialScreen3 + #16, #2825
  static InitialScreen3 + #17, #2825
  static InitialScreen3 + #18, #2825
  static InitialScreen3 + #19, #2825
  static InitialScreen3 + #20, #2825
  static InitialScreen3 + #21, #2825
  static InitialScreen3 + #22, #2825
  static InitialScreen3 + #23, #2825
  static InitialScreen3 + #24, #2825
  static InitialScreen3 + #25, #2825
  static InitialScreen3 + #26, #2825
  static InitialScreen3 + #27, #2825
  static InitialScreen3 + #28, #2825
  static InitialScreen3 + #29, #2825
  static InitialScreen3 + #30, #2825
  static InitialScreen3 + #31, #2825
  static InitialScreen3 + #32, #2825
  static InitialScreen3 + #33, #2825
  static InitialScreen3 + #34, #2825
  static InitialScreen3 + #35, #2825
  static InitialScreen3 + #36, #2825
  static InitialScreen3 + #37, #2825
  static InitialScreen3 + #38, #2825
  static InitialScreen3 + #39, #2825

  ;Linha 1
  static InitialScreen3 + #40, #2825
  static InitialScreen3 + #41, #32
  static InitialScreen3 + #42, #32
  static InitialScreen3 + #43, #32
  static InitialScreen3 + #44, #32
  static InitialScreen3 + #45, #32
  static InitialScreen3 + #46, #32
  static InitialScreen3 + #47, #32
  static InitialScreen3 + #48, #32
  static InitialScreen3 + #49, #32
  static InitialScreen3 + #50, #32
  static InitialScreen3 + #51, #32
  static InitialScreen3 + #52, #32
  static InitialScreen3 + #53, #32
  static InitialScreen3 + #54, #32
  static InitialScreen3 + #55, #32
  static InitialScreen3 + #56, #32
  static InitialScreen3 + #57, #32
  static InitialScreen3 + #58, #32
  static InitialScreen3 + #59, #32
  static InitialScreen3 + #60, #32
  static InitialScreen3 + #61, #32
  static InitialScreen3 + #62, #32
  static InitialScreen3 + #63, #32
  static InitialScreen3 + #64, #32
  static InitialScreen3 + #65, #32
  static InitialScreen3 + #66, #32
  static InitialScreen3 + #67, #32
  static InitialScreen3 + #68, #32
  static InitialScreen3 + #69, #32
  static InitialScreen3 + #70, #32
  static InitialScreen3 + #71, #32
  static InitialScreen3 + #72, #32
  static InitialScreen3 + #73, #32
  static InitialScreen3 + #74, #32
  static InitialScreen3 + #75, #32
  static InitialScreen3 + #76, #32
  static InitialScreen3 + #77, #32
  static InitialScreen3 + #78, #32
  static InitialScreen3 + #79, #2825

  ;Linha 2
  static InitialScreen3 + #80, #2825
  static InitialScreen3 + #81, #32
  static InitialScreen3 + #82, #32
  static InitialScreen3 + #83, #32
  static InitialScreen3 + #84, #32
  static InitialScreen3 + #85, #32
  static InitialScreen3 + #86, #32
  static InitialScreen3 + #87, #32
  static InitialScreen3 + #88, #32
  static InitialScreen3 + #89, #32
  static InitialScreen3 + #90, #32
  static InitialScreen3 + #91, #32
  static InitialScreen3 + #92, #32
  static InitialScreen3 + #93, #32
  static InitialScreen3 + #94, #32
  static InitialScreen3 + #95, #32
  static InitialScreen3 + #96, #32
  static InitialScreen3 + #97, #32
  static InitialScreen3 + #98, #32
  static InitialScreen3 + #99, #32
  static InitialScreen3 + #100, #32
  static InitialScreen3 + #101, #32
  static InitialScreen3 + #102, #2313
  static InitialScreen3 + #103, #2313
  static InitialScreen3 + #104, #32
  static InitialScreen3 + #105, #32
  static InitialScreen3 + #106, #32
  static InitialScreen3 + #107, #32
  static InitialScreen3 + #108, #32
  static InitialScreen3 + #109, #32
  static InitialScreen3 + #110, #32
  static InitialScreen3 + #111, #32
  static InitialScreen3 + #112, #32
  static InitialScreen3 + #113, #32
  static InitialScreen3 + #114, #32
  static InitialScreen3 + #115, #32
  static InitialScreen3 + #116, #32
  static InitialScreen3 + #117, #32
  static InitialScreen3 + #118, #32
  static InitialScreen3 + #119, #2825

  ;Linha 3
  static InitialScreen3 + #120, #2825
  static InitialScreen3 + #121, #32
  static InitialScreen3 + #122, #32
  static InitialScreen3 + #123, #32
  static InitialScreen3 + #124, #32
  static InitialScreen3 + #125, #32
  static InitialScreen3 + #126, #32
  static InitialScreen3 + #127, #32
  static InitialScreen3 + #128, #32
  static InitialScreen3 + #129, #32
  static InitialScreen3 + #130, #32
  static InitialScreen3 + #131, #32
  static InitialScreen3 + #132, #32
  static InitialScreen3 + #133, #32
  static InitialScreen3 + #134, #32
  static InitialScreen3 + #135, #32
  static InitialScreen3 + #136, #32
  static InitialScreen3 + #137, #32
  static InitialScreen3 + #138, #32
  static InitialScreen3 + #139, #32
  static InitialScreen3 + #140, #32
  static InitialScreen3 + #141, #2313
  static InitialScreen3 + #142, #2313
  static InitialScreen3 + #143, #32
  static InitialScreen3 + #144, #32
  static InitialScreen3 + #145, #32
  static InitialScreen3 + #146, #32
  static InitialScreen3 + #147, #32
  static InitialScreen3 + #148, #32
  static InitialScreen3 + #149, #32
  static InitialScreen3 + #150, #32
  static InitialScreen3 + #151, #32
  static InitialScreen3 + #152, #32
  static InitialScreen3 + #153, #32
  static InitialScreen3 + #154, #32
  static InitialScreen3 + #155, #32
  static InitialScreen3 + #156, #32
  static InitialScreen3 + #157, #32
  static InitialScreen3 + #158, #32
  static InitialScreen3 + #159, #2825

  ;Linha 4
  static InitialScreen3 + #160, #2825
  static InitialScreen3 + #161, #32
  static InitialScreen3 + #162, #32
  static InitialScreen3 + #163, #32
  static InitialScreen3 + #164, #32
  static InitialScreen3 + #165, #32
  static InitialScreen3 + #166, #32
  static InitialScreen3 + #167, #32
  static InitialScreen3 + #168, #32
  static InitialScreen3 + #169, #32
  static InitialScreen3 + #170, #32
  static InitialScreen3 + #171, #32
  static InitialScreen3 + #172, #32
  static InitialScreen3 + #173, #32
  static InitialScreen3 + #174, #32
  static InitialScreen3 + #175, #32
  static InitialScreen3 + #176, #32
  static InitialScreen3 + #177, #32
  static InitialScreen3 + #178, #32
  static InitialScreen3 + #179, #32
  static InitialScreen3 + #180, #2313
  static InitialScreen3 + #181, #2313
  static InitialScreen3 + #182, #32
  static InitialScreen3 + #183, #32
  static InitialScreen3 + #184, #32
  static InitialScreen3 + #185, #32
  static InitialScreen3 + #186, #32
  static InitialScreen3 + #187, #32
  static InitialScreen3 + #188, #32
  static InitialScreen3 + #189, #32
  static InitialScreen3 + #190, #32
  static InitialScreen3 + #191, #32
  static InitialScreen3 + #192, #32
  static InitialScreen3 + #193, #32
  static InitialScreen3 + #194, #32
  static InitialScreen3 + #195, #32
  static InitialScreen3 + #196, #32
  static InitialScreen3 + #197, #32
  static InitialScreen3 + #198, #32
  static InitialScreen3 + #199, #2825

  ;Linha 5
  static InitialScreen3 + #200, #2825
  static InitialScreen3 + #201, #32
  static InitialScreen3 + #202, #32
  static InitialScreen3 + #203, #32
  static InitialScreen3 + #204, #32
  static InitialScreen3 + #205, #32
  static InitialScreen3 + #206, #32
  static InitialScreen3 + #207, #32
  static InitialScreen3 + #208, #32
  static InitialScreen3 + #209, #32
  static InitialScreen3 + #210, #32
  static InitialScreen3 + #211, #32
  static InitialScreen3 + #212, #32
  static InitialScreen3 + #213, #32
  static InitialScreen3 + #214, #32
  static InitialScreen3 + #215, #32
  static InitialScreen3 + #216, #32
  static InitialScreen3 + #217, #32
  static InitialScreen3 + #218, #2313
  static InitialScreen3 + #219, #32
  static InitialScreen3 + #220, #2313
  static InitialScreen3 + #221, #2313
  static InitialScreen3 + #222, #32
  static InitialScreen3 + #223, #32
  static InitialScreen3 + #224, #32
  static InitialScreen3 + #225, #2313
  static InitialScreen3 + #226, #32
  static InitialScreen3 + #227, #32
  static InitialScreen3 + #228, #32
  static InitialScreen3 + #229, #32
  static InitialScreen3 + #230, #32
  static InitialScreen3 + #231, #32
  static InitialScreen3 + #232, #32
  static InitialScreen3 + #233, #32
  static InitialScreen3 + #234, #32
  static InitialScreen3 + #235, #32
  static InitialScreen3 + #236, #32
  static InitialScreen3 + #237, #32
  static InitialScreen3 + #238, #32
  static InitialScreen3 + #239, #2825

  ;Linha 6
  static InitialScreen3 + #240, #2825
  static InitialScreen3 + #241, #32
  static InitialScreen3 + #242, #32
  static InitialScreen3 + #243, #32
  static InitialScreen3 + #244, #32
  static InitialScreen3 + #245, #32
  static InitialScreen3 + #246, #32
  static InitialScreen3 + #247, #32
  static InitialScreen3 + #248, #32
  static InitialScreen3 + #249, #32
  static InitialScreen3 + #250, #32
  static InitialScreen3 + #251, #32
  static InitialScreen3 + #252, #32
  static InitialScreen3 + #253, #32
  static InitialScreen3 + #254, #32
  static InitialScreen3 + #255, #32
  static InitialScreen3 + #256, #32
  static InitialScreen3 + #257, #2313
  static InitialScreen3 + #258, #32
  static InitialScreen3 + #259, #32
  static InitialScreen3 + #260, #2313
  static InitialScreen3 + #261, #2313
  static InitialScreen3 + #262, #2313
  static InitialScreen3 + #263, #32
  static InitialScreen3 + #264, #2313
  static InitialScreen3 + #265, #32
  static InitialScreen3 + #266, #32
  static InitialScreen3 + #267, #32
  static InitialScreen3 + #268, #32
  static InitialScreen3 + #269, #32
  static InitialScreen3 + #270, #32
  static InitialScreen3 + #271, #32
  static InitialScreen3 + #272, #32
  static InitialScreen3 + #273, #32
  static InitialScreen3 + #274, #32
  static InitialScreen3 + #275, #32
  static InitialScreen3 + #276, #32
  static InitialScreen3 + #277, #32
  static InitialScreen3 + #278, #32
  static InitialScreen3 + #279, #2825

  ;Linha 7
  static InitialScreen3 + #280, #2825
  static InitialScreen3 + #281, #32
  static InitialScreen3 + #282, #32
  static InitialScreen3 + #283, #32
  static InitialScreen3 + #284, #32
  static InitialScreen3 + #285, #32
  static InitialScreen3 + #286, #32
  static InitialScreen3 + #287, #32
  static InitialScreen3 + #288, #32
  static InitialScreen3 + #289, #32
  static InitialScreen3 + #290, #32
  static InitialScreen3 + #291, #32
  static InitialScreen3 + #292, #32
  static InitialScreen3 + #293, #32
  static InitialScreen3 + #294, #32
  static InitialScreen3 + #295, #32
  static InitialScreen3 + #296, #2313
  static InitialScreen3 + #297, #2313
  static InitialScreen3 + #298, #32
  static InitialScreen3 + #299, #2313
  static InitialScreen3 + #300, #2313
  static InitialScreen3 + #301, #2313
  static InitialScreen3 + #302, #2313
  static InitialScreen3 + #303, #2313
  static InitialScreen3 + #304, #2313
  static InitialScreen3 + #305, #32
  static InitialScreen3 + #306, #32
  static InitialScreen3 + #307, #32
  static InitialScreen3 + #308, #32
  static InitialScreen3 + #309, #32
  static InitialScreen3 + #310, #32
  static InitialScreen3 + #311, #32
  static InitialScreen3 + #312, #32
  static InitialScreen3 + #313, #32
  static InitialScreen3 + #314, #32
  static InitialScreen3 + #315, #32
  static InitialScreen3 + #316, #32
  static InitialScreen3 + #317, #32
  static InitialScreen3 + #318, #32
  static InitialScreen3 + #319, #2825

  ;Linha 8
  static InitialScreen3 + #320, #2825
  static InitialScreen3 + #321, #32
  static InitialScreen3 + #322, #32
  static InitialScreen3 + #323, #32
  static InitialScreen3 + #324, #32
  static InitialScreen3 + #325, #32
  static InitialScreen3 + #326, #32
  static InitialScreen3 + #327, #32
  static InitialScreen3 + #328, #32
  static InitialScreen3 + #329, #32
  static InitialScreen3 + #330, #32
  static InitialScreen3 + #331, #32
  static InitialScreen3 + #332, #32
  static InitialScreen3 + #333, #32
  static InitialScreen3 + #334, #32
  static InitialScreen3 + #335, #2313
  static InitialScreen3 + #336, #2313
  static InitialScreen3 + #337, #2313
  static InitialScreen3 + #338, #2313
  static InitialScreen3 + #339, #2313
  static InitialScreen3 + #340, #2313
  static InitialScreen3 + #341, #2313
  static InitialScreen3 + #342, #2313
  static InitialScreen3 + #343, #2313
  static InitialScreen3 + #344, #32
  static InitialScreen3 + #345, #32
  static InitialScreen3 + #346, #32
  static InitialScreen3 + #347, #32
  static InitialScreen3 + #348, #32
  static InitialScreen3 + #349, #32
  static InitialScreen3 + #350, #32
  static InitialScreen3 + #351, #32
  static InitialScreen3 + #352, #32
  static InitialScreen3 + #353, #32
  static InitialScreen3 + #354, #32
  static InitialScreen3 + #355, #32
  static InitialScreen3 + #356, #32
  static InitialScreen3 + #357, #32
  static InitialScreen3 + #358, #32
  static InitialScreen3 + #359, #2825

  ;Linha 9
  static InitialScreen3 + #360, #2825
  static InitialScreen3 + #361, #32
  static InitialScreen3 + #362, #32
  static InitialScreen3 + #363, #32
  static InitialScreen3 + #364, #32
  static InitialScreen3 + #365, #32
  static InitialScreen3 + #366, #32
  static InitialScreen3 + #367, #32
  static InitialScreen3 + #368, #32
  static InitialScreen3 + #369, #32
  static InitialScreen3 + #370, #32
  static InitialScreen3 + #371, #32
  static InitialScreen3 + #372, #32
  static InitialScreen3 + #373, #32
  static InitialScreen3 + #374, #2313
  static InitialScreen3 + #375, #2313
  static InitialScreen3 + #376, #2313
  static InitialScreen3 + #377, #2313
  static InitialScreen3 + #378, #2313
  static InitialScreen3 + #379, #9
  static InitialScreen3 + #380, #2313
  static InitialScreen3 + #381, #2313
  static InitialScreen3 + #382, #2313
  static InitialScreen3 + #383, #2313
  static InitialScreen3 + #384, #2313
  static InitialScreen3 + #385, #32
  static InitialScreen3 + #386, #32
  static InitialScreen3 + #387, #32
  static InitialScreen3 + #388, #32
  static InitialScreen3 + #389, #32
  static InitialScreen3 + #390, #32
  static InitialScreen3 + #391, #32
  static InitialScreen3 + #392, #32
  static InitialScreen3 + #393, #32
  static InitialScreen3 + #394, #32
  static InitialScreen3 + #395, #32
  static InitialScreen3 + #396, #32
  static InitialScreen3 + #397, #32
  static InitialScreen3 + #398, #32
  static InitialScreen3 + #399, #2825

  ;Linha 10
  static InitialScreen3 + #400, #2825
  static InitialScreen3 + #401, #32
  static InitialScreen3 + #402, #32
  static InitialScreen3 + #403, #32
  static InitialScreen3 + #404, #32
  static InitialScreen3 + #405, #32
  static InitialScreen3 + #406, #32
  static InitialScreen3 + #407, #32
  static InitialScreen3 + #408, #32
  static InitialScreen3 + #409, #32
  static InitialScreen3 + #410, #32
  static InitialScreen3 + #411, #32
  static InitialScreen3 + #412, #32
  static InitialScreen3 + #413, #32
  static InitialScreen3 + #414, #2313
  static InitialScreen3 + #415, #2313
  static InitialScreen3 + #416, #2313
  static InitialScreen3 + #417, #2313
  static InitialScreen3 + #418, #9
  static InitialScreen3 + #419, #9
  static InitialScreen3 + #420, #9
  static InitialScreen3 + #421, #2313
  static InitialScreen3 + #422, #2313
  static InitialScreen3 + #423, #2313
  static InitialScreen3 + #424, #2313
  static InitialScreen3 + #425, #32
  static InitialScreen3 + #426, #32
  static InitialScreen3 + #427, #32
  static InitialScreen3 + #428, #32
  static InitialScreen3 + #429, #32
  static InitialScreen3 + #430, #32
  static InitialScreen3 + #431, #32
  static InitialScreen3 + #432, #32
  static InitialScreen3 + #433, #32
  static InitialScreen3 + #434, #32
  static InitialScreen3 + #435, #32
  static InitialScreen3 + #436, #32
  static InitialScreen3 + #437, #32
  static InitialScreen3 + #438, #32
  static InitialScreen3 + #439, #2825

  ;Linha 11
  static InitialScreen3 + #440, #2825
  static InitialScreen3 + #441, #32
  static InitialScreen3 + #442, #32
  static InitialScreen3 + #443, #32
  static InitialScreen3 + #444, #32
  static InitialScreen3 + #445, #32
  static InitialScreen3 + #446, #32
  static InitialScreen3 + #447, #32
  static InitialScreen3 + #448, #32
  static InitialScreen3 + #449, #32
  static InitialScreen3 + #450, #32
  static InitialScreen3 + #451, #32
  static InitialScreen3 + #452, #32
  static InitialScreen3 + #453, #32
  static InitialScreen3 + #454, #2313
  static InitialScreen3 + #455, #2313
  static InitialScreen3 + #456, #2313
  static InitialScreen3 + #457, #9
  static InitialScreen3 + #458, #9
  static InitialScreen3 + #459, #2313
  static InitialScreen3 + #460, #9
  static InitialScreen3 + #461, #9
  static InitialScreen3 + #462, #2313
  static InitialScreen3 + #463, #2313
  static InitialScreen3 + #464, #2313
  static InitialScreen3 + #465, #32
  static InitialScreen3 + #466, #32
  static InitialScreen3 + #467, #32
  static InitialScreen3 + #468, #32
  static InitialScreen3 + #469, #32
  static InitialScreen3 + #470, #32
  static InitialScreen3 + #471, #32
  static InitialScreen3 + #472, #32
  static InitialScreen3 + #473, #32
  static InitialScreen3 + #474, #32
  static InitialScreen3 + #475, #32
  static InitialScreen3 + #476, #32
  static InitialScreen3 + #477, #32
  static InitialScreen3 + #478, #32
  static InitialScreen3 + #479, #2825

  ;Linha 12
  static InitialScreen3 + #480, #2825
  static InitialScreen3 + #481, #32
  static InitialScreen3 + #482, #32
  static InitialScreen3 + #483, #32
  static InitialScreen3 + #484, #32
  static InitialScreen3 + #485, #32
  static InitialScreen3 + #486, #32
  static InitialScreen3 + #487, #32
  static InitialScreen3 + #488, #32
  static InitialScreen3 + #489, #32
  static InitialScreen3 + #490, #32
  static InitialScreen3 + #491, #32
  static InitialScreen3 + #492, #32
  static InitialScreen3 + #493, #2313
  static InitialScreen3 + #494, #2313
  static InitialScreen3 + #495, #2313
  static InitialScreen3 + #496, #9
  static InitialScreen3 + #497, #9
  static InitialScreen3 + #498, #9
  static InitialScreen3 + #499, #9
  static InitialScreen3 + #500, #9
  static InitialScreen3 + #501, #9
  static InitialScreen3 + #502, #9
  static InitialScreen3 + #503, #2313
  static InitialScreen3 + #504, #2313
  static InitialScreen3 + #505, #2313
  static InitialScreen3 + #506, #32
  static InitialScreen3 + #507, #32
  static InitialScreen3 + #508, #32
  static InitialScreen3 + #509, #32
  static InitialScreen3 + #510, #32
  static InitialScreen3 + #511, #32
  static InitialScreen3 + #512, #32
  static InitialScreen3 + #513, #32
  static InitialScreen3 + #514, #32
  static InitialScreen3 + #515, #32
  static InitialScreen3 + #516, #32
  static InitialScreen3 + #517, #32
  static InitialScreen3 + #518, #32
  static InitialScreen3 + #519, #2825

  ;Linha 13
  static InitialScreen3 + #520, #2825
  static InitialScreen3 + #521, #32
  static InitialScreen3 + #522, #32
  static InitialScreen3 + #523, #32
  static InitialScreen3 + #524, #32
  static InitialScreen3 + #525, #32
  static InitialScreen3 + #526, #32
  static InitialScreen3 + #527, #32
  static InitialScreen3 + #528, #32
  static InitialScreen3 + #529, #32
  static InitialScreen3 + #530, #32
  static InitialScreen3 + #531, #32
  static InitialScreen3 + #532, #32
  static InitialScreen3 + #533, #2313
  static InitialScreen3 + #534, #2313
  static InitialScreen3 + #535, #9
  static InitialScreen3 + #536, #9
  static InitialScreen3 + #537, #9
  static InitialScreen3 + #538, #9
  static InitialScreen3 + #539, #9
  static InitialScreen3 + #540, #9
  static InitialScreen3 + #541, #9
  static InitialScreen3 + #542, #9
  static InitialScreen3 + #543, #9
  static InitialScreen3 + #544, #2313
  static InitialScreen3 + #545, #2313
  static InitialScreen3 + #546, #32
  static InitialScreen3 + #547, #32
  static InitialScreen3 + #548, #32
  static InitialScreen3 + #549, #32
  static InitialScreen3 + #550, #32
  static InitialScreen3 + #551, #32
  static InitialScreen3 + #552, #32
  static InitialScreen3 + #553, #32
  static InitialScreen3 + #554, #32
  static InitialScreen3 + #555, #32
  static InitialScreen3 + #556, #32
  static InitialScreen3 + #557, #32
  static InitialScreen3 + #558, #32
  static InitialScreen3 + #559, #2825

  ;Linha 14
  static InitialScreen3 + #560, #2825
  static InitialScreen3 + #561, #32
  static InitialScreen3 + #562, #32
  static InitialScreen3 + #563, #32
  static InitialScreen3 + #564, #32
  static InitialScreen3 + #565, #32
  static InitialScreen3 + #566, #32
  static InitialScreen3 + #567, #32
  static InitialScreen3 + #568, #32
  static InitialScreen3 + #569, #32
  static InitialScreen3 + #570, #32
  static InitialScreen3 + #571, #32
  static InitialScreen3 + #572, #32
  static InitialScreen3 + #573, #2313
  static InitialScreen3 + #574, #9
  static InitialScreen3 + #575, #9
  static InitialScreen3 + #576, #2313
  static InitialScreen3 + #577, #9
  static InitialScreen3 + #578, #9
  static InitialScreen3 + #579, #2313
  static InitialScreen3 + #580, #9
  static InitialScreen3 + #581, #9
  static InitialScreen3 + #582, #2313
  static InitialScreen3 + #583, #9
  static InitialScreen3 + #584, #9
  static InitialScreen3 + #585, #2313
  static InitialScreen3 + #586, #32
  static InitialScreen3 + #587, #32
  static InitialScreen3 + #588, #32
  static InitialScreen3 + #589, #32
  static InitialScreen3 + #590, #32
  static InitialScreen3 + #591, #32
  static InitialScreen3 + #592, #32
  static InitialScreen3 + #593, #32
  static InitialScreen3 + #594, #32
  static InitialScreen3 + #595, #32
  static InitialScreen3 + #596, #32
  static InitialScreen3 + #597, #32
  static InitialScreen3 + #598, #32
  static InitialScreen3 + #599, #2825

  ;Linha 15
  static InitialScreen3 + #600, #2825
  static InitialScreen3 + #601, #32
  static InitialScreen3 + #602, #32
  static InitialScreen3 + #603, #32
  static InitialScreen3 + #604, #32
  static InitialScreen3 + #605, #32
  static InitialScreen3 + #606, #32
  static InitialScreen3 + #607, #32
  static InitialScreen3 + #608, #32
  static InitialScreen3 + #609, #32
  static InitialScreen3 + #610, #32
  static InitialScreen3 + #611, #32
  static InitialScreen3 + #612, #32
  static InitialScreen3 + #613, #2313
  static InitialScreen3 + #614, #2313
  static InitialScreen3 + #615, #9
  static InitialScreen3 + #616, #9
  static InitialScreen3 + #617, #9
  static InitialScreen3 + #618, #9
  static InitialScreen3 + #619, #9
  static InitialScreen3 + #620, #9
  static InitialScreen3 + #621, #9
  static InitialScreen3 + #622, #9
  static InitialScreen3 + #623, #9
  static InitialScreen3 + #624, #2313
  static InitialScreen3 + #625, #2313
  static InitialScreen3 + #626, #32
  static InitialScreen3 + #627, #32
  static InitialScreen3 + #628, #32
  static InitialScreen3 + #629, #32
  static InitialScreen3 + #630, #32
  static InitialScreen3 + #631, #32
  static InitialScreen3 + #632, #32
  static InitialScreen3 + #633, #32
  static InitialScreen3 + #634, #32
  static InitialScreen3 + #635, #32
  static InitialScreen3 + #636, #32
  static InitialScreen3 + #637, #32
  static InitialScreen3 + #638, #32
  static InitialScreen3 + #639, #2825

  ;Linha 16
  static InitialScreen3 + #640, #2825
  static InitialScreen3 + #641, #32
  static InitialScreen3 + #642, #32
  static InitialScreen3 + #643, #32
  static InitialScreen3 + #644, #32
  static InitialScreen3 + #645, #32
  static InitialScreen3 + #646, #32
  static InitialScreen3 + #647, #32
  static InitialScreen3 + #648, #32
  static InitialScreen3 + #649, #32
  static InitialScreen3 + #650, #32
  static InitialScreen3 + #651, #32
  static InitialScreen3 + #652, #32
  static InitialScreen3 + #653, #32
  static InitialScreen3 + #654, #2313
  static InitialScreen3 + #655, #2313
  static InitialScreen3 + #656, #9
  static InitialScreen3 + #657, #9
  static InitialScreen3 + #658, #9
  static InitialScreen3 + #659, #9
  static InitialScreen3 + #660, #9
  static InitialScreen3 + #661, #9
  static InitialScreen3 + #662, #9
  static InitialScreen3 + #663, #2313
  static InitialScreen3 + #664, #2313
  static InitialScreen3 + #665, #32
  static InitialScreen3 + #666, #32
  static InitialScreen3 + #667, #32
  static InitialScreen3 + #668, #32
  static InitialScreen3 + #669, #32
  static InitialScreen3 + #670, #32
  static InitialScreen3 + #671, #32
  static InitialScreen3 + #672, #32
  static InitialScreen3 + #673, #32
  static InitialScreen3 + #674, #32
  static InitialScreen3 + #675, #32
  static InitialScreen3 + #676, #32
  static InitialScreen3 + #677, #32
  static InitialScreen3 + #678, #32
  static InitialScreen3 + #679, #2825

  ;Linha 17
  static InitialScreen3 + #680, #2825
  static InitialScreen3 + #681, #32
  static InitialScreen3 + #682, #32
  static InitialScreen3 + #683, #32
  static InitialScreen3 + #684, #32
  static InitialScreen3 + #685, #32
  static InitialScreen3 + #686, #32
  static InitialScreen3 + #687, #32
  static InitialScreen3 + #688, #32
  static InitialScreen3 + #689, #32
  static InitialScreen3 + #690, #32
  static InitialScreen3 + #691, #32
  static InitialScreen3 + #692, #32
  static InitialScreen3 + #693, #32
  static InitialScreen3 + #694, #32
  static InitialScreen3 + #695, #2313
  static InitialScreen3 + #696, #2313
  static InitialScreen3 + #697, #9
  static InitialScreen3 + #698, #9
  static InitialScreen3 + #699, #2313
  static InitialScreen3 + #700, #9
  static InitialScreen3 + #701, #9
  static InitialScreen3 + #702, #2313
  static InitialScreen3 + #703, #2313
  static InitialScreen3 + #704, #32
  static InitialScreen3 + #705, #32
  static InitialScreen3 + #706, #32
  static InitialScreen3 + #707, #32
  static InitialScreen3 + #708, #32
  static InitialScreen3 + #709, #32
  static InitialScreen3 + #710, #32
  static InitialScreen3 + #711, #32
  static InitialScreen3 + #712, #32
  static InitialScreen3 + #713, #32
  static InitialScreen3 + #714, #32
  static InitialScreen3 + #715, #32
  static InitialScreen3 + #716, #32
  static InitialScreen3 + #717, #32
  static InitialScreen3 + #718, #32
  static InitialScreen3 + #719, #2825

  ;Linha 18
  static InitialScreen3 + #720, #2825
  static InitialScreen3 + #721, #32
  static InitialScreen3 + #722, #32
  static InitialScreen3 + #723, #32
  static InitialScreen3 + #724, #32
  static InitialScreen3 + #725, #32
  static InitialScreen3 + #726, #32
  static InitialScreen3 + #727, #32
  static InitialScreen3 + #728, #32
  static InitialScreen3 + #729, #32
  static InitialScreen3 + #730, #32
  static InitialScreen3 + #731, #32
  static InitialScreen3 + #732, #32
  static InitialScreen3 + #733, #32
  static InitialScreen3 + #734, #32
  static InitialScreen3 + #735, #32
  static InitialScreen3 + #736, #2313
  static InitialScreen3 + #737, #2313
  static InitialScreen3 + #738, #9
  static InitialScreen3 + #739, #9
  static InitialScreen3 + #740, #9
  static InitialScreen3 + #741, #2313
  static InitialScreen3 + #742, #2313
  static InitialScreen3 + #743, #32
  static InitialScreen3 + #744, #32
  static InitialScreen3 + #745, #32
  static InitialScreen3 + #746, #32
  static InitialScreen3 + #747, #32
  static InitialScreen3 + #748, #32
  static InitialScreen3 + #749, #32
  static InitialScreen3 + #750, #32
  static InitialScreen3 + #751, #32
  static InitialScreen3 + #752, #32
  static InitialScreen3 + #753, #32
  static InitialScreen3 + #754, #32
  static InitialScreen3 + #755, #32
  static InitialScreen3 + #756, #32
  static InitialScreen3 + #757, #32
  static InitialScreen3 + #758, #32
  static InitialScreen3 + #759, #2825

  ;Linha 19
  static InitialScreen3 + #760, #2825
  static InitialScreen3 + #761, #32
  static InitialScreen3 + #762, #32
  static InitialScreen3 + #763, #32
  static InitialScreen3 + #764, #32
  static InitialScreen3 + #765, #32
  static InitialScreen3 + #766, #32
  static InitialScreen3 + #767, #32
  static InitialScreen3 + #768, #32
  static InitialScreen3 + #769, #32
  static InitialScreen3 + #770, #32
  static InitialScreen3 + #771, #32
  static InitialScreen3 + #772, #32
  static InitialScreen3 + #773, #32
  static InitialScreen3 + #774, #32
  static InitialScreen3 + #775, #32
  static InitialScreen3 + #776, #32
  static InitialScreen3 + #777, #2313
  static InitialScreen3 + #778, #2313
  static InitialScreen3 + #779, #9
  static InitialScreen3 + #780, #2313
  static InitialScreen3 + #781, #2313
  static InitialScreen3 + #782, #32
  static InitialScreen3 + #783, #32
  static InitialScreen3 + #784, #32
  static InitialScreen3 + #785, #32
  static InitialScreen3 + #786, #32
  static InitialScreen3 + #787, #32
  static InitialScreen3 + #788, #32
  static InitialScreen3 + #789, #32
  static InitialScreen3 + #790, #32
  static InitialScreen3 + #791, #32
  static InitialScreen3 + #792, #32
  static InitialScreen3 + #793, #32
  static InitialScreen3 + #794, #32
  static InitialScreen3 + #795, #32
  static InitialScreen3 + #796, #32
  static InitialScreen3 + #797, #32
  static InitialScreen3 + #798, #32
  static InitialScreen3 + #799, #2825

  ;Linha 20
  static InitialScreen3 + #800, #2825
  static InitialScreen3 + #801, #32
  static InitialScreen3 + #802, #32
  static InitialScreen3 + #803, #32
  static InitialScreen3 + #804, #32
  static InitialScreen3 + #805, #32
  static InitialScreen3 + #806, #32
  static InitialScreen3 + #807, #32
  static InitialScreen3 + #808, #32
  static InitialScreen3 + #809, #32
  static InitialScreen3 + #810, #32
  static InitialScreen3 + #811, #32
  static InitialScreen3 + #812, #32
  static InitialScreen3 + #813, #32
  static InitialScreen3 + #814, #32
  static InitialScreen3 + #815, #32
  static InitialScreen3 + #816, #32
  static InitialScreen3 + #817, #32
  static InitialScreen3 + #818, #2313
  static InitialScreen3 + #819, #2313
  static InitialScreen3 + #820, #2313
  static InitialScreen3 + #821, #32
  static InitialScreen3 + #822, #32
  static InitialScreen3 + #823, #32
  static InitialScreen3 + #824, #32
  static InitialScreen3 + #825, #32
  static InitialScreen3 + #826, #32
  static InitialScreen3 + #827, #32
  static InitialScreen3 + #828, #32
  static InitialScreen3 + #829, #32
  static InitialScreen3 + #830, #32
  static InitialScreen3 + #831, #32
  static InitialScreen3 + #832, #32
  static InitialScreen3 + #833, #32
  static InitialScreen3 + #834, #32
  static InitialScreen3 + #835, #32
  static InitialScreen3 + #836, #32
  static InitialScreen3 + #837, #32
  static InitialScreen3 + #838, #32
  static InitialScreen3 + #839, #2825

  ;Linha 21
  static InitialScreen3 + #840, #2825
  static InitialScreen3 + #841, #32
  static InitialScreen3 + #842, #32
  static InitialScreen3 + #843, #32
  static InitialScreen3 + #844, #32
  static InitialScreen3 + #845, #32
  static InitialScreen3 + #846, #32
  static InitialScreen3 + #847, #32
  static InitialScreen3 + #848, #32
  static InitialScreen3 + #849, #32
  static InitialScreen3 + #850, #32
  static InitialScreen3 + #851, #32
  static InitialScreen3 + #852, #32
  static InitialScreen3 + #853, #32
  static InitialScreen3 + #854, #32
  static InitialScreen3 + #855, #32
  static InitialScreen3 + #856, #32
  static InitialScreen3 + #857, #32
  static InitialScreen3 + #858, #32
  static InitialScreen3 + #859, #2313
  static InitialScreen3 + #860, #32
  static InitialScreen3 + #861, #32
  static InitialScreen3 + #862, #32
  static InitialScreen3 + #863, #32
  static InitialScreen3 + #864, #32
  static InitialScreen3 + #865, #32
  static InitialScreen3 + #866, #32
  static InitialScreen3 + #867, #32
  static InitialScreen3 + #868, #32
  static InitialScreen3 + #869, #32
  static InitialScreen3 + #870, #32
  static InitialScreen3 + #871, #32
  static InitialScreen3 + #872, #32
  static InitialScreen3 + #873, #32
  static InitialScreen3 + #874, #32
  static InitialScreen3 + #875, #32
  static InitialScreen3 + #876, #32
  static InitialScreen3 + #877, #32
  static InitialScreen3 + #878, #32
  static InitialScreen3 + #879, #2825

  ;Linha 22
  static InitialScreen3 + #880, #2825
  static InitialScreen3 + #881, #32
  static InitialScreen3 + #882, #32
  static InitialScreen3 + #883, #32
  static InitialScreen3 + #884, #32
  static InitialScreen3 + #885, #32
  static InitialScreen3 + #886, #32
  static InitialScreen3 + #887, #32
  static InitialScreen3 + #888, #32
  static InitialScreen3 + #889, #32
  static InitialScreen3 + #890, #32
  static InitialScreen3 + #891, #32
  static InitialScreen3 + #892, #32
  static InitialScreen3 + #893, #32
  static InitialScreen3 + #894, #32
  static InitialScreen3 + #895, #32
  static InitialScreen3 + #896, #32
  static InitialScreen3 + #897, #32
  static InitialScreen3 + #898, #32
  static InitialScreen3 + #899, #32
  static InitialScreen3 + #900, #32
  static InitialScreen3 + #901, #32
  static InitialScreen3 + #902, #32
  static InitialScreen3 + #903, #32
  static InitialScreen3 + #904, #32
  static InitialScreen3 + #905, #32
  static InitialScreen3 + #906, #32
  static InitialScreen3 + #907, #32
  static InitialScreen3 + #908, #32
  static InitialScreen3 + #909, #32
  static InitialScreen3 + #910, #32
  static InitialScreen3 + #911, #32
  static InitialScreen3 + #912, #32
  static InitialScreen3 + #913, #32
  static InitialScreen3 + #914, #32
  static InitialScreen3 + #915, #32
  static InitialScreen3 + #916, #32
  static InitialScreen3 + #917, #32
  static InitialScreen3 + #918, #32
  static InitialScreen3 + #919, #2825

  ;Linha 23
  static InitialScreen3 + #920, #2825
  static InitialScreen3 + #921, #32
  static InitialScreen3 + #922, #32
  static InitialScreen3 + #923, #32
  static InitialScreen3 + #924, #32
  static InitialScreen3 + #925, #32
  static InitialScreen3 + #926, #32
  static InitialScreen3 + #927, #32
  static InitialScreen3 + #928, #32
  static InitialScreen3 + #929, #32
  static InitialScreen3 + #930, #32
  static InitialScreen3 + #931, #32
  static InitialScreen3 + #932, #32
  static InitialScreen3 + #933, #32
  static InitialScreen3 + #934, #32
  static InitialScreen3 + #935, #32
  static InitialScreen3 + #936, #32
  static InitialScreen3 + #937, #32
  static InitialScreen3 + #938, #32
  static InitialScreen3 + #939, #32
  static InitialScreen3 + #940, #32
  static InitialScreen3 + #941, #32
  static InitialScreen3 + #942, #32
  static InitialScreen3 + #943, #32
  static InitialScreen3 + #944, #32
  static InitialScreen3 + #945, #32
  static InitialScreen3 + #946, #32
  static InitialScreen3 + #947, #32
  static InitialScreen3 + #948, #32
  static InitialScreen3 + #949, #32
  static InitialScreen3 + #950, #32
  static InitialScreen3 + #951, #32
  static InitialScreen3 + #952, #32
  static InitialScreen3 + #953, #32
  static InitialScreen3 + #954, #32
  static InitialScreen3 + #955, #32
  static InitialScreen3 + #956, #32
  static InitialScreen3 + #957, #32
  static InitialScreen3 + #958, #32
  static InitialScreen3 + #959, #2825

  ;Linha 24
  static InitialScreen3 + #960, #2825
  static InitialScreen3 + #961, #32
  static InitialScreen3 + #962, #32
  static InitialScreen3 + #963, #32
  static InitialScreen3 + #964, #32
  static InitialScreen3 + #965, #32
  static InitialScreen3 + #966, #32
  static InitialScreen3 + #967, #32
  static InitialScreen3 + #968, #32
  static InitialScreen3 + #969, #32
  static InitialScreen3 + #970, #32
  static InitialScreen3 + #971, #32
  static InitialScreen3 + #972, #32
  static InitialScreen3 + #973, #32
  static InitialScreen3 + #974, #32
  static InitialScreen3 + #975, #32
  static InitialScreen3 + #976, #2882
  static InitialScreen3 + #977, #2885
  static InitialScreen3 + #978, #2900
  static InitialScreen3 + #979, #32
  static InitialScreen3 + #980, #2901
  static InitialScreen3 + #981, #2899
  static InitialScreen3 + #982, #2896
  static InitialScreen3 + #983, #32
  static InitialScreen3 + #984, #32
  static InitialScreen3 + #985, #32
  static InitialScreen3 + #986, #32
  static InitialScreen3 + #987, #32
  static InitialScreen3 + #988, #32
  static InitialScreen3 + #989, #32
  static InitialScreen3 + #990, #32
  static InitialScreen3 + #991, #32
  static InitialScreen3 + #992, #32
  static InitialScreen3 + #993, #32
  static InitialScreen3 + #994, #32
  static InitialScreen3 + #995, #32
  static InitialScreen3 + #996, #32
  static InitialScreen3 + #997, #32
  static InitialScreen3 + #998, #32
  static InitialScreen3 + #999, #2825

  ;Linha 25
  static InitialScreen3 + #1000, #2825
  static InitialScreen3 + #1001, #32
  static InitialScreen3 + #1002, #32
  static InitialScreen3 + #1003, #32
  static InitialScreen3 + #1004, #32
  static InitialScreen3 + #1005, #32
  static InitialScreen3 + #1006, #32
  static InitialScreen3 + #1007, #32
  static InitialScreen3 + #1008, #32
  static InitialScreen3 + #1009, #32
  static InitialScreen3 + #1010, #32
  static InitialScreen3 + #1011, #32
  static InitialScreen3 + #1012, #32
  static InitialScreen3 + #1013, #32
  static InitialScreen3 + #1014, #32
  static InitialScreen3 + #1015, #32
  static InitialScreen3 + #1016, #32
  static InitialScreen3 + #1017, #32
  static InitialScreen3 + #1018, #32
  static InitialScreen3 + #1019, #32
  static InitialScreen3 + #1020, #32
  static InitialScreen3 + #1021, #32
  static InitialScreen3 + #1022, #32
  static InitialScreen3 + #1023, #32
  static InitialScreen3 + #1024, #32
  static InitialScreen3 + #1025, #32
  static InitialScreen3 + #1026, #32
  static InitialScreen3 + #1027, #32
  static InitialScreen3 + #1028, #32
  static InitialScreen3 + #1029, #32
  static InitialScreen3 + #1030, #32
  static InitialScreen3 + #1031, #32
  static InitialScreen3 + #1032, #32
  static InitialScreen3 + #1033, #32
  static InitialScreen3 + #1034, #32
  static InitialScreen3 + #1035, #32
  static InitialScreen3 + #1036, #32
  static InitialScreen3 + #1037, #32
  static InitialScreen3 + #1038, #32
  static InitialScreen3 + #1039, #2825

  ;Linha 26
  static InitialScreen3 + #1040, #2825
  static InitialScreen3 + #1041, #32
  static InitialScreen3 + #1042, #32
  static InitialScreen3 + #1043, #32
  static InitialScreen3 + #1044, #32
  static InitialScreen3 + #1045, #32
  static InitialScreen3 + #1046, #32
  static InitialScreen3 + #1047, #32
  static InitialScreen3 + #1048, #32
  static InitialScreen3 + #1049, #32
  static InitialScreen3 + #1050, #32
  static InitialScreen3 + #1051, #32
  static InitialScreen3 + #1052, #32
  static InitialScreen3 + #1053, #2907
  static InitialScreen3 + #1054, #32
  static InitialScreen3 + #1055, #2879
  static InitialScreen3 + #1056, #32
  static InitialScreen3 + #1057, #2900
  static InitialScreen3 + #1058, #2933
  static InitialScreen3 + #1059, #2932
  static InitialScreen3 + #1060, #2927
  static InitialScreen3 + #1061, #2930
  static InitialScreen3 + #1062, #2921
  static InitialScreen3 + #1063, #2913
  static InitialScreen3 + #1064, #2924
  static InitialScreen3 + #1065, #2909
  static InitialScreen3 + #1066, #32
  static InitialScreen3 + #1067, #32
  static InitialScreen3 + #1068, #32
  static InitialScreen3 + #1069, #32
  static InitialScreen3 + #1070, #32
  static InitialScreen3 + #1071, #32
  static InitialScreen3 + #1072, #32
  static InitialScreen3 + #1073, #32
  static InitialScreen3 + #1074, #32
  static InitialScreen3 + #1075, #32
  static InitialScreen3 + #1076, #32
  static InitialScreen3 + #1077, #32
  static InitialScreen3 + #1078, #32
  static InitialScreen3 + #1079, #2825

  ;Linha 27
  static InitialScreen3 + #1080, #2825
  static InitialScreen3 + #1081, #32
  static InitialScreen3 + #1082, #32
  static InitialScreen3 + #1083, #32
  static InitialScreen3 + #1084, #32
  static InitialScreen3 + #1085, #32
  static InitialScreen3 + #1086, #32
  static InitialScreen3 + #1087, #32
  static InitialScreen3 + #1088, #32
  static InitialScreen3 + #1089, #32
  static InitialScreen3 + #1090, #32
  static InitialScreen3 + #1091, #32
  static InitialScreen3 + #1092, #32
  static InitialScreen3 + #1093, #2907
  static InitialScreen3 + #1094, #2885
  static InitialScreen3 + #1095, #2926
  static InitialScreen3 + #1096, #2932
  static InitialScreen3 + #1097, #2917
  static InitialScreen3 + #1098, #2930
  static InitialScreen3 + #1099, #32
  static InitialScreen3 + #1100, #2890
  static InitialScreen3 + #1101, #2927
  static InitialScreen3 + #1102, #2919
  static InitialScreen3 + #1103, #2913
  static InitialScreen3 + #1104, #2930
  static InitialScreen3 + #1105, #2909
  static InitialScreen3 + #1106, #32
  static InitialScreen3 + #1107, #32
  static InitialScreen3 + #1108, #32
  static InitialScreen3 + #1109, #32
  static InitialScreen3 + #1110, #32
  static InitialScreen3 + #1111, #32
  static InitialScreen3 + #1112, #32
  static InitialScreen3 + #1113, #32
  static InitialScreen3 + #1114, #32
  static InitialScreen3 + #1115, #32
  static InitialScreen3 + #1116, #32
  static InitialScreen3 + #1117, #32
  static InitialScreen3 + #1118, #32
  static InitialScreen3 + #1119, #2825

  ;Linha 28
  static InitialScreen3 + #1120, #2825
  static InitialScreen3 + #1121, #32
  static InitialScreen3 + #1122, #32
  static InitialScreen3 + #1123, #32
  static InitialScreen3 + #1124, #32
  static InitialScreen3 + #1125, #32
  static InitialScreen3 + #1126, #32
  static InitialScreen3 + #1127, #32
  static InitialScreen3 + #1128, #32
  static InitialScreen3 + #1129, #32
  static InitialScreen3 + #1130, #32
  static InitialScreen3 + #1131, #32
  static InitialScreen3 + #1132, #32
  static InitialScreen3 + #1133, #32
  static InitialScreen3 + #1134, #32
  static InitialScreen3 + #1135, #32
  static InitialScreen3 + #1136, #32
  static InitialScreen3 + #1137, #32
  static InitialScreen3 + #1138, #32
  static InitialScreen3 + #1139, #32
  static InitialScreen3 + #1140, #32
  static InitialScreen3 + #1141, #32
  static InitialScreen3 + #1142, #32
  static InitialScreen3 + #1143, #32
  static InitialScreen3 + #1144, #32
  static InitialScreen3 + #1145, #32
  static InitialScreen3 + #1146, #32
  static InitialScreen3 + #1147, #32
  static InitialScreen3 + #1148, #32
  static InitialScreen3 + #1149, #32
  static InitialScreen3 + #1150, #32
  static InitialScreen3 + #1151, #32
  static InitialScreen3 + #1152, #32
  static InitialScreen3 + #1153, #32
  static InitialScreen3 + #1154, #32
  static InitialScreen3 + #1155, #32
  static InitialScreen3 + #1156, #32
  static InitialScreen3 + #1157, #32
  static InitialScreen3 + #1158, #32
  static InitialScreen3 + #1159, #2825

  ;Linha 29
  static InitialScreen3 + #1160, #2825
  static InitialScreen3 + #1161, #2825
  static InitialScreen3 + #1162, #2825
  static InitialScreen3 + #1163, #2825
  static InitialScreen3 + #1164, #2825
  static InitialScreen3 + #1165, #2825
  static InitialScreen3 + #1166, #2825
  static InitialScreen3 + #1167, #2825
  static InitialScreen3 + #1168, #2825
  static InitialScreen3 + #1169, #2825
  static InitialScreen3 + #1170, #2825
  static InitialScreen3 + #1171, #2825
  static InitialScreen3 + #1172, #2825
  static InitialScreen3 + #1173, #2825
  static InitialScreen3 + #1174, #2825
  static InitialScreen3 + #1175, #2825
  static InitialScreen3 + #1176, #2825
  static InitialScreen3 + #1177, #2825
  static InitialScreen3 + #1178, #2825
  static InitialScreen3 + #1179, #2825
  static InitialScreen3 + #1180, #2825
  static InitialScreen3 + #1181, #2825
  static InitialScreen3 + #1182, #2825
  static InitialScreen3 + #1183, #2825
  static InitialScreen3 + #1184, #2825
  static InitialScreen3 + #1185, #2825
  static InitialScreen3 + #1186, #2825
  static InitialScreen3 + #1187, #2825
  static InitialScreen3 + #1188, #2825
  static InitialScreen3 + #1189, #2825
  static InitialScreen3 + #1190, #2825
  static InitialScreen3 + #1191, #2825
  static InitialScreen3 + #1192, #2825
  static InitialScreen3 + #1193, #2825
  static InitialScreen3 + #1194, #2825
  static InitialScreen3 + #1195, #2825
  static InitialScreen3 + #1196, #2825
  static InitialScreen3 + #1197, #2825
  static InitialScreen3 + #1198, #2825
  static InitialScreen3 + #1199, #2825
;

Tutorial_Screen : string "                                                                                                Tutorial                                                          [w] -                                   [s] -                                   [a] -                                   [d] -                                                                           [q] -                                                                           [?] -                                                                           <Enter> -                                                                        Resultados:                                                                     Nada    = 0x                            Duplo   = 1x                            Jackpot = 2x                                                                                                                                                                                                                                                                                                                                                                                                                                         "
AllInScreen     : string "                                                                                                                                                                                                           [ Limite de dinheiro ultrapassado ]      [ <Enter> para fazer um All-In ]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            "
EndScreen       : string "                                                                                                End Game                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "
StopScreen      : string "                                                                                                  Stop                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          "
UnderflowScreen : string "                                                                                                 Faliu                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          "
OverflowScreen  : string "                                                                                                 Ganhou                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         "

; |==================| Section: Memory Variables |==================|

Money : var #1
  static Money, #64
;

Limit : var #1
  static Limit, #65535
;

ChipsInitialPosition : var #1
  static ChipsInitialPosition, #293
  ; static ChipsInitialPosition, #933
;
CurChip : var #1
  static CurChip, #3
;

Chips : var #5
  static Chips + #0, #0       ; 10000
  static Chips + #1, #0       ; 1000
  static Chips + #2, #0       ; 100
  static Chips + #3, #1       ; 10
  static Chips + #4, #0       ; 1
;

ChipsColors : var #5
  static ChipsColors + #0, #1290       ; Roxo         (#1280)
  static ChipsColors + #1, #1034       ; Azul marinho (#1024)
  static ChipsColors + #2, #522        ; Verde        (#512)
  static ChipsColors + #3, #2314       ; Vermelho     (#2304)
  static ChipsColors + #4, #10         ; Branco       (#0)
;

; |==================| Section: Main Code |==================|

main:

  call _setInitialMoney
  call _setInitialChips

  call _showInitialScreen
  ceq _showTutorialScreen

	GameStart:
		
    call _showGameScreen
    call _showMoney
    call _showChips

		GameLoop:

      call _takeCommand
      
      jnc StopGame
      
      call _checkMoney
      jle MoneyUnderflow
      jgr MoneyOverflow

      call _checkChips

      call _showMoney
			call _showChips

			jmp GameLoop
		;
  ;

  MoneyUnderflow:
    loadn r0, #UnderflowScreen
    call printScreen
    jmp END
  ;

  MoneyOverflow:
    loadn r0, #OverflowScreen
    call printScreen
    jmp END
  ;

  StopGame:
    loadn r0, #StopScreen
    call printScreen
    jmp END
  ;

  ExitGame:
    loadn r0, #EndScreen
    call printScreen
    jmp END
  ;

  GameOverflow:
    loadn r0, #AllInScreen
    call printScreen
    jmp END
  ;
;

; |==================| Section: Routines  |==================|

; |------------------| Screens Routines |------------------|

_showInitialScreen:
  push r0
  push r1
  push r2

  loadn r1, #13   ; [r1] = <Enter>
  loadn r2, #63   ; [r2] = '?'

  _showInitialScreen_Loop:

    loadn r0, #InitialScreen1
    call printScreen

    call IncharDelay                  ; [r0] = Inchar Value
    cmp r0, r1                        ; [r0] == [r1] | Inchar Value == <Enter>
    jeq _showInitialScreen_Game
    cmp r0, r2                        ; [r0] == [r2] | Inchar Value == '?'
    jeq _showInitialScreen_Tutorial

    loadn r0, #InitialScreen2
    call printScreen

    call IncharDelay                  ; [r0] = Inchar Value
    cmp r0, r1                        ; [r0] == [r1] | Inchar Value == <Enter>
    jeq _showInitialScreen_Game
    cmp r0, r2                        ; [r0] == [r2] | Inchar Value == '?'
    jeq _showInitialScreen_Tutorial
    
    loadn r0, #InitialScreen3
    call printScreen

    call IncharDelay                  ; [r0] = Inchar Value
    cmp r0, r1                        ; [r0] == [r1] | Inchar Value == <Enter>
    jeq _showInitialScreen_Game
    cmp r0, r2                        ; [r0] == [r2] | Inchar Value == '?'
    jeq _showInitialScreen_Tutorial
    
    jmp _showInitialScreen_Loop 

  _showInitialScreen_Game:
    cmp r1, r2
    jmp _showInitialScreen_Exit
  ;
  
  _showInitialScreen_Tutorial:
    cmp r1, r1
    jmp _showInitialScreen_Exit
  ;
  
  _showInitialScreen_Exit:
  
  pop r2
  pop r1
  pop r0
  rts
; END _showInitialScreen

_showTutorialScreen:
  push r0

  loadn r0, #Tutorial_Screen
  call printScreen

  call waitEnter

  pop r0
  rts
; END _showTutorialScreen

_showGameScreen:
  push r0

  loadn r0, #GameScreen
  call printScreen

  pop r0
  rts
; END _showGameScreen

_showMoney:
  push r0
  push r1
  push r5

  loadn r0, #Money
  loadi r1, r0
  loadn r5, #560     ; '0' + greenColor ( 48 + 512 )
  
  call printMoney

  pop r5
  pop r1
  pop r0
  rts
; END _showMoney

_showChips:
  push r0
  push r1
  push r2
  push r3
  push r4
  push r5
  push r6
  push r7

  loadn r0, #0
  load  r1, ChipsInitialPosition
  loadn r2, #Chips
  loadn r3, #ChipsColors
  loadn r4, #5

  loadn r5, #48
  load  r6, CurChip

  _showChips_Loop:
    
    add r7, r2, r0
    loadi r7, r7

    cmp r0, r6
    jne _showChips_Loop_White
      loadn r5, #2864
    _showChips_Loop_White:

    add r7, r7, r5
    loadn r5, #48

    outchar r7, r1
    inc r1

    add r7, r3, r0
    loadi r7, r7

    outchar r7, r1

    inc r0
    inc r1
    inc r1
    dec r4
    jnz _showChips_Loop

  pop r7
  pop r6
  pop r5
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
  rts
; END _showChips

; |------------------| Commands Routines |------------------|

_takeCommand:
  push r0
  push r1
  push r2
  push r3
  push r4

  loadn r1, #255  ; Non-Inchar
  loadn r3, #0
  loadn r4, #1000
  
  _takeCommand_Loop:
    inchar r0
    cmp r0, r1
    jne _takeCommand_LoopExit
    inc r3
    mod r3, r3, r4
    jmp _takeCommand_Loop
  ;

  _takeCommand_LoopExit:

  loadn r1, #119	; 'w'
  cmp r0, r1
  ceq updateChips
  jeq _takeCommand_SetC

  loadn r1, #97	; 'a'
  cmp r0, r1
  ceq updateChips
  jeq _takeCommand_SetC

  loadn r1, #115	; 's'
  cmp r0, r1
  ceq updateChips
  jeq _takeCommand_SetC

  loadn r1, #100	; 'd'
  cmp r0, r1
  ceq updateChips
  jeq _takeCommand_SetC

  loadn r1, #13	; <Enter>
  cmp r0, r1
  jeq _takeCommand_Enter

  loadn r1, #32	; <Space>
  cmp r0, r1
  jeq _takeCommand_Space

  loadn r1, #63	; '?'
  cmp r0, r1
  jeq _takeCommand_Help

  loadn r1, #60 ; '<'
  cmp r0, r1
  jeq _takeCommand_ADMIN0
  
  loadn r1, #62 ; '>'
  cmp r0, r1
  jeq _takeCommand_ADMIN1
  
  loadn r1, #43 ; '+'
  cmp r0, r1
  jeq _takeCommand_ADMIN2

  loadn r1, #45 ; '-'
  cmp r0, r1
  jeq _takeCommand_ADMIN3
  
  jmp _takeCommand_Loop

  _takeCommand_Enter:
    ; Wager
    mov r0, r3
    call wager
    jmp _takeCommand_SetC
  ;

  _takeCommand_Space:
    ; Stop
    jmp _takeCommand_ClearC
  ;

  _takeCommand_ADMIN0:
    loadn r0, #0
    store Money, r0
    jmp _takeCommand_SetC
  ;
  _takeCommand_ADMIN1:
    load  r0, Limit
    store Money, r0
    jmp _takeCommand_SetC
  ;

  _takeCommand_ADMIN2:
    load  r0, Money
    add r0, r0, r0
    store Money, r0
    jmp _takeCommand_SetC
  ;
  
  _takeCommand_ADMIN3:
    load  r0, Money
    loadn r1, #2
    div r0, r0, r1
    store Money, r0
    jmp _takeCommand_SetC
  ;

  _takeCommand_Help:
    ; Help
    call _showTutorialScreen
    call _showGameScreen
    jmp _takeCommand_SetC
  ;

  _takeCommand_SetC:
    setc
    jmp _takeCommand_Exit
  ;
  _takeCommand_ClearC:
    clearc
    jmp _takeCommand_Exit
  ;
  
  _takeCommand_Exit:

  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
  rts
; END _takeCommand

; |------------------| Checks Routines |------------------|

_checkMoney:

  push r0
  push r1

  load  r0, Money

  loadn r1, #0
  cmp r0, r1
  jeq _checkMoney_Underflow

  load r1, Limit
  cmp r0, r1
  jeq _checkMoney_Overflow

  loadn r0, #0
  loadn r1, #0
  jmp _checkMoney_Exit

  _checkMoney_Underflow:
    loadn r0, #0
    loadn r1, #1
    jmp _checkMoney_Exit
  ;
  _checkMoney_Overflow:
    loadn r0, #1
    loadn r1, #0
    jmp _checkMoney_Exit
  ;

  _checkMoney_Exit:
  cmp r0, r1

  pop r1
  pop r0
  rts
; END _checkMoney

_checkChips:

  push r0
  push r1

  call getChips   ; [r0] = Chips
  load r1, Money  ; [r1] = Money

  cmp r0, r1
  jel _checkChips_Exit

  mov r0, r1
  call setChips   ; if (Money < Chips) Chips = Money

  _checkChips_Exit:

  pop r1
  pop r0
  rts
; END _checkChips

; |------------------| Initial Sets Routines |------------------|

_setInitialMoney:

  push r0
  push r1

  load  r0, Money
  loadn r1, #1

  cmp r0, r1
  jeg _setInitialMoney_Exit
    loadn r1, #64
    store Money, r1
  _setInitialMoney_Exit:

  pop r1
  pop r0
  rts
; END _setInitialMoney

_setInitialChips:

  push r0
  
  loadn r0, #10
  call setChips

  loadn r0, #3
  store CurChip, r0
  
  pop r0
  rts
; END _setInitialChips

; |==================| Section: Functions |==================|

; |------------------| I/O Functions |------------------|

printScreen: ; Use [r0] as Memory Adress of Screen
		
	; [r0] = Memory Adress
	; [r1] = Position to Outchar  | Index of Screen
	; [r2] = Limit (Constant #1200) 
  ; [r3] = Character to Outchar

  push r1
  push r2
  push r3

  loadn r1, #0
  loadn r2, #1200

  printScreen_Loop:

    add r3, r0, r1
    loadi r3, r3
    outchar r3, r1
    
    inc r1
    cmp r1, r2

    jne printScreen_Loop

  pop r3
  pop r2
  pop r1
	rts
; END printScreen	

IncharDelay: ; User [r0] as Inchar value
  
  ; [r0] = Inchar Value
  ; [r1] = Non-Inchar Value
  ; [r2] = Delay

  push r1
  push r2

  loadn r1, #255
  loadn r2, #16384
  
  readKeyDelay_Loop:
    inchar r0
    cmp r0, r1
    jne readKeyDelay_Exit 
    dec r2
    jnz readKeyDelay_Loop    
  ;

  readKeyDelay_Exit:

  pop r2
  pop r1
  rts
; END IncharDelay

printMoney: ; Use [r1] as Number to Outchar & [r5] as Constant color + '0'

	; [r0] = Constant #10
	; [r1] = Number to Outchar
	; [r2] = Digits to Outchar
	; [r3] = Qty of digits + 1
	; [r4] = Position to print
	; [r5] = Constant greenColor + '0' (512 + 48)
	; [r6] = Qty of digits to clean

	push r0
	push r1
	push r2
	push r3
	push r4
  push r5
  push r6

	loadn r0, #10
	loadn r3, #0
	loadn r4, #113
  loadn r6, #5

	printMoney_PUSH:
		
		mod r2, r1, r0
		
		push r2
		inc r3
    dec r6
		
		div r1, r1, r0
		
		jnz printMoney_PUSH
	;
	
	printMoney_POP:
		
		pop r2
	
		add r2, r2, r5
		
		outchar r2, r4

		inc r4
		dec r3
		jnz printMoney_POP		
	;

  cmp r3, r6
  jeq printMoney_EXIT

  loadn r2, #' '

  printMoney_Clean:

    outchar r2, r4
    inc r4
    dec r6
    jnz printMoney_Clean
	
	printMoney_EXIT:
	
  pop r6
  pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
; END printMoney

waitEnter:
	
	; [r0] = Inchar Value
	; [r1] = <Enter> Value
	
	push r0
	push r1
	
	loadn r1, #13
	
	waitEnter_Loop:
		inchar r0				
		cmp r0, r1
		jne waitEnter_Loop
	;

	pop r1
	pop r0
	rts
; END waitEnter

; |------------------| Chips Functions |------------------|

updateChips: ; User [r0] as WTD

  ; [r0] = Command
  ; [r1] = Aux
  ; [r2] = Limit

  push fr
  push r0
  push r1
  push r2

  loadn r1, #119	; 'w'
  cmp r0, r1
  jeq updateChips_w

  loadn r1, #97	; 'a'
  cmp r0, r1
  jeq updateChips_a

  loadn r1, #115	; 's'
  cmp r0, r1
  jeq updateChips_s

  loadn r1, #100	; 'd'
  cmp r0, r1
  jeq updateChips_d

  updateChips_w:
    call getChips         ; [r0] = Chips
    call getCurChip       ; [r1] = CurChip
    
    add r0, r0, r1        ; [r0] = Chips + CurChips
    
    load  r2, Money
    cmp r0, r2
    cel setChips          ; [r0] <= Money -> Store [r0]

    jmp updateChips_Exit
  ;

  updateChips_a:
    loadn r2, #0
    load r0, CurChip
    dec r0
    cmp r0, r2
    jle updateChips_Exit
    store CurChip, r0
    jmp updateChips_Exit
  ;

  updateChips_s:
    call getChips         ; [r0] = Chips
    call getCurChip       ; [r1] = CurChip
    
    sub r0, r0, r1        ; [r0] = [r1] - [r0] === [r0] = CurChip - Chips

    loadn r2, #1
    cmp r0, r2
    ceg setChips          ; [r0] >= 1 -> Store [r0]

    jmp updateChips_Exit
  ;

  updateChips_d:
    loadn r2, #4
    load r0, CurChip
    inc r0
    cmp r0, r2
    jgr updateChips_Exit
    store CurChip, r0
    jmp updateChips_Exit
  ;

  updateChips_Exit:

  pop r2
  pop r1
  pop r0
  pop fr
  rts
; END updateChips

getCurChip: ; Use [r1] as CurChip

  push r0
  push r2
  push r3

  load  r0, CurChip
  loadn r1, #1
  loadn r2, #4
  loadn r3, #10

  getCurChip_Loop:
    cmp r0, r2
    jeq getCurChip_Exit
    mul r1, r1, r3
    inc r0
    jmp getCurChip_Loop
  ;
  getCurChip_Exit:

  pop r3
  pop r2
  pop r0
  rts
; END getCurChip

getChips: ; Use [r0] as Chips

  push r1
  push r2
  push r3
  push r4

  loadn r0, #0
  loadn r1, #Chips
  loadn r3, #10
  loadn r4, #5

  getChips_Loop:
    loadi r2, r1

    mul r0, r0, r3
    add r0, r0, r2

    inc r1
    dec r4
    jnz getChips_Loop
  ;

  pop r4
  pop r3
  pop r2
  pop r1
  rts
; END getChips

setChips: ; Use [r0] as Chips

  push r0
  push r1
  push r2
  push r3
  push r4

  loadn r1, #Chips
  loadn r2, #4
  add r1, r1, r2

  loadn r2, #5
  loadn r3, #10
  
  setChips_Loop:
    mod r4, r0, r3
    div r0, r0, r3

    storei r1, r4

    dec r1
    dec r2
    jnz setChips_Loop
  ;

  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
  rts
; END setChips

; |------------------| Wager Functions |------------------|

wager: ; Use [r0] as Number
	
	; [r0] = Number | Chips
	; [r1] = Aux    | Money
	; [r2] = Aux    | Aux

	push r0
  push r1
	push r2
	push r3

  call writeWager

	; r0 % 111 == 0:		  ; xxx
	loadn r1, #111
	mod r2, r0, r1
	jz wager_Triple
	
	; r0 // 10 % 11 == 0:	; xxy
	loadn r1, #10
	div r2, r0, r1
	
	loadn r1, #11
	mod r2, r2, r1
	jz wager_Twice
	
	; r0 % 101 % 10 == 0:	; xyx
	loadn r1, #101
	mod r2, r0, r1
	
	loadn r1, #10
	mod r2, r2, r1
	jz wager_Twice
	
	; r0 % 100 % 11 == 0:	; yxx
	loadn r1, #100
	mod r2, r0, r1
	
	loadn r1, #11
	mod r2, r2, r1
	jz wager_Twice
	
	jmp waget_Once			  ; xyz

	wager_Triple:
		loadn r2, #3        ; [r2] = #3
    jmp waget_CalMoney
	;
	
	wager_Twice:
		loadn r2, #2        ; [r2] = #2
    jmp waget_CalMoney
	;

  waget_Once:
		loadn r2, #0        ; [r2] = #0
    jmp waget_CalMoney
	;

	waget_CalMoney:
	
  call getChips       ; [r0] = Chips
  load r1, Money      ; [r1] = Money
  load r3, Limit      ; [r3] = Limit

  ; Money -= Chips
  sub r1, r1, r0      ; [r1] = [r1] - [r0] | [r1] = Money - Chips

  ; Chips *= [r2]
  mul r0, r0, r2      ; [r1] = [r0] * [r2] | [r1] = Chips * [r2]

  ; Check if Overflow
  sub r3, r3, r1      ; [r3] = [r3] - [r1] | [r3] = Limit - Money
  cmp r0, r3
  jgr waget_Overflow  ; [r1] > [r3]        | Chips > ( Limit - Money ) -> Overflow

  ; Money += Chips
  add r1, r0, r1      ; [r1] = [r0] + [r1] | [r1] = Money + Chips
  jmp waget_Store

  waget_Overflow:
    load r1, Limit
  ;

  waget_Store:

  store Money, r1
	
	pop r3
	pop r2
	pop r1
	pop r0
	rts
; END wager

writeWager: ; Use [r0] as Number to Outchar
	
	; [r0] = prgn to Outchar
	; [r1] = Constant #10
	; [r2] = Digit to Outchar
	; [r3] = Contant yellowColor + '0' (2816 + 48)
	; [r4] = Positions of the Digits
	
	push r0
	push r1
	push r2
	push r3
	push r4
	
	loadn r1, #10
	loadn r3, #2864
	
	mod r2, r0, r1
	div r0, r0, r1
	
	add r2, r2, r3
	
	loadn r4, #583
	outchar r2, r4

	mod r2, r0, r1
	div r0, r0, r1
	
	add r2, r2, r3
	
	loadn r4, #579
	outchar r2, r4
	
	mod r2, r0, r1
	div r0, r0, r1
	
	add r2, r2, r3
	
	loadn r4, #575
	outchar r2, r4
		
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
; END writeprgn

; |==================| END |==================|

END:
  breakp
  jmp END
;
