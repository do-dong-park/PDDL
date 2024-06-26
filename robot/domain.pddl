(define (domain household_robot)
    (:requirements :strips :typing :fluents :durative-actions)

    (:predicates
        (can-move ?from ?to)
        (at ?robot ?room)
        (is-in ?task ?room)
        (is-complete ?task)
        (is-uncontrollable ?task)
        (is-controllable ?task)
        (is-available ?robot)

        (robot ?robot)
        (task ?task)
        (room ?room)
    )

    (:durative-action move
        :parameters (?robot ?from ?to)
        :duration (= ?duration 5) ; assuming it takes 5 units of time to move between rooms
        :condition (and
            (at start (robot ?robot))
            (at start (room ?from))
            (at start (room ?to))

            (at start (at ?robot ?from))
            
            (over all (can-move ?from ? to))
        )
        :effect (and
            (at start (not (at ?robot ?from)))
            
            (at end (at ?robot ?to))
        )
    )

    (:durative-action perform_controllable_task
        :parameters (?robot ?task ?room)
        :duration (= ?duration 10) ; assuming controllable tasks take 10 units of time
        :condition (and
            (at start (robot ?robot))
            (at start (task ?task))
            (at start (room ?room))

            (at start (at ?robot ?room))
            (over all (is-in ?task ?room))
            
            (at start (is-controllable ?task))
        )
        :effect (and
            (at end (is-complete ?task))
        )
    )

    (:durative-action perform_uncontrollable_task
        :parameters (?robot ?task ?room)
        :duration (= ?duration 10) ; assuming controllable tasks take 10 units of time
        :condition (and
            (at start (robot ?robot))
            (at start (task ?task))
            (at start (room ?room))

            (at start (at ?robot ?room))
            (at start (is-uncontrollable ?task))

            (over all (is-in ?task ?room))
        )
        :effect (and
            (at end (is-complete ?task))
        )
    )
)