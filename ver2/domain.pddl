(define (domain job-scheduling)
  (:requirements
    :strips :typing :negative-preconditions :durative-actions :disjunctive-preconditions :universal-preconditions :fluents)
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
    (luxurious ?h - house)
    (experienced ?p - painter)
    (had-coffee-with-owner ?h - house)
    (is_above ?f1 ?f2 - floor)
    (is_available ?a - available)
    (located_at ?r - resource ?l - location)
    (busy ?r - resource)
    (paint_job_started ?h - house ?f - floor)
    (paint_job_done ?h - house ?f - floor)
    (clean-up_job_started ?h - house)
    (clean-up_job_done ?h - house)
    (contains ?parent - location ?child - location)
  )
  (:functions
    (cost)
    (travel_time ?r - resource ?from - location ?to - location)
    (paint_job_duration ?h - house ?f - floor)
    (clean-up_job_duration ?h - house)
  )
  (:durative-action paint
    :parameters (?h - house ?f - floor ?p - painter)
    :duration (= ?duration (paint_job_duration ?h ?f))
    :condition (and
      (at start (imply (luxurious ?h) (experienced ?p)))
      (at start (forall (?f1 - floor) (imply (is_above ?f1 ?f) (paint_job_done ?h ?f1))))
      (over all (is_available ?h))
      (over all (is_available ?p))
      (over all (located_at ?p ?h))
      (at start (not (paint_job_started ?h ?f)))
      )
    :effect (and
      (at start (increase (cost) (paint_job_duration ?h ?f)))
      (at start (paint_job_started ?h ?f))
      (at end (paint_job_done ?h ?f))
      (at start (not (is_available ?h)))
      (at end (is_available ?h))
      (at start (busy ?p))
      (at end (not (busy ?p))))
  )
  (:durative-action clean-up
    :parameters (?h - house ?p - painter)
    :duration (= ?duration (clean-up_job_duration ?h))
    :condition (and
      (at start (forall (?f - floor) (paint_job_done ?h ?f)))
      (over all (is_available ?h))
      (over all (is_available ?p))
      (over all (located_at ?p ?h))
      (at start (not (clean-up_job_started ?h))))
    :effect (and
      (at start (increase (cost) (clean-up_job_duration ?h)))
      (at start (clean-up_job_started ?h))
      (at end (clean-up_job_done ?h))
      (at start (not (is_available ?h)))
      (at end (is_available ?h))
      (at start (busy ?p))
      (at end (not (busy ?p))))
  )
  (:durative-action coffee
    :parameters (?h - house ?p - painter)
    :duration (= ?duration 1)
    :condition (and 
      (at start (not (had-coffee-with-owner ?h)))
      (over all (not (busy ?p)))
      (over all (located_at ?p ?h)))
    :effect (at end (had-coffee-with-owner ?h))
  )
  (:durative-action move
    :parameters (?res - resource ?from ?to - location)
    :duration (= ?duration (travel_time ?res ?from ?to))
    :condition (and 
      (at start (not (busy ?res)))
      (at start (located_at ?res ?from)))
    :effect (and 
      (at start (not (located_at ?res ?from)))
      (at start (located_at ?res ?to))
      (at start (busy ?res))
      (at end (not (busy ?res))))
  )
)
