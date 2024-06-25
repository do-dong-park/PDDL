(define (domain house-painting)
  (:requirements :strips :typing :durative-actions :negative-preconditions :fluents)

  (:types
    location resource - available
    house - location
    painter - resource
    floor - object
  )

  (:constants
    ground first - floor
  )

  (:predicates
    (is_above ?f1 ?f2 - floor)
    (is_available ?a - available)
    (located_at ?r - resource ?l - location)
    (paint_job_started ?h - house ?f - floor)
    (paint_job_done ?h - house ?f - floor)
  )

  (:functions
    (cost)
    (travel_time ?r - resource ?from - location ?to - location)
    (paint_job_duration ?h - house ?f - floor)
  )

  (:durative-action paint
    :parameters (?h - house ?f - floor ?p - painter)
    :duration (= ?duration (paint_job_duration ?h ?f))
    :condition (and
      (at start (not (paint_job_started ?h ?f)))
      (at start (is_available ?h))
      (at start (is_available ?p))
      (at start (located_at ?p ?h))
    )
    :effect (and
      (at start (increase (cost) (paint_job_duration ?h ?f)))
      (at start (paint_job_started ?h ?f))
      (at start (not (is_available ?h)))
      (at start (not (is_available ?p)))
      (at end (paint_job_done ?h ?f))
      (at end (is_available ?h))
      (at end (is_available ?p))
    )
  )

  (:durative-action move
    :parameters (?p - painter ?from ?to - location)
    :duration (= ?duration (travel_time ?p ?from ?to))
    :condition (and
      (at start (located_at ?p ?from))
      (at start (is_available ?p))
    )
    :effect (and
      (at start (increase (cost) (travel_time ?p ?from ?to)))
      (at start (not (located_at ?p ?from)))
      (at end (located_at ?p ?to))
    )
  )
)