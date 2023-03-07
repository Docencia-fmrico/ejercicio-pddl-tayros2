(define (domain robots-granny-house)
  (:requirements :typing :fluents :durative-actions :universal-preconditions :conditional-effects :continuous-effects)

  (:types
    room corridor - location
    open_door close_door - door_request
    bring_request
    robot gripper human door util
  )

  (:predicates
    (robot_at ?r - robot ?l - location)
    (object_at ?u - util ?l - location)
    (human_at ?h - human ?l - location)
    (human_attended ?h - human)
    (human_door_request ?h - human ?r - door_request ?ro - door)
    (human_bring_request ?h - human ?r - bring_request ?ro - util)
    (high_prio)
    (not_high_prio)
    (high_prio_util ?u - util)
    (gripper_free ?g - gripper)
    (gripper_at ?g - gripper ?r - robot)
    (robot_carry ?r - robot ?g - gripper ?u - util)
    (connected ?l1 ?l2 - location)
    (connected_by_door ?l1 ?l2 - location ?d - door)
    (open ?d - door)
    (close ?d - door)
  )

  (:durative-action open-door
    :parameters (?r - robot ?l1 ?l2 - location ?d - door)
    :duration (= ?duration 1)
    :condition (and
      (at start(robot_at ?r ?l1))
      (at start(close ?d))
      (at start(connected_by_door ?l1 ?l2 ?d))
    )
    :effect (and
      (at start(open ?d))
      (at end(not (close ?d)))
    )
  )

  (:durative-action move_by_door
    :parameters (?r - robot ?from ?to - location ?d - door)
    :duration (= ?duration 2)
    :condition (and
      (at start(robot_at ?r ?from))
      (at start(connected_by_door ?from ?to ?d)) 
      (at start (open ?d))
    )
    :effect (and
      (at start(not (robot_at ?r ?from)))
      (at end(robot_at ?r ?to))
    )
  )

  (:durative-action move_without_door
    :parameters (?r - robot ?from ?to - location)
    :duration (= ?duration 2)
    :condition (and
      (at start(robot_at ?r ?from))
      (at start(connected ?from ?to)) 
    )
    :effect (and
      (at start(not (robot_at ?r ?from)))
      (at end(robot_at ?r ?to))
    )
  )

  (:durative-action pick
    :parameters (?u - util ?l - location ?r - robot ?g - gripper)
    :duration(= ?duration 1)
    :condition (and
      (at start (not_high_prio))
      (at start(gripper_at ?g ?r))
      (at start(object_at ?u ?l))
      (at start(robot_at ?r ?l))
      (at start(gripper_free ?g))
    )
    :effect (and
      ;importantisimo indicar que el gancho deja de estar libre cuand empieza la accion
      (at start(not (gripper_free ?g)))
      (at end(not (object_at ?u ?l)))
      (at end(robot_carry ?r ?g ?u))
    )
  )

  (:durative-action pick_prio
    :parameters (?u - util ?l - location ?r - robot ?g - gripper)
    :duration(= ?duration 1)
    :condition (and
      (at start (high_prio))
      (at start(high_prio_util ?u))
      (at start(gripper_at ?g ?r))
      (at start(object_at ?u ?l))
      (at start(robot_at ?r ?l))
      (at start(gripper_free ?g))
    )
    :effect (and
      ;importantisimo indicar que el gancho deja de estar libre cuand empieza la accion
      (at start(not (gripper_free ?g)))
      (at end(not (object_at ?u ?l)))
      (at end(robot_carry ?r ?g ?u))
      (at start (not (high_prio)))
      (at start (not (high_prio_util ?u)))
      (at start (not_high_prio))
    )
  )

  (:durative-action drop
    :parameters (?u - util ?l - location ?r - robot ?g - gripper)
    :duration(= ?duration 1)
    :condition (and
      (at start(gripper_at ?g ?r))
      (at start(robot_at ?r ?l))
      (at start(robot_carry ?r ?g ?u))
    )
    :effect (and
      (at end(gripper_free ?g))
      (at end(object_at ?u ?l))
      (at end(not (robot_carry ?r ?g ?u)))
    )
  )
)
