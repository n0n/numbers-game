
;; кароче получается что нужно делать через лист, т.к. в векторах нет
;; функций типа pop. генерируем лист случайных чисел в случайном
;; порядке, потом по одному вытаскиваем от туда айтемы

;; при переводе списка в строку и ее последующем делении рубятся
;; двухзначные числа, что не есть хорошо, поэтому нужно генеририть
;; список и потом его нарезать. Режем сначала целыми кусками, потом
;; добиваем остаток пустыми столбцами.

;; н-р длина строки (86) - 86 / 15 = 5.733, значит 5 полных циклов
;; проходим, остаток потом выделяем с помощью выражения (86 - 15*5) =
;; = 11, позиции НАЧ - 15*5 = 75 конец 75 + 11 = 86 или просто длина

;; либо генерить строку с помощью " ," пробелов и запятых, и потом
;; резать токлько по пробелам через регексп или set-fill-colon


(defun n0n/gen-random-list (&optional len)
  "Генерирует список из случайных чисел в случайном порядке. В
качестве аргумента принимает число длины списка. Числа не должны
повторяться в списке. Ноль тоже исключается"
  (unless len (setq len 30))
  (let ((list ()))
    (while (not (eq len (length list)))
      (add-to-list 'list (random len)))
    (symbol-value 'list)))

;; (n0n/gen-random-list)

(defun n0n/gen-line ()
  "generate line"
  (let ((line)
	(numbers (n0n/gen-random-list 30))) ;; parametr length list
    (while (> (length numbers) 0)
      (if (eq 0 (random 5))
	  (setq line (concat line " " (number-to-string (pop numbers)) ","))
	(setq line (concat line " ,"))))
     (symbol-value 'line)))

;; (n0n/gen-line)

(defun n0n/game ()
  "main function"
  (let* ((line (n0n/gen-line))
	(table "")
	(div (/ (length line) 15)))
    (dotimes (i div) ;; parametr line length
      (setq table (concat table (substring line (* i 15) (+ (* i 15) 15)) "\n"))
      (message table))))

;; (n0n/game)

",,,,,,,,5,,9,,,,,,,,,,,,,,7,,12,,,,,,3,8,,,,,,,,,,14,10,,,,,,,13,4,,,,2,,,,,,6,0,,,,1,11,"
