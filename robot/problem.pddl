(define (problem household_problem)
    (:domain household_robot)

    (:objects
        livingroom kitchen bathroom clean-bathroom toast-start toast-end laundry-start laundry-end pour-milk robot
    )
    (:init
        (= (cost) 0)

        (room livingroom)
        (room kitchen)
        (room bathroom)

        (can-move kitchen livingroom)
        (can-move livingroom kitchen)
        (can-move livingroom bathroom)
        (can-move bathroom livingroom)

        (task toast-start)
        (task toast-end)
        (task laundry-start)
        (task laundry-end)
        (task pour-milk)
        (task clean-bathroom)

        (is-non-detachable pour-milk)
        (is-non-detachable clean-bathroom)
        (is-detachable laundry-start)
        (is-detachable laundry-end)
        (is-detachable toast-start)
        (is-detachable toast-end)

        (is-in pour-milk livingroom)
        (is-in clean-bathroom bathroom)
        (is-in toast-start kitchen)
        (is-in toast-end kitchen)
        (is-in laundry-start bathroom)
        (is-in laundry-end bathroom)

        (next laundry-start laundry-end)
        (next toast-start toast-end)

        (robot robot)
        (available robot)
        (at robot bathroom)
        (not (busy robot))
    )
    (:goal
        (and
            (at robot bathroom)

            (is-complete pour-milk)
            (is-complete laundry-start)
            (is-complete laundry-end)
            (is-complete toast-start)
            (is-complete toast-end)
            (is-complete clean-bathroom)

            (can-start laundry-end)
            (can-start toast-end)
        )
    )

    (:metric minimize
        (total-time)
    )
)