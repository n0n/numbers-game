
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
    (setq list (delq 0 list)) ;; удаляем ноль
    (symbol-value 'list)))

;; (n0n/gen-random-list)

(defun n0n/gen-line ()
  "generate line"
  (let ((buff (get-buffer-create "game-buffer" 1))
	(numbers (n0n/gen-random-list 31))
	(len 15)) ;; parametr length list 
    (with-current-buffer buff
      (erase-buffer)
      (goto-char (point-min))
      (org-mode)
      (while (> (length numbers) 0)
	(if (eq (% (point) 15) 0)
	    (insert "\n"))
	(if (eq 0 (random 5))
	    (insert (number-to-string (pop numbers)) ",")
	  (insert ","))))))

;; (n0n/gen-line)

(print (length (n0n/gen-line)))

(defun n0n/game ()
  "main function"
  (let ((list (n0n/gen-line))
	(tmp '())) ;; parametr line length
    (dotimes (i (length list))
      (if (eq (/ i 20) 0)
	  (setq tmp (cons "\n" tmp))
	(setq tmp (cons (nth i list) tmp)))
      (message (format "%s" tmp))))

;; (n0n/game)

;; #+HTML_HEAD: <style>table {width: 100%;} table, th, td {border: 1px solid;}</style>
;; #+ATTR_HTML: :border 1 :rules all :frame border
  
;; ",,,,,,,,5,,9,,,,,,,,,,,,,,7,,12,,,,,,3,8,,,,,,,,,,14,10,,,,,,,13,4,,,,2,,,,,,6,0,,,,1,11,"

(setq buff (generate-new-buffer "game-buffer" 1))
(with-current-buffer buff
  (insert "test\n test1"))
