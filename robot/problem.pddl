(define (problem household_problem)
    (:domain household_robot)
    (:objects
        livingroom kitchen bathroom toast-start toast-end laundry-start laundry-end pour-milk robot
    )
    (:init
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

        (is-non-detachable pour-milk)
        (is-detachable laundry-start)
        (is-detachable laundry-end)

        (is-in toast-start kitchen)
        (is-in toast-end kitchen)
        (is-in pour-milk livingroom)
        (is-in laundry-start bathroom)
        (is-in laundry-end bathroom)

        (robot robot)
        (available robot)
        (at robot livingroom)
    )
    (:goal
        (and
            (at robot livingroom)

            (is-complete laundry-start)
            (is-complete laundry-end)
            (is-complete toast-start)
            (is-complete toast-end)
            (is-complete pour-milk)
        )
    )

    (:metric minimize
        (total-time)
    )
)