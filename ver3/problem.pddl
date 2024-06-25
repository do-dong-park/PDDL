(define (problem simple-paint-job)
  (:domain simple-house-painting)
  (:requirements :typing :durative-actions :action-costs)
  (:objects
    house1 - house
    painter1 - painter
    base - location
  )
  (:init
    (at base painter1)
    (available painter1)
    (paintable house1)
    (= (paint-duration house1) 4)
    (= (travel-time base base) 1)
    ; (= (total-cost) 0)
  )
  (:goal (painted house1))
  (:metric minimize (total-cost))
)
