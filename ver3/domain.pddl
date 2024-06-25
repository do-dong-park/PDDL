(define (domain simple-house-painting)
  (:requirements :strips :typing :durative-actions :fluents)
  (:types
    house painter location
  )
  (:predicates
    (available ?p - painter)
    (at ?l - location ?p - painter)
    (paintable ?h - house)
    (painted ?h - house)
  )
  (:functions
    (paint-duration ?h - house)
    (travel-time ?from ?to - location)
    ; (total-cost)
  )
  (:durative-action paint
    :parameters (?h - house ?p - painter)
    :duration (= ?duration (paint-duration ?h))
    :condition (and
      (at start (available ?p))
      (at start (paintable ?h))
      (over all (available ?p))
    )
    :effect (and
      (at start (not (available ?p)))
      (at end (painted ?h))
      (at end (available ?p))
      (at start (increase (total-cost) (paint-duration ?h)))
    )
  )
  (:durative-action travel
    :parameters (?p - painter ?from ?to - location)
    :duration (= ?duration (travel-time ?from ?to))
    :condition (and
      (at start (available ?p))
      (at start (at ?from ?p))
    )
    :effect (and
      (at start (not (at ?from ?p)))
      (at end (at ?to ?p))
      (at start (increase (total-cost) (travel-time ?from ?to)))
    )
  )
)
