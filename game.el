;; Генерируем орг-буффер с двумя таблицами для распечатки и игры в
;; цыфры. Одна таблица содержит цифры расположенные в случайном
;; порядке для поиска. Вторая таблица пустая статичная таблица svg для
;; заполнения крестиками.

;; После генерации требуется доработка ручками, т.к. строки
;; генерируются не совсем корректно. После чего нужно выделать строки
;; с цифрами и сформировать таблицу через функцию
;; org-table-create-or-convert-from-region, затем экспортировать буфер
;; в html файл и распечатать с помощью браузера.


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

(defun n0n/gen-buff (&optional name)
  "generate line"
  (unless name (setq name "Nobody"))
  (let ((buff (get-buffer-create "game-buffer" 1))
	(numbers (n0n/gen-random-list 81))
	(len 24))                     ;; parametr length list 
    (with-current-buffer buff
      (erase-buffer)
      (goto-char (point-min))
      (insert (format "#+TITLE: %s\n" name))
      (insert "#+HTML_HEAD: <style>table, th, td {border: 1px solid;} img {margin-top: 90px}</style>\n\n")
      (org-mode)
      (while (> (length numbers) 0)
	(if (eq (% (point) len) 0)
	    (insert "\n"))
	(if (eq 0 (random 4))
	    (insert (number-to-string (pop numbers)) ",")
	  (insert ",")))
      (insert "\n\n\n[[file:./images/grid_40x10_plain.svg]]\n\n"))))

;; (n0n/gen-buff "Папа")

(defun n0n/game ()
  "main function"
  (let ((list (n0n/gen-buff))
	(tmp '())) ;; parametr line length
    (dotimes (i (length list))
      (if (eq (/ i 20) 0)
	  (setq tmp (cons "\n" tmp))
	(setq tmp (cons (nth i list) tmp)))
      (message (format "%s" tmp)))))

;; (n0n/game)

;; HOW TO PLAY
;; Open current file in emacs and M-x (eval-buffer)
;; Goto (n0n/game), evaluate, then switch to buffer "game-buffer"
;; Correct lines if need
;; Select lines and make C-c | (org-table-create-or-convert-from-region)
;; Change player's name in title
;; Make C-c C-e (org-export-dispatch) and h h - save file
;; Open saved file in browser and print it, repeate 


;; #+HTML_HEAD: <style>table, th, td {border: 1px solid;} img {margin-top: 150px}</style>
;; file:grid_40x10_plain.svg

;; variable 
;; variable org-html-head-include-default-style set to nil to disable default css style
;; variable org-html-preamble: nil & org-html-postamble: nil to disable preamble & postamble

(require 'ox-html)
(setq org-html-head-include-default-style nil
      org-html-preamble nil
      org-html-postamble nil)
  
