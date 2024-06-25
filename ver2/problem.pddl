(define (problem paint-to-houses)
  (:domain job-scheduling)
  (:requirements :typing :timed-initial-literals)
  (:objects
    red blue - house
    jay pro - painter
    pub - location
  )
  (:init
    (at 3 (is_available red))
    (at 13 (not (is_available red)))
    (is_available blue)
    (luxurious blue)
    (= (paint_job_duration blue ground) 4)
    (= (paint_job_duration blue first) 4)
    (= (clean-up_job_duration blue) 2)
    (is_available jay)
    (located_at jay pub)
    (= (travel_time jay pub blue) 1)
    (= (travel_time jay pub red) 3)
    (is_available pro)
    (experienced pro)
    (located_at pro pub)
    (= (travel_time pro pub blue) 1)
    (= (travel_time pro pub red) 3)
    (is_above first ground)
    (= (cost) 0)
  )

  (:goal (and (forall 
    (?h - house) 
    (clean-up_job_done ?h)))) 
  (:constraints (and
      (after
        (paint_job_done blue first)
        (had-coffee-with-owner blue))
      (after
        (had-coffee-with-owner blue)
        (paint_job_started blue ground))
    )
  )
  (:metric minimize (cost))
)
