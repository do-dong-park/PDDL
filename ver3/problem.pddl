(define (problem paint-job)
  (:domain house-painting)
  (:requirements :timed-initial-literals)
  (:objects
    red blue - house
    jay - painter
    pub - location
  )
  (:init
    (= (cost) 0)

    ; location
    (is_above first ground)

    (is_available red)
    (= (paint_job_duration red ground) 4)
    (= (paint_job_duration red first) 4)

    (is_available blue)
    (= (paint_job_duration blue ground) 4)
    (= (paint_job_duration blue first) 4)

    ; painter
    (is_available jay)
    (located_at jay pub)

    (= (travel_time jay pub blue) 1)
    (= (travel_time jay pub red) 3)
    (= (travel_time jay red blue) 10)
    (= (travel_time jay blue red) 10)
  )
  (:goal
    (and
      (paint_job_done red ground)
      (paint_job_done red first)
      (paint_job_done blue ground)
      (paint_job_done blue first)
    )
  )
  (:metric minimize
    (cost)
  )
)