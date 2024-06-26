(define (domain household_robot)
    (:requirements :strips :typing :fluents :durative-actions :constraints)

    (:predicates
        (can-move ?from ?to)
        (at ?robot ?room)

        (is-in ?task ?room)

        (is-complete ?task)
        (is-detachable ?task)
        (is-non-detachable ?task)

        (next ?before_task ?after_task)
        (can-start ?task)

        (robot ?robot)
        (task ?task)
        (room ?room)

        (busy ?robot)
        (available ?robot)
    )

    (:functions
        (cost)
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

            (at start (available ?robot))
            (over all (busy ?robot))
        )
        :effect (and
            (at start (busy ?robot))
            (at start (increase (cost) 5))

            (at end (at ?robot ?to))
            (at end (not (at ?robot ?from)))
            (at end (not (busy ?robot)))
            (at end (available ?robot))
        )
    )

    (:durative-action perform_non-detachable_task
        :parameters (?robot ?task ?room)
        :duration (= ?duration 5)
        :condition (and
            (at start (robot ?robot))
            (at start (task ?task))
            (at start (room ?room))

            (at start (at ?robot ?room))
            (at start (is-non-detachable ?task))
            (at start (is-in ?task ?room))

            (at start (available ?robot))
            (over all (busy ?robot))
        )
        :effect (and
            (at start (busy ?robot))
            (at start (increase (cost) 10))

            (at end (is-complete ?task))
            (at end (not (busy ?robot)))
            (at end (available ?robot))
        )
    )

    (:durative-action perform_detachable_task
        :parameters (?robot ?task ?room)
        :duration (= ?duration 10)
        :condition (and
            (at start (robot ?robot))
            (at start (task ?task))
            (at start (room ?room))

            (at start (at ?robot ?room))
            (at start (is-detachable ?task))
            (at start (is-in ?task ?room))

            (at start (available ?robot))
            (over all (busy ?robot))
        )
        :effect (and
            (at start (busy ?robot))
            (at start (increase (cost) 10))

            (at end (is-complete ?task))
            (at end (not (busy ?robot)))
            (at end (available ?robot))
        )
    )

    (:durative-action wait
        :parameters (?robot ?before_task ?after_task)
        :duration (= ?duration 5)
        :condition (and
            (at start (robot ?robot))
            (at start (task ?before_task))
            (at start (task ?after_task))

            (at start (is-detachable ?before_task))
            (at start (is-detachable ?after_task))
            (at start (is-complete ?before_task))
            (at start (next ?before_task ?after_task))
        )
        :effect (and
            (at end (can-start ?after_task))
        )
    )

)