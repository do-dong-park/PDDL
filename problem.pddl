(define (problem household_problem)
    (:domain household_robot)

    
    (:objects
        livingroom kitchen bathroom - room
        toast-start toast-end laundry-start laundry-end pour-milk clean-bathroom - task
        robot - robot
    )
    (:init
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

        (= (travel_time kitchen livingroom) 1)
        (= (travel_time livingroom kitchen) 1)
        (= (travel_time bathroom livingroom) 2)
        (= (travel_time livingroom bathroom) 2)

        (= (task_duration toast-start) 2) ; 2 minutes
        (= (task_duration toast-end) 1) ; 1 minute
        (= (task_duration laundry-start) 5)
        (= (task_duration laundry-end) 10)
        (= (task_duration pour-milk) 10)
        (= (task_duration clean-bathroom) 20) ; Adjust as necessary

        (= (waiting_time laundry-start) 45) ; Adjust based on washing machine cycle
        (= (waiting_time toast-start) 5) ; Duration of toast cooking
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