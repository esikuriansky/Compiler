;; CONSTANTS
; #f
; #t
; '()

;; IF
; (if #t #t #f) ;==> return value #t OK
; (if #t #f #t) ;==> return value: #f OK
; (if #f #f #t) ;==> return value: #t
; (if #f #f #f) ;==> return value: #f OK
; (if #f #f) ;==> return value: void

;;SEQ
; (begin #t #t #f) ;==> return value: #f OK
; (begin #t) ;==> return value: #t OK 
; (begin #f #f #f #f #f #f (begin #f #f #t)) ;==> return value: #t OK

;;OR
; (or #f #f #f #t) ;==> return value: #t OK
; (begin #f (or #f #t '()) (if #f #f)) ;==> return value: void OK

;;APPLIC and LAMBDA-SIMPLE
; ((lambda (x) (if x #t #f)) #t) ;==> return value: #t OK
; ((lambda (x) (if x #t #f)) #f) ;==> return value: #f OK
; (and #t #t ((lambda (x) (if x #f #t)) #t) '()) ;==> return value: #f OK
; (and #t #t ((lambda (x) (if x #t #t)) #t) '()) ;==> return value: '() OK
; ((lambda (x y z) (if x y z)) #f #t #f)  ;==> return value: #f OK
; ((lambda (x y z) (if x #t #f)) #t) ;==> return value: ERROR OK
; (((lambda (x) (lambda (y) #t)) #f) #f) ;==> return value: #t OK
; ((((lambda (a b c) (lambda (d e f) (lambda (g h i) (if (begin a d g) (begin b e h) (and c f i))))) #f #f #t) #f #t #t) #t '() #t) ;==> return value: '() OK

;;TODO
; ((lambda (x) (lambda (y) '())) #f)
; ((lambda (x) (lambda () #t)) #f)
; (((lambda (x) (lambda (y) '())) #f) #t)

;;PVAR and BVAR
; ((lambda (x) x) #t) ;==> return value: #t OK
; ((lambda (x y) y) #t #f) ;==> return value: #f OK
;((lambda (y) ((lambda (x) x) #t)) #f) ;==> return value: #t OK
;((lambda (z) ((lambda (y) ((lambda (x) x) #t)) #f)) #f) ;==> return value: #t OK

;((lambda (y) ((lambda (x) y) #t)) #f) ;==> return value: #f OK
;((lambda (z) ((lambda (y) ((lambda (x) z) #f)) #f)) #t) ;==> return value: #t OK
;((lambda (z w) ((lambda (y s) ((lambda (x) s) #t)) #t #f)) #t #t) ;==> return value: #t OK

((lambda (y z) ((lambda (x) z) #f)) #f #t) ;==> return value: #f OK


;(((lambda (x) (lambda (y) x)) #f) #t) ;==> return value: #f OK
;(((lambda (x) (lambda (y) x y)) #f) #t) ;==> return value: #t OK

;;SET
;((lambda (x) (set! x #t)) #f) ;==> return value: void OK
;((lambda (x) (set! x #t) x) #f) ;==> return value: #t OK
;((lambda (x) ((lambda (y) (set! x #t)) #f)) #f) ;==> return value: void OK
;(set! x #t) ;;TODO

;;LAMBDA-OPT
;((lambda (x . y) #f) #t) ;==> return value: #f OK
;((lambda (x . y) #t) #f #f) ;==> return value: #t OK
;((lambda (x . y) #f) #t #t #t) ;==> return value: #f OK

;((lambda (x . y) x) #t) ;==> return value: #t OK
;((lambda (x . y) y) #t)  ;==> return value: (), OK
;((lambda (x . y) x) #t #f) ;==> return value: #t OK
;((lambda (x . y) y) #t #f) ;==> return value: (#f), actual: (#f . ()) OK?

;((lambda (x . y) x) #t #f #f) ;==> return value: #t OK
;((lambda (x . y) y) #t #f #f) ;==> return value: (#f #f), actual: (#f . (#f . ())) OK?
;((lambda (x . y) y) #t #f #f #f) ;==> return value: (#f #f #f), actual:   (#f . (#f . (#f . ()))) OK?

;;LAMBDA-VAR
;((lambda x #t) #f) ;==> return value: #t OK
;((lambda x #f) #t #t) ;==> return value: #f OK
;((lambda x x)) ;==> return value: () OK
;((lambda x x) #f) ;==> return value: (#f), actual: (#f . ()) OK?

;((lambda x x) #f #f) ;==> return value: (#f #f), actual: (#f . (#f . ())) OK?
;((lambda x x) #f #f #f) ;==> return value: (#f #f #f), actual: (#f . (#f . (#f . ()))) OK?
;((lambda x x) #f #f #f #f) ;==> return value: (#f #f #f #f), actual: (#f . (#f . (#f . (#f . ())))) OK?

;;TC-APPLIC
;((lambda (x) (if #t ((lambda (y) #t) #f) #f)) #f) ;==> return value: #t OK
;((lambda (x) (or #f #f (if #t ((lambda (y) #t) #f) #f))) #f) ;==> return value: #t OK
;((lambda (x) ((lambda (y) ((lambda (z) z) #f)) #t)) #t) ;==> return value: #f OK
;((lambda (x) ((lambda (y) ((lambda z z) #f)) #t)) #t) ;==> return value: (#f), actual: (#f . ()) OK?
;((lambda (x) ((lambda (y) ((lambda z z) #f #f)) #t)) #t) ;==> return value: (#f), actual: (#f . (#f . ())) OK?
;((lambda x ((lambda (y) ((lambda z z) #f)) #t)) #t #t #t) ;==> return value: (#f), actual: (#f . ()) OK?

;;BOX
;(lambda (x) (lambda () (set! x #t)) x)
;(lambda (x) (lambda () x) (set! x #t))



; ((((lambda (x) (lambda (y z) (lambda (a b c) x y z a b c))) 1) 2 3) 4 5 6)
; '(1 2 3)
; '(0 1 (4 5) "Ben" #\B #\e #\n)
; (car '(1 2 3 4))
; (cdr '(1 2 3 4))
; cons
; (cons 1 (cons 2 (cons 3 '())))
; (boolean? #f)
; (boolean? #t)
; (boolean? 'x)
; (boolean? (cons 1 2))
; (+ 1 2 3 4 5)
; (+)
; (*)
; (* 1 2 3 4 5)
; (zero? 0)
; (zero? 1)
; (char? #\B)
; (char? 1)
; (integer? 1)
; (integer? '())
; (number? 1)
; (number? '())
; (vector? 1)
; (vector? '#(1 2 3))
; (pair? '(1 2 3))
; (pair? 1)
; (procedure? cons)
; (procedure? 1)
; (symbol? 'a)
; (symbol? 1)
; (string? "Ben")
; (string? 1)
; (vector-length '#(1 2 3 4))
; (string-length "Ben")
; (define x (cons 1 2))
; x
; (set-car! x 3)
; x
; (set-cdr! x '(10 11 12))
; x
; (integer->char 48)
; (integer->char 49)
; (integer->char 50)
; (define s "Ben")
; s
; (string-set! s 1 #\a)
; s
; (string-ref s 0)
; (string-ref s 2)
; (vector-ref '#(1 "Hello" #\A 5) 1)
; (vector-ref '#(1 "Hello" #\A 5) 2)
; (vector-ref '#(1 "Hello" #\A 5) 3)
; (make-string 5)
; (define s (make-string 5 #\F))
; s
; (string-set! s 0 #\A)
; s
; (make-vector 4)
; (define v (make-vector 4 "Ben"))
; v
; (string-set! (vector-ref v 0) 1 #\a)
; v
; (char->integer #\3)
; (- 13)
; (- 1 2 3 4 5 6)
; (/ 3)
; (/ 64 2 2 2 2)
; (/ 5 2)
; (= 1)
; (= 1 2 3)
; (= 1 1 1)
; (= (+ 9 1) (+ 5 5) (* 2 5) (/ 20 2))
; (= (+ 9 1) (+ 5 5) (* 2 5) (/ 20 1))
; (> 1 1 1)
; (> 1)
; (> 3 2 1)
; (< 1)
; (< 1 1)
; (< 1 2 3)
; (remainder 2 1)
; (remainder 4 2)
; (remainder 5 2)
; (remainder 0 19)
; (remainder 147 148)
; 'a
; 'sym
; 'surprise-mothafucka
; (string->symbol "a")
; (string->symbol "yabadabadoo")
; (symbol->string 'ben\ eyal)
; (eq? (string->symbol (symbol->string (string->symbol "yabadabadoo"))) 'yabadabadoo)
; (vector-length '#(1 2 3 4))
; ((lambda (x) (* x x x)) 5)
; ((lambda (a b c . v) v) 1 2 3 4 5 6 7 8 9 10)
; ((lambda (a b c . v) v) 1 2 3)
; ((lambda v v) 1 2 3 4 5 6 7)
; ((lambda v v))
; ((lambda (x y z) ((lambda (a b) (+ 1)) 2 2) 3) 4 4 4)
; ((lambda (x y z) ((lambda (a b) (+ 1 1)) 2 2) 3) 4 4 4)
; ((lambda (x y z) ((lambda (a b) (+ 1 1 1)) 2 2) 3) 4 4 4)
; ((lambda (x y z) ((lambda (a b) (+ 1 1 1 1 1 1 1 1 1 1)) 2 2) 3) 4 4 4)
; ((lambda (x y z) (+ 1 2 3 4 5 6 7 8 9 10)) 2 2 2)
; (define f (lambda (x) x))
; (f 5)
; (apply + '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 591 592 593 594 595 596 597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689 690 691 692 693 694 695 696 697 698 699 700 701 702 703 704 705 706 707 708 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757 758 759 760 761 762 763 764 765 766 767 768 769 770 771 772 773 774 775 776 777 778 779 780 781 782 783 784 785 786 787 788 789 790 791 792 793 794 795 796 797 798 799 800 801 802 803 804 805 806 807 808 809 810 811 812 813 814 815 816 817 818 819 820 821 822 823 824 825 826 827 828 829 830 831 832 833 834 835 836 837 838 839 840 841 842 843 844 845 846 847 848 849 850 851 852 853 854 855 856 857 858 859 860 861 862 863 864 865 866 867 868 869 870 871 872 873 874 875 876 877 878 879 880 881 882 883 884 885 886 887 888 889 890 891 892 893 894 895 896 897 898 899 900 901 902 903 904 905 906 907 908 909 910 911 912 913 914 915 916 917 918 919 920 921 922 923 924 925 926 927 928 929 930 931 932 933 934 935 936 937 938 939 940 941 942 943 944 945 946 947 948 949 950 951 952 953 954 955 956 957 958 959 960 961 962 963 964 965 966 967 968 969 970 971 972 973 974 975 976 977 978 979 980 981 982 983 984 985 986 987 988 989 990 991 992 993 994 995 996 997 998 999 1000))
; (map + '(1 2 3) '(4 5 6))
; (map (lambda (x) (* x x)) '(1 2 3 4 5 6 7 8 9 10))
; (map + '() '() '())
; (define fact (lambda (n) (if (zero? n) 1 (* n (fact (- n 1))))))
; (map fact '(1 2 3 4 5 6 7 8 9 10 11 12))
; (define fib (lambda (n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2))))))
; (map fib '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))
; (map - '(1 2 3) '(4 5 6))
; (define f (lambda (a1 a2 a3) (lambda (b1 b2 b3) (lambda (c1 c2 c3) (lambda (d1 d2 d3) (lambda (e1 e2 e3) (+ a1 b2 c3)))))))
; (((((f 1 10 100) 2 20 200) 3 30 300) 4 40 400) 5 50 500)
; (define m (map (lambda (e) (lambda fs (cons e fs))) '(1 2 3 4)))
; ((car m))
; (define f (lambda (x) (lambda () x)))
; ((f 1337))
; (letrec ((f (lambda (x) x))) (f 1337))
; (letrec ((fact (lambda (n) (if (zero? n) 1 (* n (fact (- n 1))))))) (fact 5))
; (eq? (+ 1 4) (+ 2 3))
; (eq? (lambda (x) x) (lambda (x) x))
; (define f (lambda (x) x))
; (eq? f f)
; ((((lambda (x) (x x)) (lambda (x) x)) (lambda (x) x)) #t)
; (eq? (string->symbol "a") (string->symbol "a"))
; (eq? 'a 'b)
; (eq? 'a (string->symbol "b"))
; (eq? '() '())
; (eq? (cdr '(a)) '())
; (eq? #t #t)
; (eq? #f #f)
; (eq? #t #f)
; (eq? (null? '()) #t)
; (eq? (null? '(a)) #f)
; (eq? car car)
; (eq? 'a (string->symbol "a"))

; ;; Torture test - FactX
; (define fact
;   (let ((x (lambda (x)
;          ((x (lambda (x) (lambda (y) (lambda (z) ((x z) (y z))))))
;           (lambda (x) (lambda (y) x)))))
;     (->
;      ((lambda (x) (x x))
;       (lambda (->)
;         (lambda (n)
;           (if (zero? n)
;           (lambda (x) (lambda (y) y))
;           (let ((z ((-> ->) (- n 1))))
;             (lambda (x)
;               (lambda (y)
;             (x ((z x) y)))))))))))
;     (lambda (n)
;       ((((((((x (x (x (x x)))) (((x (x (x (x x)))) ((x (x (x x))) (x
;       (x (x (x x)))))) (((x (x (x (x x)))) ((x (x (x x))) (x (x (x x
;       ))))) (x (x (x (x x))))))) ((x (x (x x))) (x (x (x x))))) ((((
;       (x (x (x (x x)))) (((x (x (x (x x)))) ((x (x (x x))) (x (x (x
;       (x x)))))) (((x (x (x (x x)))) ((x (x (x x))) (x (x (x x)))))
;       (x (x (x (x x))))))) ((x (x (x x))) (x (x (x x))))) (((((x (x
;       (x (x x)))) (((x (x (x (x x)))) ((x (x (x x))) (x (x (x (x x))
;       )))) (((x (x (x (x x)))) ((x (x (x x))) (x (x (x x))))) (x (x
;       (x (x x))))))) ((x (x (x x))) (x (x (x x))))) (((x (x (x (x x)
;       ))) (x (x (x x)))) (x (x (x x))))) (((x (x (x(x x)))) (((((x (
;       x (x (x x)))) ((x (x (x x))) (x (x (x (x x)))))) (x (x (x x)))
;       ) (((x (x (x (x x)))) ((x (x (x x))) (((x(x (x (x x)))) (((x (
;       x (x (x x)))) ((x (x (x x))) (x (x (x (x x)))))) (((x (x (x (x
;       x)))) ((x (x (x x))) (x (x (x x))))) (x(x (x (x x))))))) ((x (
;       x (x x))) (x (x (x x))))))) ((((x (x(x (x x)))) (((x (x (x (x
;       x)))) ((x (x (x x))) (x (x (x (x x)))))) (((x (x (x (x x)))) (
;       (x (x (x x))) (x (x (x x))))) (x(x (x (x x))))))) ((x (x (x x)
;       )) (x (x (x x))))) (((x (x (x (x x)))) (x (x (x x)))) (x (x (x
;       x))))))) (((((x (x (x (x x)))) ((x (x (x x))) (x (x (x (x x)))
;       ))) (x (x (x x)))) ((x (x(x (x x)))) (((x (x (x (x x)))) ((x (
;       x (x x))) (x (x (x (x x)))))) (x (x (x x)))))) (((((x (x (x (x
;       x)))) (((x (x (x (x x)))) ((x (x (x x))) (x (x (x (x x)))))) (
;       ((x (x (x (x x)))) ((x (x (x x))) (x (x (x x))))) (x (x (x (x
;       x))))))) ((x (x (x x))) (x (x (x x))))) (((x (x (x (x x)))) (x
;       (x (x x)))) (x (x (x x))))) (x (x (x x))))))) (((x (x (x (x x)
;       ))) (((((x (x (x (x x)))) ((x (x (x x))) (x (x (x (x x)))))) (
;       x(x (x x)))) (((x(x (x (x x)))) ((x (x (x x))) (x (x (x (x x))
;       )))) (x (x (x x))))) (((((x (x (x (x x)))) (((x (x (x (x x))))
;       ((x (x (x x)))(x (x (x (x x)))))) (((x (x (x (x x)))) ((x (x (
;       x x))) (x (x(x x))))) (x (x (x (x x))))))) ((x (x (x x))) (x (
;       x (x x)))))(((x (x (x (x x)))) (x (x (x x)))) (x (x (x x)))))
;       (x (x (x x)))))) (((((x (x (x (x x)))) (((x (x (x (x x)))) ((x
;       (x (x x)))(x (x (x (x x)))))) (((x (x (x (x x)))) ((x (x (x x)
;       )) (x (x(x x))))) (x (x (x (x x))))))) ((x (x (x x))) (x (x (x
;       x)))))(((x (x (x (x x)))) (x (x (x x)))) (x (x (x x))))) ((x (
;       x (x x))) (((x (x (x (x x)))) (x (x (x x)))) (x (x (x x)))))))
;       )))(((((x (x (x (x x)))) ((x (x (x x))) (((x (x (x (x x)))) ((
;       (x(x (x (x x)))) ((x (x (x x))) (x (x (x (x x)))))) (((x (x (x
;       (x x)))) ((x (x (x x))) (x (x (x x))))) (x (x (x (x x)))))))((
;       x (x (x x))) (x (x (x x))))))) ((((x (x (x (x x)))) (((x (x(x
;       (x x)))) ((x (x (x x))) (x (x (x (x x)))))) (((x (x (x (x x)))
;       )((x (x (x x))) (x (x (x x))))) (x (x (x (x x))))))) ((x(x (x
;       x))) (x (x (x x))))) (((x (x (x (x x)))) (x (x (x x))))(x (x (
;       x x)))))) (((x (x (x (x x)))) (((x (x (x (x x)))) ((x (x (x x)
;       ))(x (x (x (x x)))))) (x (x (x x))))) ((x (x (x x)))(((x (x (x
;       (x x)))) (x (x (x x)))) (x (x (x x))))))) (((x (x(x (x x)))) (
;       ((x (x (x (x x)))) ((x (x (x x))) (x (x (x (x x)))))) (x (x (x
;       x))))) ((x (x (x x))) (((x (x (x (x x)))) (x(x (x x)))) (x (x
;       (x x))))))))) ((x (x (x x))) (((x (x (x (x x)))) (x (x (x x)))
;       )(x (x (x x))))))
;      (-> n))
;     (lambda (x) (+ x 1))) 0))))

; (fact 5)

; ;; Torture test 00
; (((((lambda (a)
;       (lambda (b)
;         (((lambda (a) (lambda (b) ((a b) (lambda (x) (lambda (y) y)))))
;       ((lambda (n)
;          ((n (lambda (x) (lambda (x) (lambda (y) y))))
;           (lambda (x) (lambda (y) x))))
;        (((lambda (a)
;            (lambda (b)
;          ((b (lambda (n)
;                ((lambda (p) (p (lambda (a) (lambda (b) b))))
;             ((n (lambda (p)
;                   (((lambda (a)
;                   (lambda (b) (lambda (c) ((c a) b))))
;                 ((lambda (n)
;                    (lambda (s)
;                      (lambda (z) (s ((n s) z)))))
;                  ((lambda (p)
;                     (p (lambda (a) (lambda (b) a))))
;                   p)))
;                    ((lambda (p)
;                   (p (lambda (a) (lambda (b) a))))
;                 p))))
;              (((lambda (a)
;                  (lambda (b) (lambda (c) ((c a) b))))
;                (lambda (x) (lambda (y) y)))
;               (lambda (x) (lambda (y) y)))))))
;           a)))
;          a)
;         b)))
;      ((lambda (n)
;         ((n (lambda (x) (lambda (x) (lambda (y) y))))
;          (lambda (x) (lambda (y) x))))
;       (((lambda (a)
;           (lambda (b)
;         ((b (lambda (n)
;               ((lambda (p) (p (lambda (a) (lambda (b) b))))
;                ((n (lambda (p)
;                  (((lambda (a)
;                  (lambda (b) (lambda (c) ((c a) b))))
;                    ((lambda (n)
;                   (lambda (s)
;                     (lambda (z) (s ((n s) z)))))
;                 ((lambda (p)
;                    (p (lambda (a) (lambda (b) a))))
;                  p)))
;                   ((lambda (p)
;                  (p (lambda (a) (lambda (b) a))))
;                    p))))
;             (((lambda (a)
;                 (lambda (b) (lambda (c) ((c a) b))))
;               (lambda (x) (lambda (y) y)))
;              (lambda (x) (lambda (y) y)))))))
;          a)))
;         b)
;        a)))))
;     ((lambda (n)
;        ((lambda (p) (p (lambda (a) (lambda (b) b))))
;     ((n (lambda (p)
;           (((lambda (a) (lambda (b) (lambda (c) ((c a) b))))
;         ((lambda (n) (lambda (s) (lambda (z) (s ((n s) z)))))
;          ((lambda (p) (p (lambda (a) (lambda (b) a)))) p)))
;            (((lambda (a)
;            (lambda (b)
;              ((b (a (lambda (a)
;                   (lambda (b)
;                 ((a (lambda (n)
;                       (lambda (s)
;                     (lambda (z) (s ((n s) z))))))
;                  b)))))
;               (lambda (x) (lambda (y) y)))))
;          ((lambda (p) (p (lambda (a) (lambda (b) a)))) p))
;         ((lambda (p) (p (lambda (a) (lambda (b) b)))) p)))))
;      (((lambda (a) (lambda (b) (lambda (c) ((c a) b))))
;        (lambda (x) x))
;       (lambda (x) x)))))
;      (lambda (x) (lambda (y) (x (x (x (x (x y)))))))))
;    (((lambda (a)
;        (lambda (b)
;      ((b (a (lambda (a)
;           (lambda (b)
;             ((a (lambda (n)
;               (lambda (s) (lambda (z) (s ((n s) z))))))
;              b)))))
;       (lambda (x) (lambda (y) y)))))
;      (((lambda (a)
;      (lambda (b)
;        ((b (a (lambda (a)
;             (lambda (b)
;               ((a (lambda (n)
;                 (lambda (s) (lambda (z) (s ((n s) z))))))
;                b)))))
;         (lambda (x) (lambda (y) y)))))
;        ((lambda (x) (lambda (y) (x (x (x y)))))
;     (lambda (x) (lambda (y) (x (x y))))))
;       (lambda (x) (lambda (y) (x (x (x y)))))))
;     (lambda (x) (lambda (y) (x (x (x (x (x y)))))))))
;   #t)
;  #f)

; ;; Torture test 01
; ((lambda (x)
;     (x x 1000000))
;  (lambda (x n)
;    (if (zero? n)
;        #t
;        (x x (- n 1)))))

; ;; Torture test 03
; (define with (lambda (s f) (apply f s)))

; (define crazy-ack
;   (letrec ((ack3
;         (lambda (a b c)
;           (cond
;            ((and (zero? a) (zero? b)) (+ c 1))
;            ((and (zero? a) (zero? c)) (ack-x 0 (- b 1) 1))
;            ((zero? a) (ack-z 0 (- b 1) (ack-y 0 b (- c 1))))
;            ((and (zero? b) (zero? c)) (ack-x (- a 1) 1 0))
;            ((zero? b) (ack-z (- a 1) 1 (ack-y a 0 (- c 1))))
;            ((zero? c) (ack-x (- a 1) b (ack-y a (- b 1) 1)))
;            (else (ack-z (- a 1) b (ack-y a (- b 1) (ack-x a b (- c 1))))))))
;        (ack-x
;         (lambda (a . bcs)
;           (with bcs
;         (lambda (b c)
;           (ack3 a b c)))))
;        (ack-y
;         (lambda (a b . cs)
;           (with cs
;         (lambda (c)
;           (ack3 a b c)))))
;        (ack-z
;         (lambda abcs
;           (with abcs
;         (lambda (a b c)
;           (ack3 a b c))))))
;     (lambda ()
;       (and (= 7 (ack3 0 2 2))
;        (= 61 (ack3 0 3 3))
;        (= 316 (ack3 1 1 5))
;        (= 636 (ack3 2 0 1))
;        ))))

; (crazy-ack)

; ;; Torture test 005
; (((((lambda (x) (x (x x)))
;     (lambda (x)
;       (lambda (y)
;     (x (x y)))))
;    (lambda (p)
;      (p (lambda (x)
;       (lambda (y)
;         (lambda (z)
;           ((z y) x)))))))
;   (lambda (x)
;     ((x #t) #f)))
;  (lambda (x)
;    (lambda (y)
;      x)))

; ;; Torture test 06
; (define positive? (lambda (n) (> n 0)))
; (define even?
;   (letrec ((even-1?
;         (lambda (n)
;           (or (zero? n)
;           (odd-2? (- n 1) 'odd-2))))
;        (odd-2?
;         (lambda (n _)
;           (and (positive? n)
;            (even-3? (- n 1) (+ n n) (+ n n n)))))
;        (even-3?
;         (lambda (n _1 _2)
;           (or (zero? n)
;           (odd-5? (- n 1) (+ n n) (* n n) 'odd-5 'odder-5))))
;        (odd-5?
;         (lambda (n _1 _2 _3 _4)
;           (and (positive? n)
;            (even-1? (- n 1))))))
;     even-1?))

; (if (even? 2048) #t #f)
; (if (even? 2049) #f #t)

; ;; Torture test 07
; (let ((a 1))
;   (let ((b 2) (c 3))
;     (let ((d 4) (e 5) (f 6))
;       (= 720 (* a b c d e f)))))

; ;; Torture test 008
; (define with (lambda (s f) (apply f s)))

; (define fact
;   (letrec ((fact-1
;         (lambda (n r)
;           (if (zero? n)
;           r
;           (fact-2 (- n 1)
;               (* n r)
;               'moshe
;               'yosi))))
;        (fact-2
;         (lambda (n r _1 _2)
;           (if (zero? n)
;           r
;           (fact-3 (- n 1)
;               (* n r)
;               'dana
;               'michal
;               'olga
;               'sonia))))
;        (fact-3
;         (lambda (n r _1 _2 _3 _4)
;           (if (zero? n)
;           r
;           (fact-1 (- n 1)
;               (* n r))))))
;     (lambda (n)
;       (fact-1 n 1))))

; (= 720 (fact 6))

; ;; Torture test 08
; (let ()
;   ((lambda s
;      (let ()
;        ((lambda s s) s s s)))
;    #t))
