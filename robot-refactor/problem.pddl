(define (problem household_problem)
    (:domain household_robot)

    (:objects
        livingroom kitchen bathroom - room
        toast-start toast-end laundry-start laundry-end pour-milk clean-bathroom - task
        robot - robot
    )
    (:init
        (= (cost) 0)

        (can-move kitchen livingroom)
        (can-move livingroom kitchen)
        (can-move livingroom bathroom)
        (can-move bathroom livingroom)

        (is-in pour-milk livingroom)
        (is-in clean-bathroom bathroom)
        (is-in toast-start kitchen)
        (is-in toast-end kitchen)
        (is-in laundry-start bathroom)
        (is-in laundry-end bathroom)

        (is-start laundry-start)
        (is-end laundry-end)
        (is-start toast-start)
        (is-end toast-end)
        (next laundry-start laundry-end)
        (next toast-start toast-end)

        (at robot bathroom)
        (available robot)

        (is-non-detachable pour-milk)
        (is-non-detachable clean-bathroom)
        (is-detachable laundry-start)
        (is-detachable laundry-end)
        (is-detachable toast-start)
        (is-detachable toast-end)
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