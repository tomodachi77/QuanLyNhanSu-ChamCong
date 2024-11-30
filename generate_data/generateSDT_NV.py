import random

ids = [8058, 9750, 2034, 2790, 1452, 9714, 9858, 7733, 9240, 3993, 7947, 6256, 7528, 9606, 8120, 1967, 3587, 4867, 5474, 7994, 4906, 4739, 5194, 2825, 8481, 8049, 9229, 8929, 5031, 5170, 4620, 2977, 8703, 6713, 2368, 3678, 6452, 5192, 3577, 6411, 9574, 1108, 6510, 1371, 9225, 9983, 9007, 5494, 5604, 3205, 7597, 1252, 4602, 5594, 3981, 1271, 3984, 6562, 9964, 2689, 4052, 8112, 8232, 6475, 9648, 2494, 4526, 9375, 9119, 9022, 6789, 1282, 5235, 9548, 6406, 7803, 2231, 2551, 5858, 2582, 8680, 8937, 5324, 4036, 6043, 1492, 9676, 3709, 6419, 8084, 3265, 6786, 5849, 3308, 8278, 2124, 3171, 3058, 3857, 5775, 7197, 3140, 4225, 2137, 9115, 1778, 1816, 2357, 7466, 8971, 7040, 2553, 3027, 3614, 8815, 9199, 8594, 7288, 4257, 1540, 5718, 7171, 6643, 1404, 9979, 3214, 3728, 3692, 7743, 8938, 2099, 7938, 5896, 3184, 8348, 7788, 2994, 3795, 8801, 6164, 5859, 4112, 4590, 8291, 3325, 4355, 9273, 6036, 8519, 6160, 5136, 3290, 3300, 2569, 7327, 9405, 5918, 2959, 9885, 7556, 2105, 9741, 8795, 4286, 3189, 9433, 1472, 1234, 3287, 8207]
phone_numbers = (649835291, 429234781, 111708152, 720862287, 819584592, 688341035, 235295264, 437707384, 248130737, 290786034, 629273635, 297147874, 748222888, 489733621, 863600655, 299509716, 580775976, 848231022, 625383593, 963313690, 559992331, 995556010, 942244693, 523261077, 542032815, 867429240, 650887866, 404589640, 847553730, 336072212, 147561190, 225339440, 210151527, 948097120, 799046585, 125059706, 235200728, 876414007, 967206935, 498725207, 271463643, 995508868, 425554791, 710842471, 105684479, 235264994, 432955632, 296244247, 211174463, 867320234, 193320534, 853769290, 925492130, 947741757, 930984339, 605223195, 889844894, 399309818, 163810660, 740378816, 567638560, 357312757, 926655330, 360141101, 660321273, 951776633, 615728252, 421243167, 623865940, 539377545, 278093894, 297851155, 831604853, 110602333, 346137970, 483441364, 620750859, 725557649, 631229221, 145503568, 391644403, 332231105, 107581838, 625292700, 964072013, 325076663, 870607260, 561083160, 219145758, 563584994, 626099644, 795781817, 931564042, 145034025, 227787496, 199183798, 979593340, 393685652, 127410457, 571119747, 616846107, 547160043, 504114372, 378862439, 763967190, 942429191, 613117865, 133596923, 588102848, 715000228, 588498559, 793995493, 822511400, 244396653, 728957944, 138341525, 330217748, 361263080, 696660695, 859632147, 717695185, 952408171, 610847329, 552848292, 837541550, 751353785, 501738502, 534967785, 937240598, 657931803, 504506377, 124412817, 493876972, 372223320, 317074885, 377829300, 900769868, 461417294, 320688637, 124281159, 756800522, 983934166, 956304745, 239195718, 949124482, 186070724, 993803730, 935068479, 488746392, 414369380, 468317484, 744347447, 342291671, 108561211, 161606719, 278350491, 238033069, 775787246, 732922282, 809924287, 416028777, 367733788, 532265426, 923359877, 921480364, 163703061, 628686006, 306888516, 570306669, 627312021, 421132825, 514901411, 326921387, 712284621, 409909863, 661963517, 403492106, 811998958, 192642034, 263148435, 769499758, 711097733, 739350122, 805129315, 535589078, 492395431, 756211072, 940330578, 181799000, 334659454, 995842338, 547056594, 751905714, 662803138, 203552713, 182672892, 999739839, 239940574, 276677369, 823113714)

new_list = ids
for i in range(0, 100):
    new_list.append(random.choice(ids))

# print(len(new_list))

for id, phone_number in zip(ids, phone_numbers):
    print(f'(\'NV{id}\', \'0{phone_number}\'),')
    
for phone_number in phone_numbers[170:]:
    id = random.choice(ids)
    print(f'(\'NV{id}\', \'0{phone_number}\'),')