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

entity sin_rom_10bits_1024words is
  port (
    clock : in    std_logic;
    addr  : in    std_logic_vector(13 downto 0);
    data  : out   std_logic_vector(11 downto 0)
  );
end entity sin_rom_10bits_1024words;

architecture sin_rom_arch of sin_rom_10bits_1024words is

  -- Signals and constants here

  type rom_type is array (0 to 1023) of std_logic_vector(11 downto 0);

  constant rom : rom_type :=
  (
    -- Everything between these two comments is generated by Python
    0 => "000000000000",
    1 => "000000000001",
    2 => "000000000011",
    3 => "000000000100",
    4 => "000000000110",
    5 => "000000000111",
    6 => "000000001001",
    7 => "000000001010",
    8 => "000000001100",
    9 => "000000001110",
    10 => "000000001111",
    11 => "000000010001",
    12 => "000000010010",
    13 => "000000010100",
    14 => "000000010101",
    15 => "000000010111",
    16 => "000000011001",
    17 => "000000011010",
    18 => "000000011100",
    19 => "000000011101",
    20 => "000000011111",
    21 => "000000100000",
    22 => "000000100010",
    23 => "000000100100",
    24 => "000000100101",
    25 => "000000100111",
    26 => "000000101000",
    27 => "000000101010",
    28 => "000000101011",
    29 => "000000101101",
    30 => "000000101111",
    31 => "000000110000",
    32 => "000000110010",
    33 => "000000110011",
    34 => "000000110101",
    35 => "000000110110",
    36 => "000000111000",
    37 => "000000111010",
    38 => "000000111011",
    39 => "000000111101",
    40 => "000000111110",
    41 => "000001000000",
    42 => "000001000001",
    43 => "000001000011",
    44 => "000001000101",
    45 => "000001000110",
    46 => "000001001000",
    47 => "000001001001",
    48 => "000001001011",
    49 => "000001001100",
    50 => "000001001110",
    51 => "000001010000",
    52 => "000001010001",
    53 => "000001010011",
    54 => "000001010100",
    55 => "000001010110",
    56 => "000001010111",
    57 => "000001011001",
    58 => "000001011010",
    59 => "000001011100",
    60 => "000001011110",
    61 => "000001011111",
    62 => "000001100001",
    63 => "000001100010",
    64 => "000001100100",
    65 => "000001100101",
    66 => "000001100111",
    67 => "000001101001",
    68 => "000001101010",
    69 => "000001101100",
    70 => "000001101101",
    71 => "000001101111",
    72 => "000001110000",
    73 => "000001110010",
    74 => "000001110011",
    75 => "000001110101",
    76 => "000001110111",
    77 => "000001111000",
    78 => "000001111010",
    79 => "000001111011",
    80 => "000001111101",
    81 => "000001111110",
    82 => "000010000000",
    83 => "000010000010",
    84 => "000010000011",
    85 => "000010000101",
    86 => "000010000110",
    87 => "000010001000",
    88 => "000010001001",
    89 => "000010001011",
    90 => "000010001100",
    91 => "000010001110",
    92 => "000010010000",
    93 => "000010010001",
    94 => "000010010011",
    95 => "000010010100",
    96 => "000010010110",
    97 => "000010010111",
    98 => "000010011001",
    99 => "000010011010",
    100 => "000010011100",
    101 => "000010011110",
    102 => "000010011111",
    103 => "000010100001",
    104 => "000010100010",
    105 => "000010100100",
    106 => "000010100101",
    107 => "000010100111",
    108 => "000010101000",
    109 => "000010101010",
    110 => "000010101011",
    111 => "000010101101",
    112 => "000010101111",
    113 => "000010110000",
    114 => "000010110010",
    115 => "000010110011",
    116 => "000010110101",
    117 => "000010110110",
    118 => "000010111000",
    119 => "000010111001",
    120 => "000010111011",
    121 => "000010111100",
    122 => "000010111110",
    123 => "000011000000",
    124 => "000011000001",
    125 => "000011000011",
    126 => "000011000100",
    127 => "000011000110",
    128 => "000011000111",
    129 => "000011001001",
    130 => "000011001010",
    131 => "000011001100",
    132 => "000011001101",
    133 => "000011001111",
    134 => "000011010001",
    135 => "000011010010",
    136 => "000011010100",
    137 => "000011010101",
    138 => "000011010111",
    139 => "000011011000",
    140 => "000011011010",
    141 => "000011011011",
    142 => "000011011101",
    143 => "000011011110",
    144 => "000011100000",
    145 => "000011100001",
    146 => "000011100011",
    147 => "000011100100",
    148 => "000011100110",
    149 => "000011101000",
    150 => "000011101001",
    151 => "000011101011",
    152 => "000011101100",
    153 => "000011101110",
    154 => "000011101111",
    155 => "000011110001",
    156 => "000011110010",
    157 => "000011110100",
    158 => "000011110101",
    159 => "000011110111",
    160 => "000011111000",
    161 => "000011111010",
    162 => "000011111011",
    163 => "000011111101",
    164 => "000011111110",
    165 => "000100000000",
    166 => "000100000001",
    167 => "000100000011",
    168 => "000100000100",
    169 => "000100000110",
    170 => "000100001000",
    171 => "000100001001",
    172 => "000100001011",
    173 => "000100001100",
    174 => "000100001110",
    175 => "000100001111",
    176 => "000100010001",
    177 => "000100010010",
    178 => "000100010100",
    179 => "000100010101",
    180 => "000100010111",
    181 => "000100011000",
    182 => "000100011010",
    183 => "000100011011",
    184 => "000100011101",
    185 => "000100011110",
    186 => "000100100000",
    187 => "000100100001",
    188 => "000100100011",
    189 => "000100100100",
    190 => "000100100110",
    191 => "000100100111",
    192 => "000100101001",
    193 => "000100101010",
    194 => "000100101100",
    195 => "000100101101",
    196 => "000100101111",
    197 => "000100110000",
    198 => "000100110010",
    199 => "000100110011",
    200 => "000100110101",
    201 => "000100110110",
    202 => "000100111000",
    203 => "000100111001",
    204 => "000100111011",
    205 => "000100111100",
    206 => "000100111110",
    207 => "000100111111",
    208 => "000101000001",
    209 => "000101000010",
    210 => "000101000100",
    211 => "000101000101",
    212 => "000101000111",
    213 => "000101001000",
    214 => "000101001010",
    215 => "000101001011",
    216 => "000101001101",
    217 => "000101001110",
    218 => "000101010000",
    219 => "000101010001",
    220 => "000101010011",
    221 => "000101010100",
    222 => "000101010110",
    223 => "000101010111",
    224 => "000101011000",
    225 => "000101011010",
    226 => "000101011011",
    227 => "000101011101",
    228 => "000101011110",
    229 => "000101100000",
    230 => "000101100001",
    231 => "000101100011",
    232 => "000101100100",
    233 => "000101100110",
    234 => "000101100111",
    235 => "000101101001",
    236 => "000101101010",
    237 => "000101101100",
    238 => "000101101101",
    239 => "000101101111",
    240 => "000101110000",
    241 => "000101110001",
    242 => "000101110011",
    243 => "000101110100",
    244 => "000101110110",
    245 => "000101110111",
    246 => "000101111001",
    247 => "000101111010",
    248 => "000101111100",
    249 => "000101111101",
    250 => "000101111111",
    251 => "000110000000",
    252 => "000110000010",
    253 => "000110000011",
    254 => "000110000100",
    255 => "000110000110",
    256 => "000110000111",
    257 => "000110001001",
    258 => "000110001010",
    259 => "000110001100",
    260 => "000110001101",
    261 => "000110001111",
    262 => "000110010000",
    263 => "000110010010",
    264 => "000110010011",
    265 => "000110010100",
    266 => "000110010110",
    267 => "000110010111",
    268 => "000110011001",
    269 => "000110011010",
    270 => "000110011100",
    271 => "000110011101",
    272 => "000110011110",
    273 => "000110100000",
    274 => "000110100001",
    275 => "000110100011",
    276 => "000110100100",
    277 => "000110100110",
    278 => "000110100111",
    279 => "000110101000",
    280 => "000110101010",
    281 => "000110101011",
    282 => "000110101101",
    283 => "000110101110",
    284 => "000110110000",
    285 => "000110110001",
    286 => "000110110010",
    287 => "000110110100",
    288 => "000110110101",
    289 => "000110110111",
    290 => "000110111000",
    291 => "000110111010",
    292 => "000110111011",
    293 => "000110111100",
    294 => "000110111110",
    295 => "000110111111",
    296 => "000111000001",
    297 => "000111000010",
    298 => "000111000011",
    299 => "000111000101",
    300 => "000111000110",
    301 => "000111001000",
    302 => "000111001001",
    303 => "000111001010",
    304 => "000111001100",
    305 => "000111001101",
    306 => "000111001111",
    307 => "000111010000",
    308 => "000111010010",
    309 => "000111010011",
    310 => "000111010100",
    311 => "000111010110",
    312 => "000111010111",
    313 => "000111011000",
    314 => "000111011010",
    315 => "000111011011",
    316 => "000111011101",
    317 => "000111011110",
    318 => "000111011111",
    319 => "000111100001",
    320 => "000111100010",
    321 => "000111100100",
    322 => "000111100101",
    323 => "000111100110",
    324 => "000111101000",
    325 => "000111101001",
    326 => "000111101011",
    327 => "000111101100",
    328 => "000111101101",
    329 => "000111101111",
    330 => "000111110000",
    331 => "000111110001",
    332 => "000111110011",
    333 => "000111110100",
    334 => "000111110101",
    335 => "000111110111",
    336 => "000111111000",
    337 => "000111111010",
    338 => "000111111011",
    339 => "000111111100",
    340 => "000111111110",
    341 => "000111111111",
    342 => "001000000000",
    343 => "001000000010",
    344 => "001000000011",
    345 => "001000000100",
    346 => "001000000110",
    347 => "001000000111",
    348 => "001000001001",
    349 => "001000001010",
    350 => "001000001011",
    351 => "001000001101",
    352 => "001000001110",
    353 => "001000001111",
    354 => "001000010001",
    355 => "001000010010",
    356 => "001000010011",
    357 => "001000010101",
    358 => "001000010110",
    359 => "001000010111",
    360 => "001000011001",
    361 => "001000011010",
    362 => "001000011011",
    363 => "001000011101",
    364 => "001000011110",
    365 => "001000011111",
    366 => "001000100001",
    367 => "001000100010",
    368 => "001000100011",
    369 => "001000100101",
    370 => "001000100110",
    371 => "001000100111",
    372 => "001000101001",
    373 => "001000101010",
    374 => "001000101011",
    375 => "001000101101",
    376 => "001000101110",
    377 => "001000101111",
    378 => "001000110001",
    379 => "001000110010",
    380 => "001000110011",
    381 => "001000110100",
    382 => "001000110110",
    383 => "001000110111",
    384 => "001000111000",
    385 => "001000111010",
    386 => "001000111011",
    387 => "001000111100",
    388 => "001000111110",
    389 => "001000111111",
    390 => "001001000000",
    391 => "001001000010",
    392 => "001001000011",
    393 => "001001000100",
    394 => "001001000101",
    395 => "001001000111",
    396 => "001001001000",
    397 => "001001001001",
    398 => "001001001011",
    399 => "001001001100",
    400 => "001001001101",
    401 => "001001001110",
    402 => "001001010000",
    403 => "001001010001",
    404 => "001001010010",
    405 => "001001010100",
    406 => "001001010101",
    407 => "001001010110",
    408 => "001001010111",
    409 => "001001011001",
    410 => "001001011010",
    411 => "001001011011",
    412 => "001001011100",
    413 => "001001011110",
    414 => "001001011111",
    415 => "001001100000",
    416 => "001001100001",
    417 => "001001100011",
    418 => "001001100100",
    419 => "001001100101",
    420 => "001001100111",
    421 => "001001101000",
    422 => "001001101001",
    423 => "001001101010",
    424 => "001001101100",
    425 => "001001101101",
    426 => "001001101110",
    427 => "001001101111",
    428 => "001001110001",
    429 => "001001110010",
    430 => "001001110011",
    431 => "001001110100",
    432 => "001001110101",
    433 => "001001110111",
    434 => "001001111000",
    435 => "001001111001",
    436 => "001001111010",
    437 => "001001111100",
    438 => "001001111101",
    439 => "001001111110",
    440 => "001001111111",
    441 => "001010000001",
    442 => "001010000010",
    443 => "001010000011",
    444 => "001010000100",
    445 => "001010000101",
    446 => "001010000111",
    447 => "001010001000",
    448 => "001010001001",
    449 => "001010001010",
    450 => "001010001100",
    451 => "001010001101",
    452 => "001010001110",
    453 => "001010001111",
    454 => "001010010000",
    455 => "001010010010",
    456 => "001010010011",
    457 => "001010010100",
    458 => "001010010101",
    459 => "001010010110",
    460 => "001010011000",
    461 => "001010011001",
    462 => "001010011010",
    463 => "001010011011",
    464 => "001010011100",
    465 => "001010011110",
    466 => "001010011111",
    467 => "001010100000",
    468 => "001010100001",
    469 => "001010100010",
    470 => "001010100011",
    471 => "001010100101",
    472 => "001010100110",
    473 => "001010100111",
    474 => "001010101000",
    475 => "001010101001",
    476 => "001010101011",
    477 => "001010101100",
    478 => "001010101101",
    479 => "001010101110",
    480 => "001010101111",
    481 => "001010110000",
    482 => "001010110010",
    483 => "001010110011",
    484 => "001010110100",
    485 => "001010110101",
    486 => "001010110110",
    487 => "001010110111",
    488 => "001010111000",
    489 => "001010111010",
    490 => "001010111011",
    491 => "001010111100",
    492 => "001010111101",
    493 => "001010111110",
    494 => "001010111111",
    495 => "001011000000",
    496 => "001011000010",
    497 => "001011000011",
    498 => "001011000100",
    499 => "001011000101",
    500 => "001011000110",
    501 => "001011000111",
    502 => "001011001000",
    503 => "001011001010",
    504 => "001011001011",
    505 => "001011001100",
    506 => "001011001101",
    507 => "001011001110",
    508 => "001011001111",
    509 => "001011010000",
    510 => "001011010001",
    511 => "001011010010",
    512 => "001011010100",
    513 => "001011010101",
    514 => "001011010110",
    515 => "001011010111",
    516 => "001011011000",
    517 => "001011011001",
    518 => "001011011010",
    519 => "001011011011",
    520 => "001011011100",
    521 => "001011011110",
    522 => "001011011111",
    523 => "001011100000",
    524 => "001011100001",
    525 => "001011100010",
    526 => "001011100011",
    527 => "001011100100",
    528 => "001011100101",
    529 => "001011100110",
    530 => "001011100111",
    531 => "001011101000",
    532 => "001011101001",
    533 => "001011101011",
    534 => "001011101100",
    535 => "001011101101",
    536 => "001011101110",
    537 => "001011101111",
    538 => "001011110000",
    539 => "001011110001",
    540 => "001011110010",
    541 => "001011110011",
    542 => "001011110100",
    543 => "001011110101",
    544 => "001011110110",
    545 => "001011110111",
    546 => "001011111000",
    547 => "001011111001",
    548 => "001011111010",
    549 => "001011111011",
    550 => "001011111101",
    551 => "001011111110",
    552 => "001011111111",
    553 => "001100000000",
    554 => "001100000001",
    555 => "001100000010",
    556 => "001100000011",
    557 => "001100000100",
    558 => "001100000101",
    559 => "001100000110",
    560 => "001100000111",
    561 => "001100001000",
    562 => "001100001001",
    563 => "001100001010",
    564 => "001100001011",
    565 => "001100001100",
    566 => "001100001101",
    567 => "001100001110",
    568 => "001100001111",
    569 => "001100010000",
    570 => "001100010001",
    571 => "001100010010",
    572 => "001100010011",
    573 => "001100010100",
    574 => "001100010101",
    575 => "001100010110",
    576 => "001100010111",
    577 => "001100011000",
    578 => "001100011001",
    579 => "001100011010",
    580 => "001100011011",
    581 => "001100011100",
    582 => "001100011101",
    583 => "001100011110",
    584 => "001100011111",
    585 => "001100100000",
    586 => "001100100001",
    587 => "001100100010",
    588 => "001100100011",
    589 => "001100100100",
    590 => "001100100101",
    591 => "001100100110",
    592 => "001100100111",
    593 => "001100101000",
    594 => "001100101001",
    595 => "001100101010",
    596 => "001100101011",
    597 => "001100101100",
    598 => "001100101101",
    599 => "001100101101",
    600 => "001100101110",
    601 => "001100101111",
    602 => "001100110000",
    603 => "001100110001",
    604 => "001100110010",
    605 => "001100110011",
    606 => "001100110100",
    607 => "001100110101",
    608 => "001100110110",
    609 => "001100110111",
    610 => "001100111000",
    611 => "001100111001",
    612 => "001100111010",
    613 => "001100111011",
    614 => "001100111100",
    615 => "001100111100",
    616 => "001100111101",
    617 => "001100111110",
    618 => "001100111111",
    619 => "001101000000",
    620 => "001101000001",
    621 => "001101000010",
    622 => "001101000011",
    623 => "001101000100",
    624 => "001101000101",
    625 => "001101000110",
    626 => "001101000111",
    627 => "001101000111",
    628 => "001101001000",
    629 => "001101001001",
    630 => "001101001010",
    631 => "001101001011",
    632 => "001101001100",
    633 => "001101001101",
    634 => "001101001110",
    635 => "001101001111",
    636 => "001101001111",
    637 => "001101010000",
    638 => "001101010001",
    639 => "001101010010",
    640 => "001101010011",
    641 => "001101010100",
    642 => "001101010101",
    643 => "001101010110",
    644 => "001101010110",
    645 => "001101010111",
    646 => "001101011000",
    647 => "001101011001",
    648 => "001101011010",
    649 => "001101011011",
    650 => "001101011100",
    651 => "001101011100",
    652 => "001101011101",
    653 => "001101011110",
    654 => "001101011111",
    655 => "001101100000",
    656 => "001101100001",
    657 => "001101100001",
    658 => "001101100010",
    659 => "001101100011",
    660 => "001101100100",
    661 => "001101100101",
    662 => "001101100110",
    663 => "001101100110",
    664 => "001101100111",
    665 => "001101101000",
    666 => "001101101001",
    667 => "001101101010",
    668 => "001101101011",
    669 => "001101101011",
    670 => "001101101100",
    671 => "001101101101",
    672 => "001101101110",
    673 => "001101101111",
    674 => "001101101111",
    675 => "001101110000",
    676 => "001101110001",
    677 => "001101110010",
    678 => "001101110011",
    679 => "001101110011",
    680 => "001101110100",
    681 => "001101110101",
    682 => "001101110110",
    683 => "001101110111",
    684 => "001101110111",
    685 => "001101111000",
    686 => "001101111001",
    687 => "001101111010",
    688 => "001101111010",
    689 => "001101111011",
    690 => "001101111100",
    691 => "001101111101",
    692 => "001101111110",
    693 => "001101111110",
    694 => "001101111111",
    695 => "001110000000",
    696 => "001110000001",
    697 => "001110000001",
    698 => "001110000010",
    699 => "001110000011",
    700 => "001110000100",
    701 => "001110000100",
    702 => "001110000101",
    703 => "001110000110",
    704 => "001110000111",
    705 => "001110000111",
    706 => "001110001000",
    707 => "001110001001",
    708 => "001110001010",
    709 => "001110001010",
    710 => "001110001011",
    711 => "001110001100",
    712 => "001110001100",
    713 => "001110001101",
    714 => "001110001110",
    715 => "001110001111",
    716 => "001110001111",
    717 => "001110010000",
    718 => "001110010001",
    719 => "001110010001",
    720 => "001110010010",
    721 => "001110010011",
    722 => "001110010100",
    723 => "001110010100",
    724 => "001110010101",
    725 => "001110010110",
    726 => "001110010110",
    727 => "001110010111",
    728 => "001110011000",
    729 => "001110011000",
    730 => "001110011001",
    731 => "001110011010",
    732 => "001110011010",
    733 => "001110011011",
    734 => "001110011100",
    735 => "001110011101",
    736 => "001110011101",
    737 => "001110011110",
    738 => "001110011111",
    739 => "001110011111",
    740 => "001110100000",
    741 => "001110100001",
    742 => "001110100001",
    743 => "001110100010",
    744 => "001110100010",
    745 => "001110100011",
    746 => "001110100100",
    747 => "001110100100",
    748 => "001110100101",
    749 => "001110100110",
    750 => "001110100110",
    751 => "001110100111",
    752 => "001110101000",
    753 => "001110101000",
    754 => "001110101001",
    755 => "001110101010",
    756 => "001110101010",
    757 => "001110101011",
    758 => "001110101011",
    759 => "001110101100",
    760 => "001110101101",
    761 => "001110101101",
    762 => "001110101110",
    763 => "001110101111",
    764 => "001110101111",
    765 => "001110110000",
    766 => "001110110000",
    767 => "001110110001",
    768 => "001110110010",
    769 => "001110110010",
    770 => "001110110011",
    771 => "001110110011",
    772 => "001110110100",
    773 => "001110110101",
    774 => "001110110101",
    775 => "001110110110",
    776 => "001110110110",
    777 => "001110110111",
    778 => "001110110111",
    779 => "001110111000",
    780 => "001110111001",
    781 => "001110111001",
    782 => "001110111010",
    783 => "001110111010",
    784 => "001110111011",
    785 => "001110111011",
    786 => "001110111100",
    787 => "001110111101",
    788 => "001110111101",
    789 => "001110111110",
    790 => "001110111110",
    791 => "001110111111",
    792 => "001110111111",
    793 => "001111000000",
    794 => "001111000000",
    795 => "001111000001",
    796 => "001111000010",
    797 => "001111000010",
    798 => "001111000011",
    799 => "001111000011",
    800 => "001111000100",
    801 => "001111000100",
    802 => "001111000101",
    803 => "001111000101",
    804 => "001111000110",
    805 => "001111000110",
    806 => "001111000111",
    807 => "001111000111",
    808 => "001111001000",
    809 => "001111001000",
    810 => "001111001001",
    811 => "001111001001",
    812 => "001111001010",
    813 => "001111001010",
    814 => "001111001011",
    815 => "001111001011",
    816 => "001111001100",
    817 => "001111001100",
    818 => "001111001101",
    819 => "001111001101",
    820 => "001111001110",
    821 => "001111001110",
    822 => "001111001111",
    823 => "001111001111",
    824 => "001111010000",
    825 => "001111010000",
    826 => "001111010001",
    827 => "001111010001",
    828 => "001111010010",
    829 => "001111010010",
    830 => "001111010010",
    831 => "001111010011",
    832 => "001111010011",
    833 => "001111010100",
    834 => "001111010100",
    835 => "001111010101",
    836 => "001111010101",
    837 => "001111010110",
    838 => "001111010110",
    839 => "001111010111",
    840 => "001111010111",
    841 => "001111010111",
    842 => "001111011000",
    843 => "001111011000",
    844 => "001111011001",
    845 => "001111011001",
    846 => "001111011010",
    847 => "001111011010",
    848 => "001111011010",
    849 => "001111011011",
    850 => "001111011011",
    851 => "001111011100",
    852 => "001111011100",
    853 => "001111011100",
    854 => "001111011101",
    855 => "001111011101",
    856 => "001111011110",
    857 => "001111011110",
    858 => "001111011110",
    859 => "001111011111",
    860 => "001111011111",
    861 => "001111100000",
    862 => "001111100000",
    863 => "001111100000",
    864 => "001111100001",
    865 => "001111100001",
    866 => "001111100010",
    867 => "001111100010",
    868 => "001111100010",
    869 => "001111100011",
    870 => "001111100011",
    871 => "001111100011",
    872 => "001111100100",
    873 => "001111100100",
    874 => "001111100101",
    875 => "001111100101",
    876 => "001111100101",
    877 => "001111100110",
    878 => "001111100110",
    879 => "001111100110",
    880 => "001111100111",
    881 => "001111100111",
    882 => "001111100111",
    883 => "001111101000",
    884 => "001111101000",
    885 => "001111101000",
    886 => "001111101001",
    887 => "001111101001",
    888 => "001111101001",
    889 => "001111101010",
    890 => "001111101010",
    891 => "001111101010",
    892 => "001111101011",
    893 => "001111101011",
    894 => "001111101011",
    895 => "001111101100",
    896 => "001111101100",
    897 => "001111101100",
    898 => "001111101100",
    899 => "001111101101",
    900 => "001111101101",
    901 => "001111101101",
    902 => "001111101110",
    903 => "001111101110",
    904 => "001111101110",
    905 => "001111101110",
    906 => "001111101111",
    907 => "001111101111",
    908 => "001111101111",
    909 => "001111110000",
    910 => "001111110000",
    911 => "001111110000",
    912 => "001111110000",
    913 => "001111110001",
    914 => "001111110001",
    915 => "001111110001",
    916 => "001111110001",
    917 => "001111110010",
    918 => "001111110010",
    919 => "001111110010",
    920 => "001111110010",
    921 => "001111110011",
    922 => "001111110011",
    923 => "001111110011",
    924 => "001111110011",
    925 => "001111110100",
    926 => "001111110100",
    927 => "001111110100",
    928 => "001111110100",
    929 => "001111110101",
    930 => "001111110101",
    931 => "001111110101",
    932 => "001111110101",
    933 => "001111110110",
    934 => "001111110110",
    935 => "001111110110",
    936 => "001111110110",
    937 => "001111110110",
    938 => "001111110111",
    939 => "001111110111",
    940 => "001111110111",
    941 => "001111110111",
    942 => "001111110111",
    943 => "001111111000",
    944 => "001111111000",
    945 => "001111111000",
    946 => "001111111000",
    947 => "001111111000",
    948 => "001111111001",
    949 => "001111111001",
    950 => "001111111001",
    951 => "001111111001",
    952 => "001111111001",
    953 => "001111111001",
    954 => "001111111010",
    955 => "001111111010",
    956 => "001111111010",
    957 => "001111111010",
    958 => "001111111010",
    959 => "001111111010",
    960 => "001111111011",
    961 => "001111111011",
    962 => "001111111011",
    963 => "001111111011",
    964 => "001111111011",
    965 => "001111111011",
    966 => "001111111011",
    967 => "001111111100",
    968 => "001111111100",
    969 => "001111111100",
    970 => "001111111100",
    971 => "001111111100",
    972 => "001111111100",
    973 => "001111111100",
    974 => "001111111100",
    975 => "001111111101",
    976 => "001111111101",
    977 => "001111111101",
    978 => "001111111101",
    979 => "001111111101",
    980 => "001111111101",
    981 => "001111111101",
    982 => "001111111101",
    983 => "001111111101",
    984 => "001111111110",
    985 => "001111111110",
    986 => "001111111110",
    987 => "001111111110",
    988 => "001111111110",
    989 => "001111111110",
    990 => "001111111110",
    991 => "001111111110",
    992 => "001111111110",
    993 => "001111111110",
    994 => "001111111110",
    995 => "001111111110",
    996 => "001111111111",
    997 => "001111111111",
    998 => "001111111111",
    999 => "001111111111",
    1000 => "001111111111",
    1001 => "001111111111",
    1002 => "001111111111",
    1003 => "001111111111",
    1004 => "001111111111",
    1005 => "001111111111",
    1006 => "001111111111",
    1007 => "001111111111",
    1008 => "001111111111",
    1009 => "001111111111",
    1010 => "001111111111",
    1011 => "001111111111",
    1012 => "001111111111",
    1013 => "001111111111",
    1014 => "001111111111",
    1015 => "001111111111",
    1016 => "001111111111",
    1017 => "001111111111",
    1018 => "001111111111",
    1019 => "001111111111",
    1020 => "001111111111",
    1021 => "001111111111",
    1022 => "001111111111",
    1023 => "001111111111"
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
          data <= rom(1024 - conv_integer(addr));
		elsif (addr(13 downto 12) = "10") then
          data <= -rom(conv_integer(addr));
		elsif (addr(13 downto 12) = "11") then
          data <= -rom(1024 - conv_integer(addr));
		end if;
      end if;
    end if;

  end process memory;

end architecture sin_rom_arch;
