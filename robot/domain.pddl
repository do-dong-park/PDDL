(define (domain household_robot)
    (:requirements :strips :typing :fluents :durative-actions)

    (:predicates
        (can-move ?from ?to)
        (at ?robot ?room)
        (is-in ?task ?room)
        (is-complete ?task)
        (is-uncontrollable ?task)
        (is-controllable ?task)
        
        (robot ?robot)
        (task ?task)
        (room ?room)

        (move_pending ?robot)
        (task_pending ?robot)
    )

    (:durative-action move
        :parameters (?robot ?from ?to)
        :duration (= ?duration 5) ; assuming it takes 5 units of time to move between rooms
        :condition (and
            (at start (robot ?robot))
            (at start (room ?from))
            (at start (room ?to))

            (over all (can-move ?from ?to))

            (at start (at ?robot ?from))
            (at start (move_pending ?robot))
        )
        :effect (and
            (at end (at ?robot ?to))
            (at end (task_pending ?robot))
        )
    )

    (:durative-action perform_controllable_task
        :parameters (?robot ?task ?room)
        :duration (= ?duration 10)
        :condition (and
            (at start (robot ?robot))
            (at start (task ?task))
            (at start (room ?room))
            
            (at start (at ?robot ?room))
            (at start (is-controllable ?task))
            (at start (is-in ?task ?room))
            (at start (task_pending ?robot))
        )
        :effect (and
            (at end (is-complete ?task))
            (at end (move_pending ?robot))
        )
    )

    (:durative-action perform_uncontrollable_task
        :parameters (?robot ?task ?room)
        :duration (= ?duration 10)
        :condition (and
            (at start (robot ?robot))
            (at start (task ?task))
            (at start (room ?room))
            
            (at start (at ?robot ?room))
            (at start (is-uncontrollable ?task))
            (at start (is-in ?task ?room))
            (at start (task_pending ?robot))
        )
        :effect (and
            (at end (is-complete ?task))
            (at end (move_pending ?robot))
        )
    )
)
