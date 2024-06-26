(define (problem household_problem)
    (:domain household_robot)
    (:objects
        livingroom kitchen bathroom washing-dishes clean-livingroom cook laundry robot
    )
    (:init
        (room livingroom)
        (room kitchen)
        (room bathroom)

        (can-move kitchen livingroom)
        (can-move livingroom kitchen)
        (can-move livingroom bathroom)
        (can-move bathroom livingroom)

        (task washing-dishes)
        (task clean-livingroom)
        (task cook)
        (task laundry)

        (is-controllable washing-dishes)
        (is-controllable clean-livingroom)
        (is-uncontrollable cook)
        (is-uncontrollable laundry)

        (is-in washing-dishes kitchen)
        (is-in cook kitchen)
        (is-in clean-livingroom livingroom)
        (is-in laundry bathroom)

        (robot robot)
        (available robot)

        (at robot livingroom)
    )
    (:goal
        (and
            (at robot livingroom)

            (is-complete washing-dishes)
            (is-complete cook)
            (is-complete laundry)
            (is-complete clean-livingroom)
        )
    )

    (:metric minimize
        (total-time)
    )
)