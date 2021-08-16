---------------------------------------------------------------------------
-- File name   : sin_rom.vhd
--
-- Project     : cushychicken/dds-engine
--
-- Description : ROM containing a quarter of a sine wave (0 < n < (pi/2))
--
-- Author(s)   : Nash Reilly (cushychicken@gmail.com)
--
-- Date        : August 13, 2021
--
-- Note(s)     : Sine coefficients generated by a helper script
--
----------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.std_logic_arith.all;
  use ieee.numeric_std.all;

entity sin_rom is
  port (
    clock : in    std_logic;
    addr  : in    std_logic_vector(13 downto 0);
    data  : out   std_logic_vector(11 downto 0)
  );
end entity sin_rom;

architecture sin_rom_arch of sin_rom is

  -- Signals and constants here

  type rom_type is array (0 to 1023) of std_logic_vector(11 downto 0);

  constant rom : rom_type :=
  (
    -- Everything between these two comments is generated by Python
    0 => 0,
    1 => 1,
    2 => 3,
    3 => 4,
    4 => 6,
    5 => 7,
    6 => 9,
    7 => 10,
    8 => 12,
    9 => 14,
    10 => 15,
    11 => 17,
    12 => 18,
    13 => 20,
    14 => 21,
    15 => 23,
    16 => 25,
    17 => 26,
    18 => 28,
    19 => 29,
    20 => 31,
    21 => 32,
    22 => 34,
    23 => 36,
    24 => 37,
    25 => 39,
    26 => 40,
    27 => 42,
    28 => 43,
    29 => 45,
    30 => 47,
    31 => 48,
    32 => 50,
    33 => 51,
    34 => 53,
    35 => 54,
    36 => 56,
    37 => 58,
    38 => 59,
    39 => 61,
    40 => 62,
    41 => 64,
    42 => 65,
    43 => 67,
    44 => 69,
    45 => 70,
    46 => 72,
    47 => 73,
    48 => 75,
    49 => 76,
    50 => 78,
    51 => 80,
    52 => 81,
    53 => 83,
    54 => 84,
    55 => 86,
    56 => 87,
    57 => 89,
    58 => 90,
    59 => 92,
    60 => 94,
    61 => 95,
    62 => 97,
    63 => 98,
    64 => 100,
    65 => 101,
    66 => 103,
    67 => 105,
    68 => 106,
    69 => 108,
    70 => 109,
    71 => 111,
    72 => 112,
    73 => 114,
    74 => 115,
    75 => 117,
    76 => 119,
    77 => 120,
    78 => 122,
    79 => 123,
    80 => 125,
    81 => 126,
    82 => 128,
    83 => 130,
    84 => 131,
    85 => 133,
    86 => 134,
    87 => 136,
    88 => 137,
    89 => 139,
    90 => 140,
    91 => 142,
    92 => 144,
    93 => 145,
    94 => 147,
    95 => 148,
    96 => 150,
    97 => 151,
    98 => 153,
    99 => 154,
    100 => 156,
    101 => 158,
    102 => 159,
    103 => 161,
    104 => 162,
    105 => 164,
    106 => 165,
    107 => 167,
    108 => 168,
    109 => 170,
    110 => 171,
    111 => 173,
    112 => 175,
    113 => 176,
    114 => 178,
    115 => 179,
    116 => 181,
    117 => 182,
    118 => 184,
    119 => 185,
    120 => 187,
    121 => 188,
    122 => 190,
    123 => 192,
    124 => 193,
    125 => 195,
    126 => 196,
    127 => 198,
    128 => 199,
    129 => 201,
    130 => 202,
    131 => 204,
    132 => 205,
    133 => 207,
    134 => 209,
    135 => 210,
    136 => 212,
    137 => 213,
    138 => 215,
    139 => 216,
    140 => 218,
    141 => 219,
    142 => 221,
    143 => 222,
    144 => 224,
    145 => 225,
    146 => 227,
    147 => 228,
    148 => 230,
    149 => 232,
    150 => 233,
    151 => 235,
    152 => 236,
    153 => 238,
    154 => 239,
    155 => 241,
    156 => 242,
    157 => 244,
    158 => 245,
    159 => 247,
    160 => 248,
    161 => 250,
    162 => 251,
    163 => 253,
    164 => 254,
    165 => 256,
    166 => 257,
    167 => 259,
    168 => 260,
    169 => 262,
    170 => 264,
    171 => 265,
    172 => 267,
    173 => 268,
    174 => 270,
    175 => 271,
    176 => 273,
    177 => 274,
    178 => 276,
    179 => 277,
    180 => 279,
    181 => 280,
    182 => 282,
    183 => 283,
    184 => 285,
    185 => 286,
    186 => 288,
    187 => 289,
    188 => 291,
    189 => 292,
    190 => 294,
    191 => 295,
    192 => 297,
    193 => 298,
    194 => 300,
    195 => 301,
    196 => 303,
    197 => 304,
    198 => 306,
    199 => 307,
    200 => 309,
    201 => 310,
    202 => 312,
    203 => 313,
    204 => 315,
    205 => 316,
    206 => 318,
    207 => 319,
    208 => 321,
    209 => 322,
    210 => 324,
    211 => 325,
    212 => 327,
    213 => 328,
    214 => 330,
    215 => 331,
    216 => 333,
    217 => 334,
    218 => 336,
    219 => 337,
    220 => 339,
    221 => 340,
    222 => 342,
    223 => 343,
    224 => 344,
    225 => 346,
    226 => 347,
    227 => 349,
    228 => 350,
    229 => 352,
    230 => 353,
    231 => 355,
    232 => 356,
    233 => 358,
    234 => 359,
    235 => 361,
    236 => 362,
    237 => 364,
    238 => 365,
    239 => 367,
    240 => 368,
    241 => 369,
    242 => 371,
    243 => 372,
    244 => 374,
    245 => 375,
    246 => 377,
    247 => 378,
    248 => 380,
    249 => 381,
    250 => 383,
    251 => 384,
    252 => 386,
    253 => 387,
    254 => 388,
    255 => 390,
    256 => 391,
    257 => 393,
    258 => 394,
    259 => 396,
    260 => 397,
    261 => 399,
    262 => 400,
    263 => 402,
    264 => 403,
    265 => 404,
    266 => 406,
    267 => 407,
    268 => 409,
    269 => 410,
    270 => 412,
    271 => 413,
    272 => 414,
    273 => 416,
    274 => 417,
    275 => 419,
    276 => 420,
    277 => 422,
    278 => 423,
    279 => 424,
    280 => 426,
    281 => 427,
    282 => 429,
    283 => 430,
    284 => 432,
    285 => 433,
    286 => 434,
    287 => 436,
    288 => 437,
    289 => 439,
    290 => 440,
    291 => 442,
    292 => 443,
    293 => 444,
    294 => 446,
    295 => 447,
    296 => 449,
    297 => 450,
    298 => 451,
    299 => 453,
    300 => 454,
    301 => 456,
    302 => 457,
    303 => 458,
    304 => 460,
    305 => 461,
    306 => 463,
    307 => 464,
    308 => 466,
    309 => 467,
    310 => 468,
    311 => 470,
    312 => 471,
    313 => 472,
    314 => 474,
    315 => 475,
    316 => 477,
    317 => 478,
    318 => 479,
    319 => 481,
    320 => 482,
    321 => 484,
    322 => 485,
    323 => 486,
    324 => 488,
    325 => 489,
    326 => 491,
    327 => 492,
    328 => 493,
    329 => 495,
    330 => 496,
    331 => 497,
    332 => 499,
    333 => 500,
    334 => 501,
    335 => 503,
    336 => 504,
    337 => 506,
    338 => 507,
    339 => 508,
    340 => 510,
    341 => 511,
    342 => 512,
    343 => 514,
    344 => 515,
    345 => 516,
    346 => 518,
    347 => 519,
    348 => 521,
    349 => 522,
    350 => 523,
    351 => 525,
    352 => 526,
    353 => 527,
    354 => 529,
    355 => 530,
    356 => 531,
    357 => 533,
    358 => 534,
    359 => 535,
    360 => 537,
    361 => 538,
    362 => 539,
    363 => 541,
    364 => 542,
    365 => 543,
    366 => 545,
    367 => 546,
    368 => 547,
    369 => 549,
    370 => 550,
    371 => 551,
    372 => 553,
    373 => 554,
    374 => 555,
    375 => 557,
    376 => 558,
    377 => 559,
    378 => 561,
    379 => 562,
    380 => 563,
    381 => 564,
    382 => 566,
    383 => 567,
    384 => 568,
    385 => 570,
    386 => 571,
    387 => 572,
    388 => 574,
    389 => 575,
    390 => 576,
    391 => 578,
    392 => 579,
    393 => 580,
    394 => 581,
    395 => 583,
    396 => 584,
    397 => 585,
    398 => 587,
    399 => 588,
    400 => 589,
    401 => 590,
    402 => 592,
    403 => 593,
    404 => 594,
    405 => 596,
    406 => 597,
    407 => 598,
    408 => 599,
    409 => 601,
    410 => 602,
    411 => 603,
    412 => 604,
    413 => 606,
    414 => 607,
    415 => 608,
    416 => 609,
    417 => 611,
    418 => 612,
    419 => 613,
    420 => 615,
    421 => 616,
    422 => 617,
    423 => 618,
    424 => 620,
    425 => 621,
    426 => 622,
    427 => 623,
    428 => 625,
    429 => 626,
    430 => 627,
    431 => 628,
    432 => 629,
    433 => 631,
    434 => 632,
    435 => 633,
    436 => 634,
    437 => 636,
    438 => 637,
    439 => 638,
    440 => 639,
    441 => 641,
    442 => 642,
    443 => 643,
    444 => 644,
    445 => 645,
    446 => 647,
    447 => 648,
    448 => 649,
    449 => 650,
    450 => 652,
    451 => 653,
    452 => 654,
    453 => 655,
    454 => 656,
    455 => 658,
    456 => 659,
    457 => 660,
    458 => 661,
    459 => 662,
    460 => 664,
    461 => 665,
    462 => 666,
    463 => 667,
    464 => 668,
    465 => 670,
    466 => 671,
    467 => 672,
    468 => 673,
    469 => 674,
    470 => 675,
    471 => 677,
    472 => 678,
    473 => 679,
    474 => 680,
    475 => 681,
    476 => 683,
    477 => 684,
    478 => 685,
    479 => 686,
    480 => 687,
    481 => 688,
    482 => 690,
    483 => 691,
    484 => 692,
    485 => 693,
    486 => 694,
    487 => 695,
    488 => 696,
    489 => 698,
    490 => 699,
    491 => 700,
    492 => 701,
    493 => 702,
    494 => 703,
    495 => 704,
    496 => 706,
    497 => 707,
    498 => 708,
    499 => 709,
    500 => 710,
    501 => 711,
    502 => 712,
    503 => 714,
    504 => 715,
    505 => 716,
    506 => 717,
    507 => 718,
    508 => 719,
    509 => 720,
    510 => 721,
    511 => 722,
    512 => 724,
    513 => 725,
    514 => 726,
    515 => 727,
    516 => 728,
    517 => 729,
    518 => 730,
    519 => 731,
    520 => 732,
    521 => 734,
    522 => 735,
    523 => 736,
    524 => 737,
    525 => 738,
    526 => 739,
    527 => 740,
    528 => 741,
    529 => 742,
    530 => 743,
    531 => 744,
    532 => 745,
    533 => 747,
    534 => 748,
    535 => 749,
    536 => 750,
    537 => 751,
    538 => 752,
    539 => 753,
    540 => 754,
    541 => 755,
    542 => 756,
    543 => 757,
    544 => 758,
    545 => 759,
    546 => 760,
    547 => 761,
    548 => 762,
    549 => 763,
    550 => 765,
    551 => 766,
    552 => 767,
    553 => 768,
    554 => 769,
    555 => 770,
    556 => 771,
    557 => 772,
    558 => 773,
    559 => 774,
    560 => 775,
    561 => 776,
    562 => 777,
    563 => 778,
    564 => 779,
    565 => 780,
    566 => 781,
    567 => 782,
    568 => 783,
    569 => 784,
    570 => 785,
    571 => 786,
    572 => 787,
    573 => 788,
    574 => 789,
    575 => 790,
    576 => 791,
    577 => 792,
    578 => 793,
    579 => 794,
    580 => 795,
    581 => 796,
    582 => 797,
    583 => 798,
    584 => 799,
    585 => 800,
    586 => 801,
    587 => 802,
    588 => 803,
    589 => 804,
    590 => 805,
    591 => 806,
    592 => 807,
    593 => 808,
    594 => 809,
    595 => 810,
    596 => 811,
    597 => 812,
    598 => 813,
    599 => 813,
    600 => 814,
    601 => 815,
    602 => 816,
    603 => 817,
    604 => 818,
    605 => 819,
    606 => 820,
    607 => 821,
    608 => 822,
    609 => 823,
    610 => 824,
    611 => 825,
    612 => 826,
    613 => 827,
    614 => 828,
    615 => 828,
    616 => 829,
    617 => 830,
    618 => 831,
    619 => 832,
    620 => 833,
    621 => 834,
    622 => 835,
    623 => 836,
    624 => 837,
    625 => 838,
    626 => 839,
    627 => 839,
    628 => 840,
    629 => 841,
    630 => 842,
    631 => 843,
    632 => 844,
    633 => 845,
    634 => 846,
    635 => 847,
    636 => 847,
    637 => 848,
    638 => 849,
    639 => 850,
    640 => 851,
    641 => 852,
    642 => 853,
    643 => 854,
    644 => 854,
    645 => 855,
    646 => 856,
    647 => 857,
    648 => 858,
    649 => 859,
    650 => 860,
    651 => 860,
    652 => 861,
    653 => 862,
    654 => 863,
    655 => 864,
    656 => 865,
    657 => 865,
    658 => 866,
    659 => 867,
    660 => 868,
    661 => 869,
    662 => 870,
    663 => 870,
    664 => 871,
    665 => 872,
    666 => 873,
    667 => 874,
    668 => 875,
    669 => 875,
    670 => 876,
    671 => 877,
    672 => 878,
    673 => 879,
    674 => 879,
    675 => 880,
    676 => 881,
    677 => 882,
    678 => 883,
    679 => 883,
    680 => 884,
    681 => 885,
    682 => 886,
    683 => 887,
    684 => 887,
    685 => 888,
    686 => 889,
    687 => 890,
    688 => 890,
    689 => 891,
    690 => 892,
    691 => 893,
    692 => 894,
    693 => 894,
    694 => 895,
    695 => 896,
    696 => 897,
    697 => 897,
    698 => 898,
    699 => 899,
    700 => 900,
    701 => 900,
    702 => 901,
    703 => 902,
    704 => 903,
    705 => 903,
    706 => 904,
    707 => 905,
    708 => 906,
    709 => 906,
    710 => 907,
    711 => 908,
    712 => 908,
    713 => 909,
    714 => 910,
    715 => 911,
    716 => 911,
    717 => 912,
    718 => 913,
    719 => 913,
    720 => 914,
    721 => 915,
    722 => 916,
    723 => 916,
    724 => 917,
    725 => 918,
    726 => 918,
    727 => 919,
    728 => 920,
    729 => 920,
    730 => 921,
    731 => 922,
    732 => 922,
    733 => 923,
    734 => 924,
    735 => 925,
    736 => 925,
    737 => 926,
    738 => 927,
    739 => 927,
    740 => 928,
    741 => 929,
    742 => 929,
    743 => 930,
    744 => 930,
    745 => 931,
    746 => 932,
    747 => 932,
    748 => 933,
    749 => 934,
    750 => 934,
    751 => 935,
    752 => 936,
    753 => 936,
    754 => 937,
    755 => 938,
    756 => 938,
    757 => 939,
    758 => 939,
    759 => 940,
    760 => 941,
    761 => 941,
    762 => 942,
    763 => 943,
    764 => 943,
    765 => 944,
    766 => 944,
    767 => 945,
    768 => 946,
    769 => 946,
    770 => 947,
    771 => 947,
    772 => 948,
    773 => 949,
    774 => 949,
    775 => 950,
    776 => 950,
    777 => 951,
    778 => 951,
    779 => 952,
    780 => 953,
    781 => 953,
    782 => 954,
    783 => 954,
    784 => 955,
    785 => 955,
    786 => 956,
    787 => 957,
    788 => 957,
    789 => 958,
    790 => 958,
    791 => 959,
    792 => 959,
    793 => 960,
    794 => 960,
    795 => 961,
    796 => 962,
    797 => 962,
    798 => 963,
    799 => 963,
    800 => 964,
    801 => 964,
    802 => 965,
    803 => 965,
    804 => 966,
    805 => 966,
    806 => 967,
    807 => 967,
    808 => 968,
    809 => 968,
    810 => 969,
    811 => 969,
    812 => 970,
    813 => 970,
    814 => 971,
    815 => 971,
    816 => 972,
    817 => 972,
    818 => 973,
    819 => 973,
    820 => 974,
    821 => 974,
    822 => 975,
    823 => 975,
    824 => 976,
    825 => 976,
    826 => 977,
    827 => 977,
    828 => 978,
    829 => 978,
    830 => 978,
    831 => 979,
    832 => 979,
    833 => 980,
    834 => 980,
    835 => 981,
    836 => 981,
    837 => 982,
    838 => 982,
    839 => 983,
    840 => 983,
    841 => 983,
    842 => 984,
    843 => 984,
    844 => 985,
    845 => 985,
    846 => 986,
    847 => 986,
    848 => 986,
    849 => 987,
    850 => 987,
    851 => 988,
    852 => 988,
    853 => 988,
    854 => 989,
    855 => 989,
    856 => 990,
    857 => 990,
    858 => 990,
    859 => 991,
    860 => 991,
    861 => 992,
    862 => 992,
    863 => 992,
    864 => 993,
    865 => 993,
    866 => 994,
    867 => 994,
    868 => 994,
    869 => 995,
    870 => 995,
    871 => 995,
    872 => 996,
    873 => 996,
    874 => 997,
    875 => 997,
    876 => 997,
    877 => 998,
    878 => 998,
    879 => 998,
    880 => 999,
    881 => 999,
    882 => 999,
    883 => 1000,
    884 => 1000,
    885 => 1000,
    886 => 1001,
    887 => 1001,
    888 => 1001,
    889 => 1002,
    890 => 1002,
    891 => 1002,
    892 => 1003,
    893 => 1003,
    894 => 1003,
    895 => 1004,
    896 => 1004,
    897 => 1004,
    898 => 1004,
    899 => 1005,
    900 => 1005,
    901 => 1005,
    902 => 1006,
    903 => 1006,
    904 => 1006,
    905 => 1006,
    906 => 1007,
    907 => 1007,
    908 => 1007,
    909 => 1008,
    910 => 1008,
    911 => 1008,
    912 => 1008,
    913 => 1009,
    914 => 1009,
    915 => 1009,
    916 => 1009,
    917 => 1010,
    918 => 1010,
    919 => 1010,
    920 => 1010,
    921 => 1011,
    922 => 1011,
    923 => 1011,
    924 => 1011,
    925 => 1012,
    926 => 1012,
    927 => 1012,
    928 => 1012,
    929 => 1013,
    930 => 1013,
    931 => 1013,
    932 => 1013,
    933 => 1014,
    934 => 1014,
    935 => 1014,
    936 => 1014,
    937 => 1014,
    938 => 1015,
    939 => 1015,
    940 => 1015,
    941 => 1015,
    942 => 1015,
    943 => 1016,
    944 => 1016,
    945 => 1016,
    946 => 1016,
    947 => 1016,
    948 => 1017,
    949 => 1017,
    950 => 1017,
    951 => 1017,
    952 => 1017,
    953 => 1017,
    954 => 1018,
    955 => 1018,
    956 => 1018,
    957 => 1018,
    958 => 1018,
    959 => 1018,
    960 => 1019,
    961 => 1019,
    962 => 1019,
    963 => 1019,
    964 => 1019,
    965 => 1019,
    966 => 1019,
    967 => 1020,
    968 => 1020,
    969 => 1020,
    970 => 1020,
    971 => 1020,
    972 => 1020,
    973 => 1020,
    974 => 1020,
    975 => 1021,
    976 => 1021,
    977 => 1021,
    978 => 1021,
    979 => 1021,
    980 => 1021,
    981 => 1021,
    982 => 1021,
    983 => 1021,
    984 => 1022,
    985 => 1022,
    986 => 1022,
    987 => 1022,
    988 => 1022,
    989 => 1022,
    990 => 1022,
    991 => 1022,
    992 => 1022,
    993 => 1022,
    994 => 1022,
    995 => 1022,
    996 => 1023,
    997 => 1023,
    998 => 1023,
    999 => 1023,
    1000 => 1023,
    1001 => 1023,
    1002 => 1023,
    1003 => 1023,
    1004 => 1023,
    1005 => 1023,
    1006 => 1023,
    1007 => 1023,
    1008 => 1023,
    1009 => 1023,
    1010 => 1023,
    1011 => 1023,
    1012 => 1023,
    1013 => 1023,
    1014 => 1023,
    1015 => 1023,
    1016 => 1023,
    1017 => 1023,
    1018 => 1023,
    1019 => 1023,
    1020 => 1023,
    1021 => 1023,
    1022 => 1023,
    1023 => 1023
    -- End Python generated section
  );

begin

  memory : process (clock) is
  begin

    if (clock'event and clock='1') then
      if (addr >= 0 and addr <= 1023) then
		if (addr(13 downto 12) = "00") then
			data <= rom(conv_integer(addr));
		elsif (addr(13 downto 12) = "01") then
			data <= rom((1024 - conv_integer(addr)));
		elsif (addr(13 downto 12) = "10") then
			data <= -rom(conv_integer(addr));
		elsif (addr(13 downto 12) = "11") then
			data <= -rom((1024 - conv_integer(addr)));
		end if;
      end if;
    end if;

  end process memory;

end architecture sin_rom_arch;
