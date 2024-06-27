(define (domain household_robot)
    (:requirements :strips :typing :fluents :durative-actions :constraints)

    (:types
        robot room task
    )

    (:predicates
        (can-move ?from ?to - room)
        (at ?robot - robot ?room - room)
        (is-in ?task - task ?room - room)
        (is-complete ?task - task)
        (is-detachable ?task - task)
        (is-non-detachable ?task - task)
        (is-start ?task - task)
        (is-end ?task - task)
        (next ?before_task ?after_task - task)
        (can-start ?task - task)
        (busy ?robot - robot)
        (available ?robot - robot)
    )

    (:functions
        (travel_time ?from ?to - room)
        (task_duration ?task - task)
        (waiting_time ?task - task)
    )

    (:durative-action move
        :parameters (?robot - robot ?from ?to - room)
        :duration (= ?duration (travel_time ?from ?to))
        :condition (and
            (over all (can-move ?from ?to))
            (at start (at ?robot ?from))

            (at start (available ?robot))
            (over all (busy ?robot))
        )
        :effect (and
            (at start (busy ?robot))

            (at end (at ?robot ?to))
            (at end (not (at ?robot ?from)))
            (at end (not (busy ?robot)))
            (at end (available ?robot))
        )
    )

    (:durative-action perform_non-detachable_task
        :parameters (?robot - robot ?task - task ?room - room)
        :duration (= ?duration (task_duration ?task))
        :condition (and
            (at start (at ?robot ?room))
            (at start (is-non-detachable ?task))
            (at start (is-in ?task ?room))

            (at start (available ?robot))
            (over all (busy ?robot))
        )
        :effect (and
            (at start (busy ?robot))

            (at end (is-complete ?task))
            (at end (not (busy ?robot)))
            (at end (available ?robot))
        )
    )

    (:durative-action perform_detachable_start_task
        :parameters (?robot - robot ?task - task ?room - room)
        :duration (= ?duration (task_duration ?task))
        :condition (and
            (at start (at ?robot ?room))
            (at start (is-start ?task))
            (at start (is-detachable ?task))
            (at start (is-in ?task ?room))

            (at start (available ?robot))
            (over all (busy ?robot))
        )
        :effect (and
            (at start (busy ?robot))

            (at end (is-complete ?task))
            (at end (not (busy ?robot)))
            (at end (available ?robot))
        )
    )

    (:durative-action perform_detachable_end_task
        :parameters (?robot - robot ?task - task ?room - room)
        :duration (= ?duration (task_duration ?task))
        :condition (and
            (at start (at ?robot ?room))
            (at start (is-end ?task))
            (at start (can-start ?task))
            (at start (is-detachable ?task))
            (at start (is-in ?task ?room))

            (at start (available ?robot))
            (over all (busy ?robot))
        )
        :effect (and
            (at start (busy ?robot))

            (at end (is-complete ?task))
            (at end (not (busy ?robot)))
            (at end (available ?robot))
        )
    )

    (:durative-action wait
        :parameters (?robot - robot ?before_task ?after_task - task)
        :duration (= ?duration (waiting_time ?before_task))
        :condition (and
            (at start (is-start ?before_task))
            (at start (is-end ?after_task))

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