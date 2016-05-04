#lang racket/gui

(define frame (new frame% 
                   [label "Example"]
                   [width 1700]
                   [height 1000])
  )


(define panel (new tab-panel%
                   [choices '("Fazenda" "Maquinario" "Historico")]
                   [parent frame] 
                   )
  )

(define (drawTabs)
  (cond [(equal? (send panel get-selection) 0)
         (new canvas%
                                      [parent panel]
                                      [paint-callback
                                       (lambda (canvas dc)
                                         (send dc set-scale 3 3)
                                         (send dc set-text-foreground "blue")
                                         (send dc draw-text "Fazenda Tab!" 0 0))])]
        [(equal? (send panel get-selection) 1)
         (new canvas%
                                      [parent panel]
                                      [paint-callback
                                       (lambda (canvas dc)
                                         (send dc set-scale 3 3)
                                         (send dc set-text-foreground "blue")
                                         (send dc draw-text "Maquinario Tab!" 0 0))])]
        [else
         (new canvas%
                                      [parent panel]
                                      [paint-callback
                                       (lambda (canvas dc)
                                         (send dc set-scale 3 3)
                                         (send dc set-text-foreground "blue")
                                         (send dc draw-text "Historico Tab!" 0 0))])]))
(send panel set-selection 2)
(drawTabs)
(send frame show #t)
(send panel get-selection)
