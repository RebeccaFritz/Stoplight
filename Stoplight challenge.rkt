;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Stoplight challenge|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Rebecca Fritz and Melanie Jehu

;create the world state by creating a new structure
(define-struct WS [time])

;make the global variables
(define LIGHTBOX (rectangle 200 400 "solid" "black"))
(define LIGHTRADIUS 50)

(define LIGHTX 100)
(define REDY 75)
(define YELLOWY 200)
(define GREENY 325)

(define REDSOLID (circle LIGHTRADIUS 'solid 'red))
(define REDOUTLINE (circle LIGHTRADIUS 'outline 'firebrick))
(define GREENSOLID (circle LIGHTRADIUS 'solid 'limegreen))
(define GREENOUTLINE (circle LIGHTRADIUS 'outline 'forestgreen))
(define YELLOWSOLID (circle LIGHTRADIUS 'solid 'gold))
(define YELLOWOUTLINE (circle LIGHTRADIUS 'outline 'orange))

(define REDLIGHT (place-image
                  REDSOLID
                  LIGHTX REDY
                  (place-image
                   YELLOWOUTLINE
                   LIGHTX YELLOWY
                   (place-image
                    GREENOUTLINE
                    LIGHTX GREENY
                    LIGHTBOX))))

(define GREENLIGHT (place-image
                    REDOUTLINE
                    LIGHTX REDY
                    (place-image
                     YELLOWOUTLINE
                     LIGHTX YELLOWY
                     (place-image
                      GREENSOLID
                      LIGHTX GREENY
                      LIGHTBOX))))

(define YELLOWLIGHT (place-image
                     REDOUTLINE
                     LIGHTX REDY
                     (place-image
                      YELLOWSOLID
                      LIGHTX YELLOWY
                      (place-image
                       GREENOUTLINE
                       LIGHTX GREENY
                       LIGHTBOX))))

;make a function, draw, that consums the worldstate and produces the appropriately lit stoplight
;WorldState -> Image
(define (draw ws)
  (if (<= (WS-time ws) 5) REDLIGHT 
  (if (and (<= (WS-time ws) 9) (>= (WS-time ws) 6))
      GREENLIGHT
  (cond [(>= (WS-time ws) 10)
      YELLOWLIGHT]))))

;define tock
;WorldState -> WorldState
(define (tock ws)
  (if (> (WS-time ws) 10) (make-WS 0) (make-WS (+ (WS-time ws) 1))))

;make a function, key-handler, that consumes the worldstate and the pressed key and produces a new worldstate
;WorldState, key -> WorldState
(define (key-handler ws the-key)
  (cond [(string=? the-key " ")
      (make-WS 6)]))

;initial world state
(define initial-ws (make-WS 0))

;big bang
(big-bang initial-ws
  (to-draw draw)
  (on-tick tock 1)
  (on-key key-handler))
